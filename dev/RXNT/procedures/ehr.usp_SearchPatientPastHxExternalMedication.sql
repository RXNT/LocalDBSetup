SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	VINOD
Create date			:	16-Feb-2018
Description			:	Search Patient Past medication External
Last Modified By	:   Ayja Weems
Last Modifed Date	:   27-Dec-2022
=======================================================================================
*/
 CREATE   PROCEDURE [ehr].[usp_SearchPatientPastHxExternalMedication]
    @PatientId			BIGINT
AS
BEGIN

    SELECT DISTINCT PatientPastHxMedicationExtId, A.DRUGID, R.MED_REF_DEA_CD drugclass,
        CASE WHEN A.DRUGID <= -1 THEN A.DRUGNAME ELSE R.MED_MEDID_DESC END  DRUGNAME,
        I.ETC_ID, I.ETC_NAME, CreatedDate, A.COMMENTS, PrescriptionDetailId, A.RecordSource, A.Reason,
        DR.DR_FIRST_NAME, DR.DR_LAST_NAME, AD.IS_ACTIVE, A.dosage, A.DurationAmount, A.Active,
        A.DurationUnit, A.DrugComments, A.UseGeneric, A.numb_refills,
        A.DaysSupply, A.prn, A.PrnDescription, A.DateStart, A.DateEnd,
        R1.EVD_EXT_VOCAB_ID as RxNormCode, AD.MEDID ACTIVEDDID, p.pres_prescription_type
    FROM PatientPastHxMedicationExternal A WITH(NOLOCK)
        LEFT OUTER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=A.PrescriptionDetailId
        LEFT OUTER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
        LEFT OUTER JOIN RMIID1 R WITH(NOLOCK) ON A.DRUGID = R.MEDID
        LEFT OUTER JOIN RETCMED0 H WITH(NOLOCK) ON R.MEDID = H.MEDID
        LEFT OUTER JOIN DBO.RETCTBL0 I WITH(NOLOCK) ON H.ETC_ID = I.ETC_ID
        LEFT OUTER JOIN DOCTORS DR WITH(NOLOCK) ON A.CreatedBy = DR.DR_ID
        LEFT OUTER JOIN ACTIVE_DRUGS AD WITH(NOLOCK) ON R.MEDID = AD.MEDID
        LEFT OUTER JOIN REVDEL0 R1 WITH(NOLOCK) ON R1.EVD_FDB_VOCAB_ID = A.DrugId
    WHERE A.PatientId = @PatientId AND (H.ETC_DEFAULT_USE_IND IS NULL or H.ETC_DEFAULT_USE_IND = 1)
    ORDER BY A.PatientPastHxMedicationExtId DESC, CreatedDate DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
