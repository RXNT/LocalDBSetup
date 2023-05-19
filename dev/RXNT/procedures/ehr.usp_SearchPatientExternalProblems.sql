SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 24-Oct-2017
-- Description:	To Search Patient External Problems
-- Mod1ified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientExternalProblems]
  @PatientId INT
AS
BEGIN
	
	select	pde.pde_source_name as record_source,
	 pde_icd9 as icd9,pde.pde_pa_id,
	 pde_icd9_description as icd9_description,
	 pde_icd10 as ICD10,
	 pde_snomed as SNOMED,
	   CONVERT(DATE, pde.pde_date_added) DATE_ADDED, 
	pde_severity as [Severity],
	pde_onset as OnSet,
	last_modified_date
	 --Case When pde_onset is null Then 'UnKnown' Else  CONVERT(VARCHAR(10),pde_onset, 101) End OnSet
	 from dbo.patient_active_diagnosis_external	pde	with(nolock)
	 where 1=1 
	 and pde.pde_pa_id = 65640451
	 order by pde.pde_date_added desc, pde.pde_source_name asc
END

select * FROm patient_active_diagnosis_external WHERE pde_pa_id=65640451

UPDATE patient_active_diagnosis_external SET pde_pa_id=65640451 WHERE pde_id =  800
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
