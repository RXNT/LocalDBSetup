SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Ramakrishna
-- Create date: 	24-Nov-2016
-- Description:		Enable Vitas Group Permissions
-- =============================================
CREATE PROCEDURE [dbo].[EnableVitasGroupPermissions]

	@DoctorGroupId		INT

AS
BEGIN
	-- This is for enable group permissions for Prescription Structured Sig page and actions will be 'View' and 'Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Prescription Structured Sig', @ActionName = 'View '				
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Prescription Structured Sig', @ActionName= 'Add'
	
	-- This is for enable group permissions for Patient Allergy page and actions will be 'Disable Edit', 'Disable Delete', 'Disable Update' and 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Allergy', @ActionName = 'DisableEdit'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Allergy', @ActionName = 'DisableDelete'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Allergy', @ActionName= 'DisableUpdate'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Allergy', @ActionName = 'DisableAdd'
	
	-- This is for enable group permissions for Patient Diagnosis page and actions will be 'Disable Edit', 'Disable Delete', 'Disable Update' and 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Diagnosis', @ActionName = 'DisableEdit'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Diagnosis', @ActionName= 'DisableDelete'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Diagnosis', @ActionName = 'DisableUpdate'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Diagnosis', @ActionName = 'DisableAdd'
	
	-- This is for enable group permissions for Prescription Pharmacist Note page and action will be 'Required'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Prescription Pharmacist Notes', @ActionName= 'Required'
	
	-- This is for enable group permissions for Patient Current Medications page and actions will be 'Disable Edit', 'Disable Delete', 'Disable View' and 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Current Medications', @ActionName = 'DisableEdit'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Current Medications', @ActionName= 'DisableDelete'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Current Medications', @ActionName = 'DisableAdd'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Patient Current Medications', @ActionName = 'DisableView'
	
	-- This is for enable group permissions for Drug Search page and action will be 'Disable View'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Drug Search', @ActionName= 'DisableView'
	
	-- This is for enable group permissions for Favorite Drugs page and action will be 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription', @PageName	= 'Favorite Drugs', @ActionName = 'DisableAdd'
	
	-- This is for enable group permissions for Hospice Drug Relatedness page and action will be 'Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Hospice Drug Relatedness', @ActionName = 'Add'
	
	-- This is for enable group permissions for Discharge Rx page and actions will be 'Disable Discharge', 'Disable ReInstate', and 'Enable Discharge Workflow'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Discharge Rx', @ActionName = 'DisableDischarge'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Discharge Rx', @ActionName= 'DisableReInstate'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Discharge Rx', @ActionName = 'EnableDischargeWorkflow'
	
	-- This is for enable group permissions for CML page and actions will be 'View'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'CML', @ActionName= 'View '
	
	-- This is for enable group permissions for Demographics page and actions will be 'Disable Edit', 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Demographics', @ActionName = 'DisableEdit'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Patient Dashboard', @PageName	= 'Demographics', @ActionName = 'DisableAdd'
	
	-- This is for enable group permissions for PRN page and action will be 'Required'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'PRN', @ActionName = 'Required'
	
	-- This is for enable group permissions for PRN Indicator page and action will be 'Required'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'PRN Indicator', @ActionName= 'Required'
	
	-- This is for enable group permissions for Days Supply page and action will be 'Disable Edit'
	--Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Days Supply', @ActionName= 'DisableEdit'
	
	-- This is for enable group permissions for Recommended Sigs page and action will be 'Disable Edit'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Recommended Sig', @ActionName= 'DisableView'
	
	-- This is for enable group permissions for CustomSigs page and action will be 'Disable Add'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Custom Sigs', @ActionName= 'DisableAdd'
	
	-- This is for enable group permissions for Create New Sigs page and action will be 'Disable View'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Create New Sig', @ActionName= 'DisableView'
	
	-- This is for enable group permissions for Refills page and action will be 'Disable View'
	Exec  [dbo].[InsertGroupPermissions] @dg_id = @DoctorGroupId, @ModuleName = 'Prescription',	@PageName	= 'Refills', @ActionName= 'DisableView'
	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
