SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		SHEIK
-- Create date: 16-Apr-2020
-- Description:	To get the encounter form types
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchEncounterFormTypes]
@DoctorCompanyId BIGINT=0
AS

BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM doc_companies WHERE dc_id=@DoctorCompanyId AND EnableV2EncounterTemplate=1)
	BEGIN
		SELECT enc_lst_id, enc_name,enc_type, speciality 
		FROM encounter_types WITH(NOLOCK) 
		WHERE active=1
		ORDER  BY speciality, enc_name
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
