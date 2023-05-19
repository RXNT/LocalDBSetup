SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  AFSAL Y    
-- Create date: 14/12/2017
-- Description: Procedure to get the measures data for VDT    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measures_Get_Pin_Generated_Patients]    
	@dr_id INT,
	@dg_id INT = null, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@measureCode VARCHAR(3)    
AS    
BEGIN        
	SET NOCOUNT ON; 
	DECLARE @MeasureStage AS VARCHAR(10)    
	SET @MeasureStage = 'MIPS2017';  
	
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	
	IF @dg_id IS  NULL
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT  DISTINCT enc.patient_id AS PatientId  
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			WHERE 1=1 
			AND enc.dr_id = @dr_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1  
		END
	ELSE
		BEGIN
			INSERT INTO @DENOMINATOR_PATIENTS
			SELECT  DISTINCT enc.patient_id AS PatientId  
			FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
			INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
			WHERE 1=1 
			AND pat.dg_id=@dg_id
			AND enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date    
			AND enc.type_of_visit = 'OFICE'    
			AND	enc.issigned = 1  
		END;
	
		
	
	WITH MEASURES_DATA AS    
	(    
		SELECT  @measureCode AS MeasureCode, 
			@MeasureStage AS MeasureStage, 
			@dr_id AS dr_id    
	), 
	NUMERATOR_PATIENTS AS    
	(    
		SELECT DISTINCT DP.PatientId AS PatientId    
		FROM  dbo.patient_reg_db  prd  WITH(NOLOCK)    
		INNER JOIN @DENOMINATOR_PATIENTS DP ON DP.PatientId  = prd.pa_id
	)
    
	SELECT  
		VMD.dr_id, 
		MUM.MeasureCode, 
		(SELECT COUNT(PatientId) AS Numerator FROM  NUMERATOR_PATIENTS) AS Numerator, 
		(SELECT COUNT(PatientId) AS Denominator FROM  @DENOMINATOR_PATIENTS) AS Denominator,    
		MUM.MeasureName, 
		MUM.DisplayOrder, 
		MUM.MeasureDescription, 
		MUM.PassingCriteria, 
		MUm.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id, 
		MUM.MeasureClass,  
		MUM.Performace_points_per_10_percent, 
		MUM.MeasureCalculation
	FROM  MEASURES_DATA    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MIPSMeasures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
	and MUM.MeasureCode  = @MeasureCode    
	and MUM.IsActive  = 1    
	and MUM.MeasureStage = @MeasureStage    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
