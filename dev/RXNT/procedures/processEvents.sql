SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[processEvents]
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
--SELECT se_id, pd_id, next_fire_date, event_type, fire_count, 
--  repeat_unit, repeat_interval, repeat_count, event_flags FROM scheduled_events A WITH(NOLOCK) inner join doctors B WITH(NOLOCK) on A.for_user_id=B.dr_id WHERE 
--  B.dr_enabled=1 and next_fire_date <= GETDATE() AND first_fire_date <= GETDATE() AND
--  ((repeat_count = 0) OR (repeat_count > fire_count))

SELECT se_id,
       a.pd_id,
       next_fire_date,
       event_type,
       fire_count,
       repeat_unit,
       repeat_interval,
       repeat_count,
       event_flags
FROM scheduled_events A WITH (NOLOCK)
    inner join doctors B WITH (NOLOCK)
        on A.for_user_id = B.dr_id
    INNER JOIN prescription_details pd WITH (NOLOCK)
        ON a.PD_ID = PD.PD_ID
    INNER JOIN PRESCRIPTIONS P WITH (NOLOCK)
        ON pd.PRES_ID = P.PRES_ID
    INNER JOIN DOC_GROUPS dg WITH (NOLOCK)
        ON P.dg_id = DG.dg_id
    INNER JOIN doc_companies DC WITH (NOLOCK)
        ON DG.dc_id = DC.dc_id
WHERE B.dr_enabled = 1
      and next_fire_date <= GETDATE()
      AND first_fire_date <= GETDATE()
      AND (
              (repeat_count = 0)
              OR (repeat_count > fire_count)
          )
      and P.dg_id > 0
      AND DG.dc_id > 0
      AND DC.dc_id > 0
      AND DG.dg_id = B.dg_id

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
    IF (@EventType = 0x10000)
    -- Delayed Prescription.  Process it accordingly
    BEGIN
        -- Increment the fire count
        UPDATE scheduled_events
        SET fire_count = @FireCount + 1
        WHERE se_id = @ID
        IF @EventFlags = 0x00
        -- Approval Required.  Unset the void flag to show up under the 'Approval Required'
        BEGIN
            -- 'Remove Signature (soft delete for tracking purpose)
            update scheduled_rx_archive
            set pd_id = -pd_id,
                pres_id = -pres_id
            where pd_id = @PDID

            UPDATE prescriptions
            SET pres_void = 0,
                pres_approved_date = NULL
            FROM prescriptions,
                 prescription_details
            WHERE pd_id = @PDID
                  AND prescriptions.pres_id = prescription_details.pres_id

        END
        ELSE IF @EventFlags = 0x01
        -- Automatic Approval.  Approve it and add it to the appropriate transmittals queue
        BEGIN
            UPDATE prescriptions
            SET pres_void = 0,
                pres_approved_date = GETDATE()
            FROM prescriptions,
                 prescription_details
            WHERE pd_id = @PDID
                  AND prescriptions.pres_id = prescription_details.pres_id
            SELECT @DeliveryMethod = pres_delivery_method,
                   @PrescType = pres_prescription_type
            FROM prescriptions
            WHERE EXISTS
            (
                SELECT pd_id
                FROM prescription_details
                WHERE pres_id = prescriptions.pres_id
                      AND pd_id = @PDID
            )
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
                    BEGIN TRY
                        EXEC insertPrescriptionTransmittal @PDID,
                                                           @DeliveryFlags,
                                                           @TransFlags,
                                                           @PrescType
                    END TRY
                    BEGIN CATCH
                    END CATCH
                END
                SET @BitMask = @BitMask * 2
                -- Maximum delivery method
                IF @BitMask = 0x40000
                BEGIN
                    SET @BitMask = CONVERT(BIGINT, 0xFFFF0000)
                END
            END
        END
    END
    ELSE
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
            FROM prescriptions
            WHERE EXISTS
            (
                SELECT pres_id
                FROM prescription_details
                WHERE pd_id = @PDID
                      AND pres_id = prescriptions.pres_id
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
                FROM prescription_details
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
