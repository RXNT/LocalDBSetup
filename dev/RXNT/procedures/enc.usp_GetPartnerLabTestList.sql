SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 28-Jan-2019
-- Description: Get Generaic testList
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPartnerLabTestList]  
	 @DR_ID BIGINT,
     @SearchString VARCHAR(50)
AS
BEGIN
	 
	   SELECT DISTINCT 
  a.lab_test_id,a.lab_test_name,a.test_type,a.loinc_code,a.CODE_TYPE,a.lab_test_name_long,CAST(CASE WHEN b.lab_test_id IS NULL THEN 0 ELSE 1 END AS BIT) AS active
  ,NULL as partner_local_test_id  FROM lab_test_lists a WITH(NOLOCK) LEFT OUTER JOIN lab_test_lists_favourites b WITH(NOLOCK) ON a.lab_test_id=b.lab_test_id  AND b.dr_id = @DR_ID
  WHERE a.lab_test_id IS NOT NULL  AND a.active=1   AND ( a.lab_test_name LIKE @SearchString+'%' ) ORDER BY a.lab_test_name 
	   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
