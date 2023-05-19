SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to search patients merge request detail for batchid
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_GetPatientMergeRequestDetail]
(
	@CompanyId				BIGINT,
	@PatientMergeBatchId	BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;	

	select	mrq.pa_merge_batchid, mrq.pa_merge_reqid, primary_pa_id, secondary_pa_id, ms.status,
			prmpa.PA_ID As PrimaryPatientId, prmpa.DR_ID As PrimaryDoctorId, prmpa.PA_PREFIX AS PrimaryPrefix, prmpa.PA_SUFFIX AS PrimarySuffix, 
			prmpa.PA_LAST As PrimaryLast, prmpa.PA_FIRST As PrimaryFirst, prmpa.PA_FLAG As PrimaryFlag, 
			prmpa.PA_MIDDLE As PrimaryMiddle, prmpa.PA_SSN As PrimarySSN, prmpa.PA_ZIP As PrimaryZip, prmpa.PA_DOB As PrimaryDOB, 
			prmpa.PA_ADDRESS1 AS PrimaryAddress1, prmpa.PA_EMAIL As PrimaryEmail, prmpa.PA_ADDRESS2 AS PrimaryAddress2, prmpa.PA_CITY As PrimaryCity, 
			prmpa.PA_SEX As PrimarySex, prmpa.PA_STATE as PrimaryState, prmpa.PA_PHONE As PrimaryPhone, 
			prmpa.pa_ext_ssn_no As PrimaryExtSSNNo,
			secpa.PA_ID As SecondaryPatientId, secpa.DR_ID As SecondaryDoctorId, secpa.PA_PREFIX AS SecondaryPrefix, secpa.PA_SUFFIX AS SecondarySuffix, 
			secpa.PA_LAST As SecondaryLast, secpa.PA_FIRST As SecondaryFirst, secpa.PA_FLAG As SecondaryFlag, 
			secpa.PA_MIDDLE As SecondaryMiddle, secpa.PA_SSN As SecondarySSN, secpa.PA_ZIP As SecondaryZip, secpa.PA_DOB As SecondaryDOB, 
			secpa.PA_ADDRESS1 AS SecondaryAddress1, secpa.PA_EMAIL As SecondaryEmail, secpa.PA_ADDRESS2 AS SecondaryAddress2, secpa.PA_CITY As SecondaryCity, 
			secpa.PA_SEX As SecondarySex, secpa.PA_STATE as SecondaryState, secpa.PA_PHONE As SecondaryPhone, 
			secpa.pa_ext_ssn_no As SecondaryExtSSNNo
	from	dbo.Patient_merge_request_queue mrq WITH (NOLOCK)
			inner join  dbo.patient_merge_status ms WITH (NOLOCK) on mrq.status = ms.statusid 
			left join	dbo.patients prmpa WITH (NOLOCK) on mrq.primary_pa_id=prmpa.pa_id
			left join	dbo.patients secpa WITH (NOLOCK) on mrq.secondary_pa_id=secpa.pa_id
	where	mrq.pa_merge_batchid = @PatientMergeBatchId 
			AND mrq.active = 1		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
