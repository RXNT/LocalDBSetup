SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===============================================================================================
-- Author		: Afsal Y
-- Create date	: 09-APRIL-2017
-- Description	: To fetch list of All Specialities
-- ===============================================================================================
CREATE PROCEDURE [adm].[usp_GetAllSpecialties]
AS

BEGIN
	SET NOCOUNT ON;
	SELECT  *
	FROM	doctor_specialities WITH(NOLOCK)     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
