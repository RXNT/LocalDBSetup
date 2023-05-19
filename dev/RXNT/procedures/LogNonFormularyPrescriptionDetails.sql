SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-JAN-2018
-- Description:		Log Non-Formulary Prescription Details
-- =============================================
CREATE PROCEDURE [dbo].[LogNonFormularyPrescriptionDetails]
	@DoctorId								BIGINT,
	@DoctorGroupId							BIGINT,
	@PrimDoctorId							BIGINT,
	@MainDoctorId							BIGINT,
	@PatientId								BIGINT,
	@MedId									BIGINT,
	@DrugName								VARCHAR(500)=NULL
AS
BEGIN
 
	DECLARE @PatExtCoverageId AS BIGINT=0
	DECLARE @FormularyId AS VARCHAR(100)=NULL
	DECLARE @DoctorLastName VARCHAR(50)=NULL
	DECLARE @DoctorFirstName VARCHAR(50)=NULL
	DECLARE @PatientLastName VARCHAR(50)=NULL
	DECLARE @PatientFirstName VARCHAR(50)=NULL
	
	SELECT TOP 1 @PatExtCoverageId=pci_id,@FormularyId=formulary_id FROM patients_coverage_info_external WHERE pa_id=@PatientId
	
	SELECT TOP 1 @DoctorFirstName=dr_first_name, @DoctorLastName=dr_last_name FROM doctors WHERE dr_id=@DoctorId
	
	SELECT TOP 1 @PatientFirstName=pa_first, @PatientLastName=pa_last FROM patients WHERE pa_id=@PatientId
 
	INSERT INTO [dbo].[NonFormularyPrescriptionsLog]
	(DoctorGroupId, DoctorId, DoctorLastName, DoctorFirstName, PrimDoctorId, MainDoctorId, PatientId, PatientLastName, PatientFirstName, MedId, DrugName, PatientExtCoverageId, FormularyId, EntryDate, CreatedDate, CreatedBy)
	VALUES(@DoctorGroupId, @DoctorId, @DoctorLastName, @DoctorFirstName, @PrimDoctorId, @MainDoctorId, @PatientId, @PatientLastName, @PatientFirstName, @MedId, @DrugName,@PatExtCoverageId, @FormularyId, GETDATE(), GETDATE(), @DoctorId)
 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
