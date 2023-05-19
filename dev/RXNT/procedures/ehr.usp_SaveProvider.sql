SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 13-Oct-2016
-- Description:	To Save  Provider
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SaveProvider]
   @DoctorId INT OUTPUT,
  @FirstName VARCHAR(MAX) ,
  @LastName VARCHAR(MAX),
  @MiddleInitial VARCHAR(MAX),
  @GroupName VARCHAR(MAX),
  @Address1 VARCHAR(MAX),
  @City VARCHAR(MAX),
  @State VARCHAR(MAX),
  @ZipCode VARCHAR(MAX),
  @Speciality VARCHAR(MAX),
  @Phone VARCHAR(MAX),
  @Fax VARCHAR(MAX),
  @IsLocal BIT,
  @ExternalRefId INT,
  @IsFavProvider BIT,
  @MainDoctorId INT,
  @DoctorCompanyId BIGINT,
  @DirectEmail VARCHAR(MAX),
  @Address2 VARCHAR(MAX)=NULL
AS
BEGIN
	INSERT INTO [referral_target_docs]([first_name],[last_name],[middle_initial],[GroupName],
	 [speciality],[address1],[city],[state],[zip],[phone],[fax], [IsLocal],[ext_doc_id], [dc_id],[direct_email],[address2])
    VALUES(@FirstName, @LastName, @MiddleInitial, @GroupName, @Speciality, @Address1,
     @City, @State, @ZipCode, @Phone, @Fax, @IsLocal, @ExternalRefId, @DoctorCompanyId,@DirectEmail,@Address2);
    SET @DoctorId =  SCOPE_IDENTITY();
    
    IF @IsFavProvider = 1
    BEGIN
		IF NOT EXISTS(SELECT TARGET_DR_ID FROM referral_fav_providers WHERE MAIN_DR_ID =@MainDoctorId AND target_dr_id = @DoctorId)
		BEGIN
			INSERT INTO [referral_fav_providers] ([main_dr_id],[target_dr_id])
			VALUES(@MainDoctorId, @DoctorId)
		END
    END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
