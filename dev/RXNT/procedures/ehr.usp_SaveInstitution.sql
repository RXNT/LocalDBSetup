SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 12-Oct-2016
-- Description:	To Save Institution
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SaveInstitution]
  @InstitutionId INT OUTPUT,
  @InstitutionName VARCHAR(MAX),
  @Address1 VARCHAR(MAX),
  @City VARCHAR(MAX),
  @State VARCHAR(MAX),
  @ZipCode VARCHAR(MAX),
  @Phone VARCHAR(MAX),
  @Fax VARCHAR(MAX),
  @Address2 VARCHAR(MAX),
  @MainDoctorId INT 
AS
BEGIN
	INSERT INTO [referral_institutions] ([inst_name],[inst_address1],[inst_address2],[inst_city],[inst_state],[inst_zip],[inst_phone],[inst_fax],[added_by_dr_id],[enabled])
    VALUES(@InstitutionName, @Address1, @Address2, @City, @State, @ZipCode, @Phone, @Fax, @MainDoctorId, 1)
    SET @InstitutionId = SCOPE_IDENTITY();
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
