SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 07/15/2010
-- Description:	Patient Search Stored Procedure
-- =============================================
CREATE PROCEDURE SearchPatients
	@pafirst varchar(125), @palast varchar(125), @padob varchar(20), @pazip varchar(10),@pachart varchar(50), @dcid int
AS
BEGIN	
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    If Len(@padob) >= 5
    BEGIN
			SELECT DISTINCT TOP 100 P.PA_ID, P.PA_LAST, P.PA_FIRST,P.PA_FLAG, P.PA_MIDDLE, P.PA_SSN, P.PA_ZIP, P.PA_DOB,		P.PA_ADDRESS1, P.PA_ADDRESS2, P.PA_CITY, P.PA_SEX, P.PA_STATE, P.PA_PHONE,pa_ins_type,pa_race_type,pa_ethn_type,pref_lang FROM  PATIENTS P with(nolock)  WHERE P.PA_FIRST LIKE @pafirst AND P.PA_LAST LIKE @palast
	AND P.PA_DOB = CONVERT(DATETIME, @padob) AND P.PA_ZIP LIKE @pazip and p.pa_ssn like @pachart AND P.DG_ID IN (SELECT DG_ID FROM DOC_GROUPS WHERE DC_ID = @dcid)  order by p.pa_last, p.pa_first	
		
	END
	ELSE	
	BEGIN		
		SELECT DISTINCT TOP 100 P.PA_ID, P.PA_LAST, P.PA_FIRST,P.PA_FLAG, P.PA_MIDDLE, P.PA_SSN, P.PA_ZIP, P.PA_DOB,		P.PA_ADDRESS1, P.PA_ADDRESS2, P.PA_CITY, P.PA_SEX, P.PA_STATE, P.PA_PHONE,pa_ins_type,pa_race_type,pa_ethn_type,pref_lang FROM  PATIENTS P with(nolock)   WHERE P.PA_FIRST LIKE @pafirst AND P.PA_LAST LIKE @palast
	AND P.PA_ZIP LIKE @pazip and p.pa_ssn like @pachart AND P.DG_ID IN (SELECT DG_ID FROM DOC_GROUPS WHERE DC_ID = @dcid) order by p.pa_last, p.pa_first
	END
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
