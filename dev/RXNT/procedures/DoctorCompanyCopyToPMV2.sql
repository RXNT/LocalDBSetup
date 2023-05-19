SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 01/08/2015
-- Description:	To copy company to PMV2
-- =============================================
CREATE PROCEDURE [dbo].[DoctorCompanyCopyToPMV2] 
@dc_id AS BIGINT 
AS
BEGIN
	DECLARE @IsCopied BIT --Is the company copied in PMV2 database
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @master_AppId BIGINT 
	DECLARE @master_app_name VARCHAR(50)='RxNTPMV2' 
	
		--To get the Master application id
	SELECT @master_AppId=app.applicationid 
	FROM applications app 
	INNER JOIN applicationtypes apptype ON app.applicationtypeid=apptype.applicationtypeid
	INNER JOIN applicationversions appver ON app.applicationversionid=appver.applicationversionid
	WHERE apptype.applicationtypename='PM' AND appver.applicationversion='Version2' AND app.active=1
	
	
	DECLARE @dc_name VARCHAR(50)
	--To get the company details
	SELECT  @dc_id=dc.dc_id, @dc_name=dc.dc_name
	FROM doc_companies dc
	WHERE dc.dc_id=@dc_id

	DECLARE @master_ExternalAppId BIGINT
	--To get the Master app id for 'EHR'
	SELECT TOP 1 @master_ExternalAppId = AP.ApplicationId 
	FROM RsynMasterApplications AP 
	WHERE AP.Name LIKE 'EHR'
	
	DECLARE @master_DoctorCompanyID BIGINT
	DECLARE @master_CreatedBy BIGINT 
	-- To get the created by id
	-- To get the created by id
	SELECT TOP 1 @master_CreatedBy = LoginId 
	FROM RsynMasterLoginInfo ALI 
	WHERE ALI.Text1 = 'rxntsystemadmin' --'billingmanager'-- 'rxntsystemadmin'
	
	DECLARE @master_CompanyTypeId BIGINT 
	-- To get the company type id
	SELECT TOP 1 @master_CompanyTypeId = CompanyTypeId 
	FROM synMasterCompanyTypes 
	WHERE Code='DNCNT'
	
	IF NOT EXISTS(SELECT 1 FROM RsynMasterCompanyExternalAppMaps WHERE externalappid=@master_ExternalAppId AND externalcompanyid = @dc_id)
	BEGIN			
		BEGIN TRY
		BEGIN TRANSACTION 
			
			-- To store DoctorCompanies table
			INSERT INTO dbo.synMasterCompanies
			( Name, Active, CompanyTypeID, CreatedDate, CreatedBy) 	
			VALUES(@dc_name, 1, @master_CompanyTypeId , GETDATE(), @master_CreatedBy)
			SET @master_DoctorCompanyID=SCOPE_IDENTITY()
			INSERT INTO synMasterCompanyExternalAppMaps 	
			(CompanyId,  ExternalCompanyId, ExternalAppId, Active, CreatedDate, CreatedBy)
			VALUES(@master_DoctorCompanyID, @dc_id, @master_ExternalAppId, 1, GETDATE(), @master_CreatedBy)
			 	
			SET @IsCopied=1
			-- Update the que status as completed			
			
		COMMIT
		END  TRY
		BEGIN CATCH
			ROLLBACK -- Rollback TRANSACTION
			DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
			SELECT 
				@ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();
			RAISERROR (@ErrorMessage, -- Message text.
					   @ErrorSeverity, -- Severity.
					   @ErrorState -- State.
					   );
			INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS)
			VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','DoctorCompanyCopyToPMV2','dc_id:'+CONVERT(VARCHAR(500),@dc_id))				   
		END CATCH
	END
	ELSE
	BEGIN
		SET @IsCopied=1
	END
	
	RETURN @IsCopied
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
