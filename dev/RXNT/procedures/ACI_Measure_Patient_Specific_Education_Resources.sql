SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Reiah    
-- Create date: 09/18/2017    
-- Description: Procedure to get the measures data for View_Download_Transmit_Patient    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_Patient_Specific_Education_Resources]    
	@dr_id int,
	@dg_id int=NULL,
	@reporting_start_date date,
	@reporting_end_date date,
	@measureCode Varchar(3)    
AS    
BEGIN    
	SET NOCOUNT ON;    
	DECLARE @MeasureStage as varchar(10)    
	SET @MeasureStage = 'MIPS2017';   
	
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	
	IF @dg_id IS  NULL
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT enc.patient_id AS PatientId 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			WHERE  1=1  
			AND	enc.dr_id = @dr_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date  
			AND	enc.issigned = 1 
			AND enc.type_of_visit = 'OFICE'   
			GROUP BY  enc.patient_id
		END
	ELSE
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT DISTINCT enc.patient_id AS PatientId 
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id 
			WHERE  1=1  
			AND	pat.dg_id = @dg_id 
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date  
			AND	enc.issigned = 1
			AND enc.type_of_visit = 'OFICE'   
		END;    
  
	WITH MEASURES_DATA AS    
	(    
		SELECT	@measureCode AS MeasureCode, 
				@MeasureStage AS MeasureStage, 
				@dr_id AS dr_id    
	), 
	 NUMERATOR_PATIENT AS    
	 (    
		  SELECT DISTINCT mc.pa_id as PatientId
		  FROM  dbo.MUMeasureCounts mc WITH(NOLOCK)     
		  INNER JOIN @DENOMINATOR_PATIENTS DP  ON DP.PatientId = mc.pa_id    
		  WHERE  1=1  
		  AND mc.MeasureCode = @measureCode 
		  AND mc.IsNumerator = 1   
		  AND mc.DateAdded BETWEEN @reporting_start_date AND @reporting_end_date   
	 )
    
	
	SELECT  VMD.dr_id, MUM.MeasureCode, 
		(SELECT COUNT(PatientId) FROM NUMERATOR_PATIENT) as Numerator, 
		(SELECT COUNT(PatientId) FROM @DENOMINATOR_PATIENTS) as Denominator, 
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,MUM.Id , 
		MUM.MeasureClass,  
		MUM.Performace_points_per_10_percent , 
		MUM.MeasureCalculation
	FROM  MEASURES_DATA    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MIPSMeasures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
													 and MUM.MeasureCode  = @measureCode    
													 and MUM.IsActive  = 1    
													 and MUM.MeasureStage = @MeasureStage    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
