SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FetchSplCharPatientEncounterDetailsByEncounterId] 
	(@startEncId AS BIGINT,
	@endEncId AS BIGINT)
AS
BEGIN
--Create a temp table to fetch necessaty details
	DECLARE @tempTable TABLE
	(
		pa_id int,
		pa_last varchar(100),
		pa_first varchar(100), 
		pa_dob datetime,
		pa_sex varchar(2),
		enc_id int,
		enc_text varchar(max)
	)
	
	--Insert records matching the encounter type into temp table
	INSERT INTO @tempTable
	SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id,enc_text
	FROM enchanced_encounter dd with(nolock)
	inner join patients p with(nolock) on p.pa_id=dd.patient_id
	WHERE enc_id >= @startEncId and enc_id <= @endEncId
	
	SELECT pa_id,pa_last,pa_first,pa_dob,pa_sex,enc_id
	FROM @tempTable
	WHERE enc_id >= @startEncId and enc_id <= @endEncId 
	and (enc_text like '%[$+@*][a-zA-Z0-9]%' or enc_text like '%[a-zA-Z0-9][$+@*]%')
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
