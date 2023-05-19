SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  JahabarYusuff M   
-- Create date: 27-Jan-2020
-- Description: Procedure to get doctor company info  
-- =============================================    

CREATE PROCEDURE [prv].[usp_GetDoctorCompany]
(
	@DoctorCompanyId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	 SELECT dc.dc_id,
			dc.dc_name
    FROM dbo.doc_companies dc WITH(NOLOCK)
    WHERE dc.dc_id = @DoctorCompanyId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
