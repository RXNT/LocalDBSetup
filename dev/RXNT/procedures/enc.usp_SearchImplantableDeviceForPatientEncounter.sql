SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Niyaz
Create date			:	27-10-2017
Description			:	This procedure is used to Load Implantable device
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE  [enc].[usp_SearchImplantableDeviceForPatientEncounter]
	@Name Varchar(200)
AS

BEGIN
SET NOCOUNT ON;

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
