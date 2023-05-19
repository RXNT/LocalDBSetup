SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FetchCorruptPatientEncounterDetailsByEncounterId] 
	(@startEncId AS BIGINT,
	@endEncId AS BIGINT)
AS
BEGIN
	--Create a temp table to fetch necessaty details
	DECLARE @tempTable TABLE
	(
		[enc_id] int,
		[patient_id] int,
		[enc_text] xml
	)
	
	--Insert records matching the encounter type into temp table
	INSERT INTO @tempTable
	SELECT [enc_id],[patient_id],[enc_text]
	FROM [dbo].[enchanced_encounter] with(nolock)
	WHERE enc_id >= @startEncId and enc_id <= @endEncId
	
	--fetch the records having corrupted xml data(Patient Id)
	SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
    dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') as pa_id_xml
    FROM @tempTable dd 
    inner join patients p on p.pa_id=dd.patient_id
    WHERE dd.enc_text.value('(/EnhancedPatientEncounter/PatientId)[1]', 'int') !=dd.patient_id
    UNION 
    SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,
    dd.enc_text.value('(/Framework/PatientId)[1]', 'int') as pa_id_xml
    FROM @tempTable dd 
    inner join patients p on p.pa_id=dd.patient_id
    WHERE dd.enc_text.value('(/Framework/PatientId)[1]', 'int') !=dd.patient_id	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
