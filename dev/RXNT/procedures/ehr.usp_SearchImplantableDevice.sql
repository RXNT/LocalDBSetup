SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6.09.2017
-- Description: Search Implantable Devices 
-- =============================================
CREATE PROCEDURE  [ehr].[usp_SearchImplantableDevice]
	@Name Varchar(200) = NULL
AS

BEGIN
SET NOCOUNT ON;
SET @Name = ISNULL(@Name,'')
SELECT TOP 100 
		[ImplantableDeviceId]
      ,[DeviceId]
      ,[DeviceIdIssuingAgency]
      ,[BrandName]
      ,[CompanyName]
      ,[VersionModelNumber]
      ,[MRISafetyStatus]
      ,[LabeledContainsNRL]
      ,[DeviceRecordStatus]
  FROM [RxNT].[ehr].[ImplantableDevice]  
  WHERE Active=1 AND 
  BrandName LIKE '%'+@Name+'%' or DeviceId like '%'+@Name+'%'
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
