SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  AFSAL Y    
-- Create date: 14/12/2017
-- Description: Procedure to get the measures data for VDT    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_VDT]   
	@dr_id int,
	@dg_id int = null, 
	@reporting_start_date date, 
	@reporting_end_date date,
	 @measureCode Varchar(3)   
AS    
BEGIN    
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS VARCHAR(10);    
	SET @MeasureStage = 'MIPS2017';    
	
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT  enc.patient_id AS PatientId  
		FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
		WHERE 1=1 
		AND	enc.dr_id = @dr_id
		AND enc.enc_date BETWEEN @reporting_start_date and @reporting_end_date    
		AND enc.type_of_visit = 'OFICE'    
		AND	enc.issigned = 1 
		GROUP BY enc.patient_id
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT enc.patient_id AS PatientId  
		FROM  dbo.enchanced_encounter  enc  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = enc.patient_id  
		WHERE 1=1 
		AND	pat.dg_id = @dg_id 
		AND enc.enc_date BETWEEN @reporting_start_date and @reporting_end_date    
		AND enc.type_of_visit = 'OFICE'    
		AND	enc.issigned = 1 
		GROUP BY enc.patient_id
	END;
	
	WITH MEASURES_DATA AS
	(    
		SELECT  @measureCode AS MeasureCode, 
			'MIPS2017' AS MeasureStage, 
			@dr_id AS dr_id, 
			@dg_id  AS dg_id   
	),
	NUMERATOR_PATIENTS AS    
	( 
		SELECT DISTINCT DP.PatientId AS PatientId   
		FROM  @DENOMINATOR_PATIENTS   DP      
		INNER JOIN dbo.patient_login pl WITH(NOLOCK) ON pl.pa_id = DP.PatientId   
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
		MUM.MeasureGroup, 
		MUM.MeasureStage, 
		NULL AS MeasureResult,
		MUM.MeasureGroupName,
		MUM.Id , 
		MUM.MeasureClass,  
		MUM.Performace_points_per_10_percent , 
		MUM.MeasureCalculation
	FROM  measures_data    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MIPSMeasures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode    
	AND MUM.MeasureCode  = @measureCode    
	AND MUM.IsActive  = 1    
	AND MUM.MeasureStage = @MeasureStage     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
