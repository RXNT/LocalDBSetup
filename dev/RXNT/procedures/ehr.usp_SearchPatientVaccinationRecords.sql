SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 5-Sep-2017
-- Description:	To Get All patient vaccination record
-- Modified By: AFSAL Y
-- Modified Date: 23-Nov-2017
-- Description : V1QA-384
-- =============================================

CREATE       PROCEDURE [ehr].[usp_SearchPatientVaccinationRecords]

 @PatientId INT
AS
BEGIN

 SELECT a.VAC_PAT_ID,
	    a.VAC_REC_ID, 
		b.vac_name, 
		isnull(a.active, 1) as immunization_active_status, 
		G.vac_group_name as vac_base_name, 
		b.comments, 
		b.Expiration_Date, 
		vis_date, 
		vis_given_date, 
		a.VAC_ID, 
		VAC_PAT_ID, 
		VAC_DT_ADMIN, 
		VAC_LOT_NO, 
		VAC_SITE, 
		VAC_DOSE, 
		VAC_EXP_DATE, 
		VAC_DR_ID, 
		VAC_REACTION, 
		VAC_REMARKS,
		a.vac_site_code,
		a.vac_dose_unit_code,
		a.vac_administered_code,
		a.vac_administered_by,
		a.vac_entered_by,
		a.substance_refusal_reason_code,
		a.disease_code,
		a.VFC_Eligibility_Status,
		a.vfc_code,
		M.manufacturer_name as manufacturer ,
		a.route,
		b.cvx_code,
		NDC.NDC11,
		b.mvx_code,
		a.route_code,
		a.eligibility_category_code, 
		VGM.vac_group_id, 
		c.exportedDate, 
		d.dr_first_name,
		d.dr_last_name,
		d.professional_designation, 
		a.external_vac_rec_id,
		a.visibility_hidden_to_patient
 FROM tblVaccinationRecord a 
 INNER JOIN tblvaccines b on a.vac_id= b.vac_id  
 INNER JOIN tblvaccineCVX CVX ON b.CVX_CODE=CVX.cvx_code
 INNER JOIN tblVaccineCVXToVaccineGroupsMappings VGM ON VGM.cvx_id=CVX.cvx_id
 INNER JOIN tblvaccineGroups G ON G.vac_group_id=VGM.vac_group_id
 LEFT JOIN tblVaccineManufacturers M ON b.manufacturer_Id=M.manufacturer_Id
 LEFT OUTER JOIN doctors d with(nolock) On d.dr_id=a.vac_administered_by
 LEFT OUTER JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY [CVXCode] ORDER BY [is_active] DESC, [last_updated_date] DESC, [NDC11] DESC, [GTIN] DESC) AS [row_number]
			      FROM [RxNT].[dbo].[tblVaccineCVXToVaccineNDCMappings]) NDC ON b.CVX_CODE = NDC.CVXCode AND NDC.[row_number] = 1
 LEFT OUTER JOIN tblVaccinationQueue c on c.vac_rec_id=a.vac_rec_id AND c.queue_id =(SELECT TOP 1 queue_id 
																		       FROM tblVaccinationQueue
																			   WHERE vac_rec_id=a.vac_rec_id 
																			   AND isIncluded=1 
																			   AND exportedDate IS NOT NULL 
																			   ORDER BY exportedDate DESC) 
 WHERE vac_pat_id = @PatientId
 ORDER by VAC_DT_ADMIN desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
