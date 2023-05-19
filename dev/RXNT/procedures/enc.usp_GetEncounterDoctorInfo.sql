SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the doctor information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetEncounterDoctorInfo]
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT d.dr_id,
		d.dg_id,
        dg.dg_name,
        CASE WHEN LEN(d.dr_prefix)>0 THEN  d.dr_prefix + ' ' ELSE '' END+ dr_first_name+' '+d.dr_last_name+ CASE WHEN LEN(d.dr_suffix)>0 THEN  ' '+d.dr_suffix  ELSE '' END AS dr_name,
		d.dr_address1,
        d.dr_address2,
        d.dr_city,
        d.dr_state,
        d.dr_zip,
        d.dr_phone,
        d.dr_fax,
        CASE WHEN LEN(d.dr_sig_file)>0 THEN '/doctorSigs/'+dr_sig_file ELSE d.dr_sig_file END AS dr_sig_file,
        d.time_difference,
        d.prescribing_authority
    FROM doctors d
    INNER JOIN doc_groups dg ON d.dg_id= dg.dg_id
    WHERE d.dr_id = @DoctorId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
