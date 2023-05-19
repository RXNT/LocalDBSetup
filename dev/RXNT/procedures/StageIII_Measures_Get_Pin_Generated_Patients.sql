SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================   
-- Author:  Niyaz Hussain  
-- Create DATE: 13-March-2018
-- Description: Procedure to get the measures data for secure messaging   
-- =============================================    
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_Pin_Generated_Patients]    
	@dr_id INT, 
	@dg_id INT =  NULL,  
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3)    
AS    
BEGIN      
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10)    
	SET @MeasureStage = 'MU2015';   
 
	WITH MEASURES_DATA AS    
	(    
		SELECT 
		@measureCode AS MeasureCode, 
		@MeasureStage AS MeasureStage, 
		@dr_id AS dr_id    
	),
	DENOMINATOR_PATIENTS AS    
	(     
		SELECT  DISTINCT enc.patient_id AS PatientId  
		FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
		WHERE 1=1 
		AND ((@dg_id IS  NULL AND enc.dr_id = @dr_id) OR (@dg_id IS NOT  NULL AND pat.dg_id=@dg_id))
		AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date    
		AND enc.type_of_visit = 'OFICE'    
		AND	enc.issigned = 1    
	),   
	NUMERATOR_PATIENTS AS    
	(    
		SELECT DISTINCT DP.PatientId AS PatientId    
		FROM  dbo.patient_reg_db  prd  WITH(NOLOCK)    
		INNER JOIN DENOMINATOR_PATIENTS DP  WITH(NOLOCK) ON DP.PatientId  = prd.pa_id
	)   
    
	SELECT  
		VMD.dr_id, 
		MUM.MeasureCode, 
		(SELECT COUNT(PatientId) AS Numerator FROM  NUMERATOR_PATIENTS WITH(NOLOCK) ) AS Numerator, 
		(SELECT COUNT(PatientId) AS Denominator FROM  DENOMINATOR_PATIENTS WITH(NOLOCK) ) AS Denominator,    
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id
	FROM  MEASURES_DATA    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MU3Measures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
	AND MUM.MeasureCode  = @MeasureCode    
	AND MUM.IsActive  = 1    
	AND MUM.MeasureStage = @MeasureStage    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
