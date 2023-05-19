SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[processEvents_Archive]
AS
DECLARE @ID AS INTEGER,
        @PDID AS INTEGER,
        @NextFireDate AS DATETIME,
        @EventType AS INTEGER,
        @FireCount AS INTEGER,
        @RepeatUnit AS VARCHAR(2),
        @RepeatInterval AS INTEGER,
        @RepeatCount AS INTEGER,
        @EventFlags AS INTEGER,
        @DeliveryMethod AS INTEGER,
        @PrescType As TINYINT,
        @BitMask AS BIGINT,
        @DeliveryFlags AS INTEGER,
        @TransFlags AS INTEGER,
        @NewPresID AS INTEGER,
        @NewPDID AS INTEGER,
        @NewPresVoid AS BIT,
        @NewApprovedDate AS DATETIME

DECLARE event_records CURSOR READ_ONLY FOR
SELECT se_id,
       A.pd_id,
       next_fire_date,
       event_type,
       fire_count,
       repeat_unit,
       repeat_interval,
       repeat_count,
       event_flags
FROM scheduled_events A
    inner join prescription_details_archive B
        on A.pd_id = B.pd_id
WHERE next_fire_date <= GETDATE()
      AND first_fire_date <= GETDATE()
      AND (
              (repeat_count = 0)
              OR (repeat_count > fire_count)
          )

OPEN event_records
FETCH NEXT FROM event_records
INTO @ID,
     @PDID,
     @NextFireDate,
     @EventType,
     @FireCount,
     @RepeatUnit,
     @RepeatInterval,
     @RepeatCount,
     @EventFlags
WHILE (@@FETCH_STATUS <> -1)
BEGIN
    IF (@EventType <> 0x10000)
    -- Recurring Prescription.  Process it accordingly
    BEGIN
        IF NOT EXISTS
        (
            SELECT see_id
            FROM scheduled_events_exclusions
            WHERE se_id = @ID
                  AND exclusion_date = @NextFireDate
        )
        -- No Exclusions.  Process the event.
        BEGIN
            IF @EventFlags = 0x00
            -- Add the new Rx to the pending queue
            BEGIN
                SET @NewApprovedDate = NULL
            END
            ELSE IF @EventFlags = 0x01
            -- Approve the new Rx
            BEGIN
                SET @NewApprovedDate = @NextFireDate
            END
            -- Copy the appropriate prescription to generate a new Rx
            INSERT INTO prescriptions
            (
                dr_id,
                dg_id,
                pharm_id,
                pa_id,
                pres_entry_date,
                pres_is_refill,
                rx_number,
                pres_delivery_method,
                authorizing_dr_id,
                prim_dr_id,
                last_edit_date,
                last_edit_dr_id,
                pres_prescription_type,
                DoPrintAfterPatHistory,
                DoPrintAfterPatOrig,
                DoPrintAfterPatCopy,
                PatOrigPrintType,
                DoPrintAfterPatMonograph,
                DoPrintAfterScriptGuide,
                PrintHistoryBackMonths,
                pres_void,
                pres_approved_date
            )
            SELECT dr_id,
                   dg_id,
                   pharm_id,
                   pa_id,
                   @NextFireDate,
                   pres_is_refill,
                   rx_number,
                   pres_delivery_method,
                   authorizing_dr_id,
                   prim_dr_id,
                   @NextFireDate,
                   last_edit_dr_id,
                   1,
                   DoPrintAfterPatHistory,
                   DoPrintAfterPatOrig,
                   DoPrintAfterPatCopy,
                   PatOrigPrintType,
                   DoPrintAfterPatMonograph,
                   DoPrintAfterScriptGuide,
                   PrintHistoryBackMonths,
                   0,
                   @NewApprovedDate
            FROM prescriptions_archive
            WHERE EXISTS
            (
                SELECT pres_id
                FROM prescription_details_archive
                WHERE pd_id = @PDID
                      AND pres_id = prescriptions_archive.pres_id
            )
            IF @@ROWCOUNT <> 0
            BEGIN
                SELECT @NewPresID = SCOPE_IDENTITY()
                -- Copy the appropriate prescription details to the New Rx
                INSERT INTO prescription_details
                (
                    drug_name,
                    pres_id,
                    ddid,
                    dosage,
                    use_generic,
                    numb_refills,
                    days_supply,
                    comments,
                    duration_amount,
                    duration_unit,
                    prn,
                    as_directed,
                    patient_delivery_method,
                    include_in_print,
                    include_in_pharm_deliver,
                    prn_description,
                    ndc,
                    actual
                )
                SELECT drug_name,
                       @NewPresID,
                       ddid,
                       dosage,
                       use_generic,
                       numb_refills,
                       days_supply,
                       comments,
                       duration_amount,
                       duration_unit,
                       prn,
                       as_directed,
                       patient_delivery_method,
                       include_in_print,
                       include_in_pharm_deliver,
                       prn_description,
                       ndc,
                       actual
                FROM prescription_details_archive
                WHERE pd_id = @PDID
                SELECT @NewPDID = SCOPE_IDENTITY()
                INSERT INTO event_generated_prescriptions
                (
                    pd_id,
                    parent_pd_id,
                    fire_date,
                    se_id
                )
                VALUES
                (@NewPDID, @PDID, @NextFireDate, @ID)
                IF @EventFlags = 0x01
                -- Automatic Prescription.  Add it to the appropriate Transmittals Queues
                BEGIN
                    SELECT @DeliveryMethod = pres_delivery_method,
                           @PrescType = pres_prescription_type
                    FROM prescriptions
                    WHERE pres_id = @NewPresID
                    SET @BitMask = 1
                    WHILE (@BitMask <= CONVERT(BIGINT, 0xFFFF0000))
                          AND (
                                  (@BitMask <= @DeliveryMethod)
                                  OR ((@BitMask & @DeliveryMethod) <> 0)
                              )
                    BEGIN
                        IF ((@DeliveryMethod & @BitMask) <> 0)
                        BEGIN
                            SET @DeliveryFlags = (@DeliveryMethod & @BitMask)
                            SET @TransFlags = CASE @BitMask
                                                  WHEN 0x01 THEN
                                                      1
                                                  ELSE
                                                      0
                                              END
                            EXEC insertPrescriptionTransmittal @NewPDID,
                                                               @DeliveryFlags,
                                                               @TransFlags,
                                                               @PrescType
                        END
                        SET @BitMask = @BitMask * 2
                        -- Max Delivery Method
                        IF @BitMask = 0x40000
                        BEGIN
                            SET @BitMask = CONVERT(BIGINT, 0xFFFF0000)
                        END
                    END
                END
            END
        END
        IF (@FireCount + 1 < @RepeatCount)
           OR (@RepeatCount = 0)
        -- Not the Ending Instance.  Increment the Fire Count and also increment the Next Fire Date based on the Repeat Unit and Repeat Count
        BEGIN
            EXEC ('UPDATE scheduled_events SET fire_count = ' + @FireCount + ' + 1, next_fire_date = DATEADD(' + @RepeatUnit + ', ' + @RepeatInterval + ', next_fire_date) WHERE se_id = ' + @ID)
        END
        ELSE
        -- Ending Instance.  Just increment the Fire Count.  This event doesn't fire further.
        BEGIN
            UPDATE scheduled_events
            SET fire_count = @FireCount + 1
            WHERE se_id = @ID
        END
    END
    FETCH NEXT FROM event_records
    INTO @ID,
         @PDID,
         @NextFireDate,
         @EventType,
         @FireCount,
         @RepeatUnit,
         @RepeatInterval,
         @RepeatCount,
         @EventFlags
END

CLOSE event_records
DEALLOCATE event_records
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
