SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <03-01-2016>
-- Description:	<Insert/Update patient diagnosis>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SavePatientDiagnosis]
	-- Add the parameters for the stored procedure here
	@DiagICD varchar(50),
	@DiagDescription varchar(50),
	@DiagOnsetDate datetime,
	@DiagCodeSet varchar(50),
	@patientId bigint
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@DiagCodeSet='ICD10' or @DiagCodeSet='icd10')
	Begin
		If exists(Select * from patient_active_diagnosis WITH(NOLOCK) Where icd10=@DiagICD and pa_id=@patientId)
		Begin
			Update patient_active_diagnosis Set icd10_desc=@DiagDescription, onset=@DiagOnsetDate , record_modified_date=GETDATE()
			Where icd10=@DiagICD and pa_id=@patientId
		End
		Else
		Begin
			Insert into patient_active_diagnosis(pa_id,icd9,icd10,date_added,enabled,onset,icd10_desc,added_by_dr_id)
			Values(@patientId,@DiagICD,@DiagICD,GETDATE(),1,@DiagOnsetDate,@DiagDescription,0)
		End
	End
	Else if(@DiagCodeSet='ICD9' or @DiagCodeSet='icd9')
	Begin
		If exists(Select * from patient_active_diagnosis WITH(NOLOCK) Where icd9=@DiagICD and pa_id=@patientId)
		Begin
			Update patient_active_diagnosis Set icd9_desc=@DiagDescription, onset=@DiagOnsetDate , record_modified_date=GETDATE()
			Where icd9=@DiagICD and pa_id=@patientId
		End
		Else
		Begin
			Insert into patient_active_diagnosis(pa_id,icd9,date_added,enabled,onset,icd9_desc,added_by_dr_id)
			Values(@patientId,@DiagICD,GETDATE(),1,@DiagOnsetDate,@DiagDescription,0)
		End
	End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
