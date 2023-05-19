SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 05-SEP-2017
-- Description:	To Search RxChange
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE   PROCEDURE [prv].[SearchChangeRx]
    @UserId int,
    @DoctorGroupId int,
    @IsRestrictToPersonalRx bit = 1,
    @IsAgent bit = 0,
    @PatientFirstName varchar(50) = NULL,
    @PatientLastName varchar(50) = NULL
WITH RECOMPILE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP 75
        CR.ChgReqId,
        CR.PriorAuthNum,
        DR.dr_last_name,
        DR.dr_first_name,
        DR.dr_phone,
        PA.pa_id,
        PA.pa_first,
        PA.pa_middle,
        PA.pa_flag,
        PA.pa_last,
        PA.pa_dob,
        PA.pa_sex,
        PA.pa_phone,
        PA.pa_ssn,
        PRES.pres_id,
        PRES.dg_id,
        PRES.pres_entry_date,
        PRES.pres_read_date,
        PRES.off_dr_list,
        PRES.only_faxed,
        PRES.pharm_id,
        PD.agent_info,
        PD.supervisor_info,
        PRES.prim_dr_id,
        PRES.fax_conf_send_date,
        PRES.fax_conf_numb_pages,
        PRES.fax_conf_remote_fax_id,
        PRES.fax_conf_error_string,
        PRES.pres_delivery_method,
        DR.time_difference,
        PRES.pres_approved_date,
        PRES.dr_id,
        PRES.pres_void,
        PRES.pres_void_comments,
        PD.ddid,
        PD.pd_id,
        PD.compound,
        PD.prn,
        PD.prn_description,
        PD.use_generic,
        PRES.pres_prescription_type,
        CASE
            WHEN DR.epcs_enabled IS NULL THEN
                0
            ELSE
                DR.epcs_enabled
        END doc_epcs_status,
        DR.NPI,
        CASE
            WHEN CR.MessageId IS NULL THEN
                ''
            ELSE
                CR.MessageId
        END MessageId,
        CASE
            WHEN CR.HasMissMatch IS NULL THEN
                0
            ELSE
                CR.HasMissMatch
        END has_miss_match,
        CR.MissMatchReason AS miss_match_reson,
        CR.ChgType,
        CASE
            WHEN CR.Date1Enum = 6 THEN
                CR.Date1
            WHEN CR.Date2Enum = 6 THEN
                CR.Date2
            WHEN CR.Date3enum = 6 THEN
                CR.Date3
            ELSE
                '1901-01-01'
        END requested_fill_date,
        CASE
            WHEN CR.DRUGNAME IS NULL THEN
                ''
            ELSE
                CR.DRUGNAME
        END drug_name,
        CASE
            WHEN CR.QTY1 IS NULL THEN
                ''
            ELSE
                CR.QTY1
        END duration_amount,
        CASE
            WHEN CR.QTY1UNITS IS NULL THEN
                ''
            ELSE
                CR.QTY1UNITS
        END duration_unit,
        CASE
            WHEN CR.RefillsType IS NULL THEN
                0
            WHEN CR.RefillsType = 4 THEN
                1
            ELSE
                0
        END refills_prn,
        CASE
            WHEN CR.REFILLS IS NULL THEN
                0
            ELSE
                CR.REFILLS
        END numb_refills,
        CASE
            WHEN CR.DOSAGE1 IS NULL THEN
                ''
            ELSE
                CR.DOSAGE1
        END dosage,
        CASE
            WHEN CR.COMMENTS1 IS NULL THEN
                ''
            ELSE
                CR.COMMENTS1
        END comments,
        CASE
            WHEN CR.DAYSSUPPLY IS NULL THEN
                -1
            ELSE
                CR.DAYSSUPPLY
        END days_supply,
        CASE
            WHEN CR.DocInfoText IS NULL THEN
                ''
            ELSE
                CR.DocInfoText
        END disp_doc_info_text,
        CASE
            WHEN PRES.DoPrintAfterPatHistory = 0
                 AND PRES.DoPrintAfterPatOrig = 0
                 AND PRES.DoPrintAfterPatCopy = 0
                 AND PRES.DoPrintAfterPatMonograph = 0 THEN
                0
            ELSE
                1
        END printOptionsSet,
        PD.hospice_drug_relatedness_id,
        PD.drug_indication,
        CR.NoOfMedicationsRequested,
        PD.order_reason
    INTO #RecentRxChangeRequests
    FROM dbo.prescriptions PRES WITH (NOLOCK)
        INNER JOIN dbo.prescription_details PD WITH (NOLOCK)
            ON PRES.pres_id = PD.pres_id
        INNER JOIN dbo.patients PA WITH (NOLOCK)
            ON PRES.pa_id = PA.pa_id
        INNER JOIN dbo.doctors DR WITH (NOLOCK)
            ON PRES.dr_id = DR.dr_id
        INNER JOIN erx.RxChangeRequests CR WITH (NOLOCK)
            ON CR.PresId = PRES.pres_id
    WHERE (
              PRES.pres_approved_date IS NULL
              AND ISNULL(CR.IsApproved, 0) = 0
          )
          AND (
                  ISNULL(PRES.pres_void, 0) = 0
                  AND ISNULL(CR.IsVoided, 0) = 0
              )
          AND (
                  (
                      (@IsRestrictToPersonalRx = 1)
                      AND (
                              (
                                  @IsAgent = 1
                                  AND PRES.PRIM_DR_ID = @UserId
                              )
                              OR (
                                     @IsAgent <> 1
                                     AND PRES.DR_ID = @UserId
                                 )
                          )
                  )
                  OR (
                         (@IsRestrictToPersonalRx <> 1)
                         AND (PRES.DG_ID = @DoctorGroupId)
                     )
              )
          AND PRES_PRESCRIPTION_TYPE = 5
          AND (
                  @PatientFirstName IS NULL
                  OR PA.pa_first LIKE @PatientFirstName + '%'
              )
          AND (
                  @PatientLastName IS NULL
                  OR PA.pa_last LIKE @PatientLastName + '%'
              )
    ORDER BY ChgReqId desc
    OPTION (MAXDOP 1);
    WITH ChangeRequestsInfo
    AS (SELECT RCI.*,
               ROW_NUMBER() OVER (PARTITION BY RCI.ChgReqId ORDER BY RCI.ChgReqInfoId ASC) AS rank
        FROM erx.RxChangeRequestsInfo RCI WITH (NOLOCK)
            INNER JOIN #RecentRxChangeRequests RRCR WITH (NOLOCK)
                ON RCI.ChgReqId = RRCR.ChgReqId
       )
    SELECT TOP 75
        RRCR.ChgReqId,
        RRCR.PriorAuthNum,
        RRCR.dr_last_name,
        RRCR.dr_first_name,
        RRCR.dr_phone,
        RRCR.pa_id,
        RRCR.pa_first,
        RRCR.pa_middle,
        RRCR.pa_flag,
        RRCR.pa_last,
        RRCR.pa_dob,
        RRCR.pa_sex,
        RRCR.pa_phone,
        RRCR.pa_ssn,
        RRCR.pres_id,
        RRCR.dg_id,
        RRCR.pres_entry_date,
        RRCR.pres_read_date,
        RRCR.off_dr_list,
        RRCR.only_faxed,
        RRCR.pharm_id,
        RRCR.agent_info,
        RRCR.supervisor_info,
        RRCR.prim_dr_id,
        RRCR.fax_conf_send_date,
        RRCR.fax_conf_numb_pages,
        RRCR.fax_conf_remote_fax_id,
        RRCR.fax_conf_error_string,
        RRCR.pres_delivery_method,
        RRCR.time_difference,
        RRCR.pres_approved_date,
        RRCR.dr_id,
        RRCR.pres_void,
        RRCR.pres_void_comments,
        RRCR.ddid,
        RRCR.pd_id,
        RRCR.compound,
        RRCR.prn,
        RRCR.prn_description,
        RRCR.use_generic,
        RRCR.pres_prescription_type,
        dbo.pharmacies.pharm_company_name,
        dbo.pharmacies.pharm_address1,
        dbo.pharmacies.pharm_address2,
        dbo.pharmacies.pharm_city,
        dbo.pharmacies.pharm_state,
        dbo.pharmacies.pharm_zip,
        dbo.pharmacies.pharm_phone,
        dbo.pharmacies.pharm_fax,
        CASE
            WHEN dbo.pharmacies.service_level IS NULL THEN
                0
            ELSE
                dbo.pharmacies.service_level
        END pharm_service_level,
        RRCR.doc_epcs_status,
        RRCR.NPI,
        RRCR.MessageId,
        RRCR.has_miss_match,
        RRCR.miss_match_reson,
        RRCR.ChgType,
        CASE
            WHEN RCI.Date1Enum = 6 THEN
                RCI.Date1
            WHEN RCI.Date2Enum = 6 THEN
                RCI.Date2
            WHEN RCI.Date3Enum = 6 THEN
                RCI.Date3
            ELSE
                '1901-01-01'
        END fill_date,
        RRCR.requested_fill_date,
        RRCR.drug_name,
        RRCR.duration_amount,
        RRCR.duration_unit,
        RRCR.refills_prn,
        RRCR.numb_refills,
        RRCR.dosage,
        RRCR.comments,
        RRCR.days_supply,
        CASE
            WHEN RCI.DRUGNAME IS NULL THEN
                ''
            ELSE
                RCI.DRUGNAME
        END REQUESTED_DRUG_NAME,
        CASE
            WHEN RCI.QTY1 IS NULL THEN
                ''
            ELSE
                RCI.QTY1
        END REQUESTED_QUANTITY,
        CASE
            WHEN RCI.QTY1UNITS IS NULL THEN
                ''
            ELSE
                RCI.QTY1UNITS
        END REQUESTED_QUANTITY_UNITS,
        CASE
            WHEN RCI.RefillsType IS NULL THEN
                0
            WHEN RCI.RefillsType = 4 THEN
                1
            ELSE
                0
        END REQUESTED_REFILLS_PRN,
        CASE
            WHEN RCI.REFILLS IS NULL THEN
                0
            ELSE
                RCI.REFILLS
        END REQUESTED_REFILLS,
        CASE
            WHEN RCI.DOSAGE1 IS NULL THEN
                ''
            ELSE
                RCI.DOSAGE1
        END REQUESTED_DOSAGE1,
        CASE
            WHEN RCI.DOSAGE2 IS NULL THEN
                ''
            ELSE
                RCI.DOSAGE2
        END REQUESTED_DOSAGE2,
        CASE
            WHEN RCI.COMMENTS1 IS NULL THEN
                ''
            ELSE
                RCI.COMMENTS1
        END REQUESTED_COMMENTS1,
        CASE
            WHEN RCI.COMMENTS2 IS NULL THEN
                ''
            ELSE
                RCI.COMMENTS2
        END REQUESTED_COMMENTS2,
        CASE
            WHEN RCI.COMMENTS3 IS NULL THEN
                ''
            ELSE
                RCI.COMMENTS3
        END REQUESTED_COMMENTS3,
        CASE
            WHEN RCI.DAYSSUPPLY IS NULL THEN
                -1
            ELSE
                RCI.DAYSSUPPLY
        END REQUESTED_DAYS_SUPPLY,
        RRCR.disp_doc_info_text,
        CASE
            WHEN RCI.DocInfoText IS NULL THEN
                ''
            ELSE
                RCI.DocInfoText
        END mn_doc_info_text,
        CASE
            WHEN RCI.SubstitutionCode IS NULL THEN
                1
            WHEN
            (
                RCI.SubstitutionCode = 7
                Or RCI.SubstitutionCode = 1
            ) THEN
                0
            ELSE
                1
        END REQUESTED_USE_GENERIC,
        RRCR.printOptionsSet,
        CASE
            WHEN med_ref_dea_cd IS NULL THEN
                0
            ELSE
                med_ref_dea_cd
        END DRUGLEVEL,
        RRCR.hospice_drug_relatedness_id,
        hdr.Code,
        hdr.Description,
        RRCR.drug_indication,
        PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME,
        PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,
        dbo.pharmacies.ncpdp_numb AS Pharm_NCPDP,
        dbo.pharmacies.NPI AS Pharm_NPI,
        RRCR.NoOfMedicationsRequested,
        RCI.ChgReqInfoId ChangeRequestInfoId,
        RRCR.order_reason
    FROM #RecentRxChangeRequests RRCR
        LEFT OUTER JOIN Doctors PRIM_DOCS WITH (NOLOCK)
            on RRCR.prim_dr_id = PRIM_DOCS.DR_ID
        LEFT OUTER JOIN RMIID1 WITH (NOLOCK)
            ON RRCR.ddid = dbo.RMIID1.MEDID
        LEFT OUTER JOIN dbo.pharmacies WITH (NOLOCK)
            ON RRCR.pharm_id = dbo.pharmacies.pharm_id
        LEFT OUTER JOIN hospice_drug_relatedness hdr WITH (NOLOCK)
            ON RRCR.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
        LEFT OUTER JOIN ChangeRequestsInfo RCI
            ON RCI.ChgReqId = RRCR.ChgReqId
               AND RCI.rank = 1
    ORDER BY ChgReqId DESC

    DROP TABLE #RecentRxChangeRequests
    RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
