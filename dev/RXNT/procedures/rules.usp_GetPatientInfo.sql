SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	14-MAR-2018
Description			:	This procedure is used to Get Patient Infor

=======================================================================================
*/
CREATE PROCEDURE [rules].[usp_GetPatientInfo]	
	@PatientId			BIGINT	
AS
BEGIN
	SELECT SLC.Code,SLC.Description as LonicDesc, P.PA_ID, P.DR_ID, P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.pa_birthName, P.PA_FLAG, P.PA_SSN, P.PA_ZIP, P.PA_DOB,P.PA_EMAIL, P.PA_ADDRESS1, P.PA_ADDRESS2, P.PA_CITY, P.PA_SEX, P.PA_STATE, P.PA_PHONE,pa_ext_ssn_no,pa_ins_type,pa_race_type,pa_ethn_type,pref_lang,'' CELL_PHONE, '' pa_merge_batchid, '' primary_pa_id  FROM PATIENTS P
                left join ehr.ApplicationTableConstants ATC WITH(NOLOCK)  on ATC.Code = P.pa_sex 
                left join ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATC.ApplicationTableId 
                left join ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATC.Code 
                left join ehr.SysLookupCodeSystem SLCS WITH(NOLOCK) on SLCS.CodeSystemId = SLC.CodeSystemId 
                 WHERE (AT.Code = 'ADGEN' OR AT.Code IS NULL) and(SLCS.CodeSystem = 'AdministrativeGender' 
				 OR SLCS.CodeSystem IS NULL)  AND P.PA_ID =@PatientId
           
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
