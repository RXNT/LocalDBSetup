SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_AddImplantableDevice] 
  @DeviceId VARCHAR(200),
  @DeviceIdIssuingAgency VARCHAR(200),
  @BrandName VARCHAR(200),
  @CompanyName VARCHAR(200),
  @VersionModelNumber VARCHAR(200),
  @MRISafetyStatus  VARCHAR(200),
  @LabeledContainsNRL VARCHAR(200),
  @DeviceRecordStatus VARCHAR(200), 
  @CreationDate VARCHAR(200), 
  @Active BIT,
  @CreatedDate DATETIME, 
  @CreatedBy BIGINT

AS
BEGIN 
 SET NOCOUNT ON;
	DECLARE @inserted_Id int = 0;
	IF NOT EXISTS 
    (   SELECT  1
        FROM    [ehr].[ImplantableDevice] 
          WHERE DeviceId = @DeviceId
    )
    BEGIN
        INSERT INTO [ehr].[ImplantableDevice] (DeviceId, DeviceIdIssuingAgency,BrandName,CompanyName,VersionModelNumber,MRISafetyStatus ,
				LabeledContainsNRL ,DeviceRecordStatus ,CreationDate ,Active ,CreatedDate,CreatedBy )
		VALUES
	   (@DeviceId,@DeviceIdIssuingAgency,LTRIM(@BrandName),@CompanyName,@VersionModelNumber,
			@MRISafetyStatus,@LabeledContainsNRL,@DeviceRecordStatus,@CreationDate, @Active,@CreatedDate, @CreatedBy);
			

    END;
    SET @inserted_Id =  SCOPE_IDENTITY()
	SELECT @inserted_Id as iDI
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
