SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 9-Feb-2018
-- Description:	Search Portaql Friendly Diagnosis

-- =============================================
CREATE PROCEDURE [phr].[usp_SearchPortalFriendlyDiagnosis] --50,9161,4
	@DoctorId INT,
	@Name VARCHAR(10) = NULL
	
AS

BEGIN
	SET @Name = ISNULL(@Name,'')
	SET NOCOUNT ON;
	
	SELECT distinct TOP (75) friendly_diagnosis_id, friendly_diagnosis_text 
	from [dbo].[patient_portal_friendly_diagnosis] 
	where 	dr_id = @DoctorId 
	AND active=1 and friendly_diagnosis_text like '%'+@Name+'%'
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
