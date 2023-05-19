SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 4/3/2018
-- Description:	To get the patient diagnosis
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [rules].[usp_SearchVaccines] 
	@Name VARCHAR(50)=NULL,
	@MaxRows INT = 50
AS
BEGIN
 


select DISTINCT   V.vac_name, V.CVX_CODE  from tblVaccines V
  where V.is_CDC_Active=1  AND V.is_active=1 AND v.dc_id=0 AND (@Name IS NULL OR vac_name like '%'+@Name+'%')
    order by vac_name



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
