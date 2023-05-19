SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	12-FEB-2018
-- Description:		Copy Document Categories From one Group to another
-- =============================================
CREATE PROCEDURE [support].[CopyDocumentCategoriesFromOneGroupToAnother]  
  @FromDoctorGroupId    BIGINT,  
  @ToDoctorGroupId    BIGINT
AS  
BEGIN  
 INSERT INTO patient_documents_category (title, dg_id)
 SELECT pdc_from.title, @ToDoctorGroupId
 FROM patient_documents_category pdc_from WITH(NOLOCK)
 LEFT OUTER JOIN patient_documents_category pdc_to WITH(NOLOCK) ON pdc_to.title = pdc_from.title AND pdc_to.dg_id = @ToDoctorGroupId
 WHERE pdc_from.dg_id=@FromDoctorGroupId AND pdc_to.cat_id IS NULL
 GROUP BY pdc_from.title
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
