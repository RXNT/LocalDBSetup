SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [prv].[SearchPatientFlags]
	-- Add the parameters for the stored procedure here
	@patientId int,
	@HideOnSearchOnly BIT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PA_ID, FLAG_TITLE, ISNULL(B.hide_on_search,0) AS hide_on_search 
	FROM PATIENT_FLAG_DETAILS A WITH(NOLOCK)
	INNER JOIN PATIENT_FLAGS B WITH(NOLOCK) ON A.FLAG_ID = B.FLAG_ID 
	LEFT OUTER JOIN patient_flag_inactiveindicator C WITH(NOLOCK) ON A.Flag_Id=C.Flag_Id 
	WHERE C.Flag_Id IS NULL And A.PA_ID =@patientId
	AND ((@HideOnSearchOnly IS NULL) OR (@HideOnSearchOnly IS NOT NULL AND @HideOnSearchOnly=1 AND B.hide_on_search=1))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
