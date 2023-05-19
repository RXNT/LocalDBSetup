SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_AddImplantableGmdnPTName] 
  @ImplantableDeviceId BIGINT,
	@GmdnPTName VARCHAR(200),
	@Active BIT,
	@CreatedDate DATETIME,
	@CreatedBy bIGINT

AS
BEGIN 
 
        INSERT INTO [RxNT].[ehr].[PatientImplantableDeviceGmdnPTName]
        ( [ImplantableDeviceId]
      ,[GmdnPTName]
      ,[Active]
      ,[CreatedDate]
      ,[CreatedBy] )
		VALUES
	   (@ImplantableDeviceId,
	@GmdnPTName,
	@Active,
	@CreatedDate,
	@CreatedBy);

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
