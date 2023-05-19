SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Vinod   
-- Create date: 09/13/2017    
-- Description: Procedure to get the measures data for View_Download_Transmit_Patient    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_Medical_Reconciliation] 
	@dr_id INT, 
	@dg_id INT=NULL, 
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
		SELECT DISTINCT pat.pa_id PatientId
		FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
		WHERE 1=1 
		AND ref.dr_id = @dr_id 
		AND ref.pa_ext_ref = 1 
		AND CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT DISTINCT pat.pa_id PatientId
		FROM  dbo.patient_extended_details  ref  WITH(NOLOCK)    
		INNER JOIN dbo.patients    pat  WITH(NOLOCK) ON pat.pa_id  = ref.pa_id    
		WHERE 1=1 AND
		pat.dg_id=@dg_id
		AND ref.pa_ext_ref = 1 
		AND CAST(ref.pa_ref_date AS DATE) BETWEEN @reporting_start_DATE AND @reporting_end_DATE    
		AND ref.pa_ref_name_details  IS NOT  NULL
	END;
	
	WITH MEASURES_DATA AS    
	(    
		SELECT  @measureCode AS MeasureCode, 
				@MeasureStage AS MeasureStage, 
				@dr_id AS dr_id    
	),   
	
	
	NUMERATOR_PATIENTS AS    
	( 
		SELECT  DISTINCT MUC.pa_id PatientId    
		FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)    
		INNER JOIN @DENOMINATOR_PATIENTS DP  ON  DP.PatientId = MUC.pa_id  
		WHERE  1=1 
		AND MUC.MeasureCode    =  @MeasureCode  
		AND MUC.IsNumerator = 1
	)
  
     
	SELECT  
		VMD.dr_id,
		MUM.MeasureCode, 
		(SELECT COUNT(PatientId) as Numerator FROM  NUMERATOR_PATIENTS) as Numerator, 
		(SELECT COUNT(PatientId) as Denominator FROM  @DENOMINATOR_PATIENTS) as Denominator,  
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
	FROM  MEASURES_DATA    VMD  with(nolock)    
	INNER JOIN dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
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
