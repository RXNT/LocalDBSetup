SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Kanniyappan Narasiman 
Create date			: 13-Jun-2016
Description			: To fetch All Company Module Access 
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[usp_GetCompanyModuleAccess] 
	@DoctorCompanyId INT,
	@EHR			 INT OUTPUT,
	@ERX			 INT OUTPUT
AS 
BEGIN 
	SET NOCOUNT ON; 
	
	SELECT TOP	1 @EHR = ISNULL(enc.dr_id,0)
	FROM		doctors dr				WITH(NOLOCK)
	LEFT JOIN	doc_groups dg			WITH(NOLOCK)	ON dr.dg_id = dg.dg_id
	LEFT JOIN	enchanced_encounter enc WITH(NOLOCK)	ON dr.dr_id = enc.dr_id
	WHERE		(ISNULL(@DoctorCompanyId,0) = 0 OR dg.dc_id = @DoctorCompanyId)  
	AND			enc_date > DATEADD(MONTH,-3, GETDATE())


	SELECT TOP 1 @ERX =ISNULL(prec.dr_id ,0)
	FROM		doctors dr			WITH(NOLOCK)
	LEFT JOIN	doc_groups dg		WITH(NOLOCK)	ON dr.dg_id = dg.dg_id
	LEFT JOIN	prescriptions prec  WITH(NOLOCK)	ON dr.dr_id = prec.dr_id
	WHERE		(ISNULL(@DoctorCompanyId,0) = 0 OR dg.dc_id = @DoctorCompanyId)  
	AND			pres_entry_date > DATEADD(MONTH,-3, GETDATE())
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
