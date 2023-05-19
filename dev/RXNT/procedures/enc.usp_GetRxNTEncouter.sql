SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =====================================================
-- Author:		Thomas K
-- Create date: 31-Jan-2016
-- Description:	To get the RxNTEncounter Details
-- Modified By: 
-- Modified Date: 
-- ====================================================
CREATE PROCEDURE [enc].[usp_GetRxNTEncouter]
	@PatientID BIGINT,
	@EncounterID BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	select enc_text,ENCJ.JSON,ENCX.issigned,ENCX.is_released from 
		enchanced_encounter ENCX with(nolock) 
		left outer join [enchanced_encounter_additional_info] ENCJ with(nolock) on ENCX.enc_id = ENCJ.enc_id
		where 
		ENCX.enc_id = @EncounterID 
		and ENCX.patient_id = @PatientID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
