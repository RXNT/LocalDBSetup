SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To search the goals
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchGoals]
	@Name VARCHAR(50),
	@MaxRows INT = 50
AS

BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT TOP (@MaxRows) Id, Name, SnomedCode, Category 
	FROM [snomed_ct_code_system] 
	WHERE Category = 'PatientGoals' AND Name LIKE '%' + @Name + '%'
	ORDER BY Name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
