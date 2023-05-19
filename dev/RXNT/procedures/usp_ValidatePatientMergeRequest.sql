SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
============================================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to validate any pending merge request exists for the patients
Last Modified By	:
Last Modifed Date	:
============================================================================================================
*/
CREATE PROCEDURE [dbo].[usp_ValidatePatientMergeRequest]
(
	@CompanyId						BIGINT,
	@SecondaryPatientIds			XML,
	@ErrorExists					BIT OUTPUT,
	@ErrorMessage					VARCHAR(5000) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @PatientIds VARCHAR(8000) 
	SET @PatientIds = ''
	SET @ErrorExists = 0;
	SET @ErrorMessage = ''

	Select	 @PatientIds = CASE WHEN LEN(@PatientIds) > 0 THEN COALESCE(@PatientIds + ', ', '') ELSE  COALESCE(@PatientIds + '', '') END + Convert(VARCHAR(20), que.secondary_pa_id)
	From
	(Select Distinct que.secondary_pa_id
	FROM	dbo.Patient_merge_request_batch bat WITH (NOLOCK)
			INNER JOIN dbo.Patient_merge_request_queue que WITH (NOLOCK) ON que.pa_merge_batchid = bat.pa_merge_batchid
			INNER JOIN dbo.Patient_merge_status batsta with (nolock) on batsta.statusid = bat.status and Lower(batsta.status) = 'pending'
			INNER JOIN dbo.Patient_merge_status questa with (nolock) on questa.statusid = que.status and Lower(questa.status) = 'pending'
			INNER JOIN @SecondaryPatientIds.nodes('ArrayOfLong/long') A(S) On A.S.value('(text())[1]', 'BIGINT') = que.secondary_pa_id
	WHERE	bat.dc_id = @CompanyId 
			and que.active = 1 
			and bat.active = 1	) que	

	IF LEN(ISNULL(@PatientIds, '')) > 0
	BEGIN
		SET @ErrorExists = 1;
		SET @ErrorMessage = 'Already Patient Merge Requests exists for the patients ' + @PatientIds
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
