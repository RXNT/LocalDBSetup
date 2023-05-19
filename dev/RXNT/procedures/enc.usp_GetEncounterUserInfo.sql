SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 02-May-2016
-- Description:	To get the user information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetEncounterUserInfo]
	@UserId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT d.dr_id,
		d.dg_id,
        dg.dg_name,
        CASE WHEN LEN(d.dr_prefix)>0 THEN  d.dr_prefix + ' ' ELSE '' END+ d.dr_last_name+', '+dr_first_name+ CASE WHEN LEN(d.dr_suffix)>0 THEN  ' '+d.dr_suffix  ELSE '' END AS dr_name,
        d.dr_address1,
        d.dr_address2,
        d.dr_city,
        d.dr_state,
        d.dr_zip,
        d.dr_phone,
        d.dr_fax,
        CASE WHEN LEN(d.dr_sig_file)>0 THEN '/doctorSigs/'+dr_sig_file ELSE d.dr_sig_file END AS dr_sig_file,
        d.time_difference,
        d.prescribing_authority,
        d.rights,
        dg.emr_modules AS dg_modules
    FROM doctors d
    INNER JOIN doc_groups dg ON d.dg_id= dg.dg_id
    WHERE d.dr_id = @UserId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
