SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 28-Jan-2016
-- Description:	To get the encounter form types
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchEncounterFormTypes]
AS

BEGIN
	SET NOCOUNT ON;
	 
	SELECT enc_lst_id, enc_name,enc_type, speciality 
	FROM encounter_types WITH(NOLOCK) 
	WHERE active=1
	ORDER  BY speciality, enc_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
