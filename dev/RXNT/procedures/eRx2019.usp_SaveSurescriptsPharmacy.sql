SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      

CREATE PROCEDURE [eRx2019].[usp_SaveSurescriptsPharmacy] 
@StoreName VARCHAR(80),
@StoreNumber VARCHAR(50),
@AddressLine1 VARCHAR(50),
@AddressLine2 VARCHAR(50),
@City VARCHAR(50),
@State VARCHAR(50),
@Zip VARCHAR(20),
@PhonePrimary VARCHAR(30),
@Fax VARCHAR(30),
@Email VARCHAR(50),
@Enabled BIT,
@NCPDPID VARCHAR(10),
@Version INT,
@ServiceLevel INT,
@NPI VARCHAR(10),
@OrganizationType VARCHAR(50),
@RxHubPartId VARCHAR(50)=NULL
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO RxNTReportUtils.dbo.pharmaciesSureScript 
    (pharm_company_name,pharm_address1,pharm_address2,pharm_city,pharm_state,pharm_zip,pharm_phone,pharm_fax,pharm_email,pharm_enabled,pharm_participant,pharm_store_numb,pharm_create_date,ncpdp_numb,pharm_lic_numb,pharm_dea_numb,pharm_phone_reception,ss_version,service_level,NPI,organization_type,rxhub_part_id) 
    VALUES (@StoreName,@AddressLine1,@AddressLine2,@City,@State,@Zip,@PhonePrimary,@Fax,@Email,@Enabled,262144,@StoreNumber,GETDATE(),@NCPDPID ,'','','',@Version,@ServiceLevel,@NPI,@OrganizationType,@RxHubPartId)
  
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
