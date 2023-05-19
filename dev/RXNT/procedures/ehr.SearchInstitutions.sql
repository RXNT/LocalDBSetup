SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 7-Oct-2016
-- Description:	To Get Institutions for doctor id
-- Mod1ified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[SearchInstitutions]
  @DoctorId INT
AS
BEGIN
	DECLARE @dg_id BIGINT
	SELECT @dg_id=dg_id
	FROM doctors WITH(NOLOCK)
	WHERE dr_id=@DoctorId
	SELECT [inst_id] ,[inst_name],[inst_address1],[inst_address2],
	[inst_city],[inst_state],[inst_zip],[inst_phone],[inst_fax],
	[added_by_dr_id],[enabled] 
	FROM [referral_institutions] WITH(NOLOCK)
	where added_by_dr_id = @DoctorId and enabled = 1 
	UNION
	SELECT ri.[inst_id] ,ri.[inst_name],ri.[inst_address1],ri.[inst_address2],
	ri.[inst_city],ri.[inst_state],ri.[inst_zip],ri.[inst_phone],ri.[inst_fax],
	ri.[added_by_dr_id],ri.[enabled] 
	FROM [referral_institutions] ri WITH(NOLOCK)
	INNER JOIN doc_group_fav_ref_institutions dgf WITH(NOLOCK) ON ri.[inst_id]=dgf.[inst_id]
	where dgf.dg_id = @dg_Id and ri.enabled = 1 
	order by inst_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
