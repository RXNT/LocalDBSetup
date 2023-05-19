SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===============================================================================================
-- Author		: Kanniyappan N
-- Create date	: 12-OCT-2016
-- Description	: To fetch list of All zipcodes for unique validation for user
-- ===============================================================================================
CREATE PROCEDURE [adm].[usp_GetAllZipCodeCities]
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  ZC.ZipCode AS ZipCode
	FROM	[cmn].[ZipCodes] ZC WITH(NOLOCK)
			INNER JOIN cmn.[States] ST WITH (NOLOCK) ON ST.StateId = ZC.StateId     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
