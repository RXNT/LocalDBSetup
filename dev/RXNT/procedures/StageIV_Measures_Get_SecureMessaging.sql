SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================   
-- Author:  Kalimuthu
-- Create DATE: 23-November-2020
-- Description: Procedure to get the measures data for secure messaging    
-- =============================================    
CREATE PROCEDURE [dbo].[StageIV_Measures_Get_SecureMessaging]    
	@dr_id INT,
	@dg_id INT =  NULL,  
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3) = 'SEM'    
AS    
BEGIN      
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10);    
	SET @MeasureStage = 'MU2015'; 
	
	WITH MEASURES_DATA AS
	(    
		SELECT  
			@meASureCode AS MeASureCode, 
			'MIPS2017' AS MeASureStage, 
			@dr_id AS dr_id    
	),  
	DENOMINATOR_PATIENTS AS    
	(    
		SELECT DISTINCT enc.patient_id AS PatientId 
		FROM enchanced_encounter enc WITH(NOLOCK)
		INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
		WHERE 
		((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND doc.dg_id=@dg_id))
		AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
		AND enc.issigned=1  
	),
	NUMERATOR_PATIENTS AS    
	(   
		SELECT DISTINCT DP.PatientId AS PatientId  
		FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
		INNER JOIN  DENOMINATOR_PATIENTS  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.PatientId 
		INNER JOIN patients pat WITH(NOLOCK) ON DP.PatientId = pat.pa_id
		WHERE 
		((@dg_id IS  NULL AND pat.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id))
		AND MDRP.MeasureCode = @meASureCode 
		AND MDRP.IsNumerator = 1 
		AND MDRP.DateAdded  BETWEEN @reporting_start_date AND @reporting_end_date  
	)   


	SELECT  
		VMD.dr_id, 
		MUM.MeASureCode,
		(SELECT COUNT(PatientId) AS Numerator FROM  NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator, 
		(SELECT COUNT(PatientId) AS Denominator FROM  DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator,   
		MUM.MeASureName, 
		MUM.DisplayOrder, 
		MUM.MeASureDescription, 
		MUM.PASsingCriteria, 
		MUM.MeASureGroup, 
		MUM.MeASureStage, 
		NULL AS MeASureResult,
		MUM.MeASureGroupName,
		MUM.Id
	FROM  MEASURES_DATA  VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MU4Measures   MUM  WITH(NOLOCK) ON MUM.MeASureCode  = VMD.MeASureCode    
	AND MUM.MeASureCode  = @meASureCode    
	AND MUM.IsActive  = 1    
	AND MUM.MeASureStage = @MeASureStage       
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
