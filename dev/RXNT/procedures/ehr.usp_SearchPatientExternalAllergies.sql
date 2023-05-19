SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 24-Oct-2017
-- Description:	To Search Patient External Allergies
-- Mod1ified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientExternalAllergies]
  @PatientId INT
AS
BEGIN
	select pae_pa_id,pae_allergy_id,
	pae_allergy_type,
	pae.pae_status,
	pae.pae_source_name as [SourceName], 
	pae.pae_allergy_description as [AllergyDescription], 
	pae.pae_reaction_string as [Reaction], pae.pae_comments as [Comment], CONVERT(VARCHAR(10), 
	pae.pae_add_date, 101) as [DateAdded],
	pae.rxnorm_code,pae.severity_id, ATC.Description as severity_name,
	last_modified_date
	from dbo.patient_new_allergies_external pae with(nolock) 
	left join ehr.ApplicationTableConstants ATC on ATC.ApplicationTableConstantId = pae.severity_id
	where 1=1 
	and pae.pae_pa_id =@PatientId
	order by pae.pae_add_date desc, pae.pae_source_name asc 
	
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
