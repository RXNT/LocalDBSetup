SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- Create date: 31/10/2022  
-- Description: To get the Patient Immunization  
-- =============================================  
  
CREATE   PROCEDURE [cqm2022].[usp_SearchPatientImmunization_CMS68v12_NQF0419]    
 @PatientId BIGINT,   
 @DoctorId BIGINT,   
 @StartDate Date,  
 @EndDate Date   
AS  
BEGIN  

DECLARE @RequestId BIGINT  
SELECT @RequestId = MAX(RequestId) FROM  cqm2022.[DoctorCQMCalculationRequest] R   
WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1  
IF @RequestId>0  
BEGIN  
	SELECT DISTINCT  pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate,
	a.VAC_PAT_ID,a.VAC_REC_ID, b.vac_name, G.vac_group_name as vac_base_name, b.comments, b.Expiration_Date, 
	vis_date, vis_given_date, a.VAC_ID, VAC_PAT_ID, VAC_DT_ADMIN, VAC_LOT_NO, VAC_SITE, VAC_DOSE, 
	VAC_EXP_DATE, VAC_DR_ID, VAC_REACTION, VAC_REMARKS,a.vac_site_code,a.vac_dose_unit_code,
	a.vac_administered_code,a.vac_administered_by,a.vac_entered_by,a.substance_refusal_reason_code,
	a.disease_code,a.VFC_Eligibility_Status,a.vfc_code,M.manufacturer_name as manufacturer ,a.route,b.cvx_code,b.mvx_code,a.route_code,
	a.eligibility_category_code, VGM.vac_group_id,
	d.dr_first_name,d.dr_last_name,d.professional_designation 
	,isnull(a.active, 1) as immunization_active_status,
	deletedby.dr_first_name as immunization_dr_fname,deletedby.dr_last_name  as immunization_dr_lname,a.[last_modified_date] as immunization_deleted_on
	FROM cqm2022.PatientImmunizationCodes pec WITH(NOLOCK)  
	INNER JOIN cqm2022.SysLookupCMS68v12_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId  
	INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId  
	INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 8 --Immunization  
	inner join  tblVaccinationRecord a ON a.VAC_REC_ID = pec.VaccinationRecordId
	inner join tblvaccines b on a.vac_id= b.vac_id  
	inner join  tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
	inner join tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
	Inner Join tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
	Inner JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
	Left Outer Join doctors d with(nolock) On d.dr_id=a.vac_administered_by
	Left Outer Join doctors deletedby with(nolock) On deletedby.dr_id=a.last_modified_by
	where pec.PatientId = @PatientId  AND pec.DoctorId=@DoctorId 
 END  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
