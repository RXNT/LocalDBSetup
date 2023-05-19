SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 23-Feb-2018
-- Description:	Search patient Family Hx External
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetPFShExternalCount]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	
	Declare @SmokingCount as int
	
	Declare @MedicationCount as int
	Declare @AllergiesCount as int
	Declare @ImplantableCount as int
	Declare @SurgeryCount as int
	Declare @MedicalHxCount as int
	Declare @FamilyHxCount as int
	Declare @HospCount as int
	
	SELECT @SmokingCount=COUNT(1) FROM  [ehr].[PatientSmokingStatusDetailExternal] where PatientId = @PatientId
	SELECT @MedicationCount=COUNT(1) FROM  [ehr].[PatientPastHxMedicationExternal] where PatientId = @PatientId
	SELECT @AllergiesCount=COUNT(1) FROM  [ehr].[PatientPastHxAllergiesExternal] where PatientId = @PatientId
	SELECT @ImplantableCount=COUNT(1) FROM [ehr].[PatientImplantableDeviceExternal] where PatientId = @PatientId
	SELECT @SurgeryCount=COUNT(1) FROM [dbo].[patient_surgery_hx_external] where pse_pat_id = @PatientId
	SELECT @MedicalHxCount=COUNT(1) FROM [dbo].[patient_medical_hx_external] where pme_pat_id = @PatientId
	SELECT @FamilyHxCount=COUNT(1) FROM [dbo].[patient_family_hx_external] where pfhe_pat_id = @PatientId
	SELECT @HospCount=COUNT(1) FROM [dbo].[patient_hospitalization_hx_external] where phe_pat_id = @PatientId
	


	Select @SmokingCount + @MedicationCount + @AllergiesCount + @ImplantableCount + 
	@SurgeryCount+ @MedicalHxCount + @FamilyHxCount + @HospCount as PFSHExtCount		 
	Return 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
