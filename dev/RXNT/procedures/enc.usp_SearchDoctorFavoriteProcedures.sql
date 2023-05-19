SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Pradeep
-- Create date: 17-Mar-2021
-- Description:	To search the doctor fav procedure codes
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [enc].[usp_SearchDoctorFavoriteProcedures]
	@DoctorId INT,
	@MaxRows INT = 5 
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT TOP (@MaxRows) cpt_fav.cpt_code as Code,cpt.description 
	 from dbo.doc_fav_procedure_codes cpt_fav  WITH(NOLOCK)   
	 INNER JOIN cpt_codes cpt WITH(NOLOCK) ON cpt.Code = cpt_fav.cpt_code
	 WHERE cpt_fav.dr_id = @DoctorId
	 ORDER BY cpt_fav.created_date DESC
	  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
