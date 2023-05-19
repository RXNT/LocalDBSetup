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

CREATE PROCEDURE [support].[CopyReferralInstitutions]
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
		INSERT INTO [referral_institutions] ([inst_name],[inst_address1],[inst_address2],
		[inst_city],[inst_state],[inst_zip],[inst_phone],[inst_fax],
		[added_by_dr_id],[enabled])
		SELECT ref_from.[inst_name],ref_from.[inst_address1],ref_from.[inst_address2],
		ref_from.[inst_city],ref_from.[inst_state],ref_from.[inst_zip],ref_from.[inst_phone],ref_from.[inst_fax],
		@ToDoctorId,ref_from.[enabled] FROM
		[referral_institutions] ref_from WITH(NOLOCK) 
		LEFT OUTER JOIN [referral_institutions] ref_to WITH(NOLOCK) ON ref_to.added_by_dr_id=@ToDoctorId  AND ref_from.[inst_name]=ref_to.[inst_name] AND ref_from.[inst_address1]= ref_to.[inst_address1] AND ref_from.[inst_address2]=ref_to.[inst_address2] AND ref_from.[inst_city]= ref_to.[inst_city] AND ref_from.[inst_state]=ref_to.[inst_state] AND ref_from.[inst_zip]=ref_to.[inst_zip] AND ref_from.[inst_phone]=ref_to.[inst_phone] AND ref_from.[inst_fax] = ref_to.[inst_fax]
		WHERE ref_from.added_by_dr_id=@FromDoctorId AND ref_from.enabled = 1 AND ref_to.inst_id IS NULL
		ORDER BY inst_name
	END
END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
