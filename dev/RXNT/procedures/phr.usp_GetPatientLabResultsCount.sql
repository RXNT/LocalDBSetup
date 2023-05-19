SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_GetPatientLabResultsCount]
	@PatientId bigint
AS
BEGIN
	SET NOCOUNT ON;
	Declare @Count as int
	
		    
		SELECT @Count=COUNT(1)
		from lab_main a inner join lab_pat_details b on a.lab_id = b.lab_id where a.pat_id = @PatientId 
		and is_read=1 and a.lab_id in (select distinct LM.lab_id from lab_main LM
		inner join lab_result_info LRI on LM.lab_id=LRI.lab_id where LM.pat_id = @PatientId ) 
	
	Select @Count as LabsCount
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
