SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 03-JAN-2017
-- Description:	To Copy Referral List for Providers
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [support].[CopyReferralProviders]
  @FromDoctorId BIGINT,
  @ToDoctorId BIGINT  
AS
BEGIN
	DECLARE @FromDoctorCompanyId AS BIGINT
	DECLARE @ToDoctorCompanyId AS BIGINT
	SELECT TOP 1 @FromDoctorCompanyId = dg.dc_id FROM doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg ON dr.dg_id= dg.dg_id
	WHERE dr.dr_id = @FromDoctorId
	
	SELECT TOP 1 @ToDoctorCompanyId = dg.dc_id FROM doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg ON dr.dg_id= dg.dg_id
	WHERE dr.dr_id = @ToDoctorId
	
	IF @FromDoctorCompanyId=@ToDoctorCompanyId
	BEGIN 
 
		INSERT INTO [referral_fav_providers] (target_dr_id,main_dr_id)
		SELECT ref_from.target_dr_id,@ToDoctorId
		FROM [referral_fav_providers] ref_from WITH(NOLOCK)
		LEFT OUTER JOIN [referral_fav_providers] ref_to ON ref_to.target_dr_id = @ToDoctorId
		where ref_from.main_dr_id = @FromDoctorId	AND ref_to.target_dr_id IS NULL
	END

END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
