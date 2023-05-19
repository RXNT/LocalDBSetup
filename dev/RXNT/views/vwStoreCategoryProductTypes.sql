SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwStoreCategoryProductTypes]
AS
SELECT     CPT_Name, CPT_Description, CPT_ThumbImage, CPT_ThumbImageW, CPT_ThumbImageH, CPT_ID,
                          (SELECT     COUNT(Product_CPT_ID)
                            FROM          StoreProductCPT INNER JOIN
                                                   StoreProducts ON StoreProductCPT.ProductID = StoreProducts.ProductID
                            WHERE      StoreProductCPT.CPT_ID = StoreCategoryProductTypes.CPT_ID AND StoreProducts.InActive = 0 AND 
                                                   StoreProducts.ForEmployeesOnly = 0) AS ProdCnt, SortID
FROM         dbo.StoreCategoryProductTypes
WHERE     (CPT_InActive = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
