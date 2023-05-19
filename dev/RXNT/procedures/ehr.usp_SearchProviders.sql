SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 12-Oct-2016
-- Description:	To Search  Providers
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SearchProviders]
  @FirstName VARCHAR(MAX) ,
  @LastName VARCHAR(MAX),
  @City VARCHAR(MAX),
  @State VARCHAR(MAX),
  @Speciality VARCHAR(MAX),
  @DoctorCompanyId BIGINT  
AS
BEGIN
  SELECT [target_dr_id],[first_name],[last_name],[middle_initial],[GroupName],[speciality],[address1],[city],[state],[zip],[phone],[fax],[IsLocal],[ext_doc_id],'' suffix , [address2]
  FROM [referral_target_docs] WITH(NOLOCK)
  WHERE (@FirstName IS NULL OR first_name like @FirstName+'%') AND
		(@LastName IS NULL OR last_name like @LastName+'%') AND
		(@City IS NULL OR city like @City+'%') AND
		(@State IS NULL OR State like @State+'%') AND
		(@Speciality IS NULL OR speciality like @Speciality+'%') AND
		dc_id=@DoctorCompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
