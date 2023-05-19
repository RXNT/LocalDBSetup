SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FetchTagMismatchEncounterDetailsByEncounterId] 
	(@startEncId AS BIGINT,
	@endEncId AS BIGINT)
AS
BEGIN
	DECLARE @tbCount int
	DECLARE @iCnt int
	
	DECLARE @encounterId BIGINT
	DECLARE @patientId BIGINT
	DECLARE @xmlstring VARCHAR(MAX)
	DECLARE @enc_XML XML
	DECLARE @errorNumber INT
	
	Declare @encTemTable TABLE(enc_id INT,pa_id BIGINT)
	
	--Create a temp table to fetch necessaty details
	DECLARE @tempTable TABLE
	(
		enc_id int,
		enc_text varchar(max),
		[patient_id] int
	)
	
	INSERT INTO @tempTable
	SELECT [enc_id],[enc_text],[patient_id]
	FROM [dbo].[enchanced_encounter] with(nolock)
	WHERE enc_id >= @startEncId and enc_id <= @endEncId
	
	SELECT  @tbCount =COUNT(*) from @tempTable
	SET @iCnt = 0
	
	WHILE(@iCnt < @tbCount)
	BEGIN
		SELECT TOP 1 @encounterId = [enc_id],@xmlstring=[enc_text],@patientId=[patient_id] FROM @tempTable 
		DELETE FROM @tempTable where [enc_id] = @encounterId
			BEGIN TRY
				SET @enc_XML=CONVERT(XML,@xmlstring)
			END TRY
			BEGIN CATCH
				IF(ERROR_NUMBER()=9436 OR ERROR_NUMBER()=9455)
				BEGIN
					INSERT INTO @encTemTable VALUES(@encounterId,@patientId)
				END
			END CATCH	
		SET @iCnt = @iCnt + 1
	END
	
	SELECT P.pa_id,P.pa_last,P.pa_first, P.pa_dob,P.pa_sex,dd.enc_id 
	FROM  @encTemTable dd
	inner join patients p with(nolock) on p.pa_id=dd.pa_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
