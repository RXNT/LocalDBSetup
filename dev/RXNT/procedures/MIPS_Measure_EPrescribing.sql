SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
CREATE PROCEDURE [dbo].[MIPS_Measure_EPrescribing]    
	@dr_id INT, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE    
AS    
BEGIN    
	-- SET NOCOUNT ON added to prevent extra result sets FROM    
	SET NOCOUNT ON;    
	DECLARE @MeasureStage AS varchar(10), @MeasureCode Varchar(3);    
	SET @MeasureStage = 'MIPS2017';    
	SET @MeasureCode = 'EPR';    
    
	WITH MEASURES_DATA AS    
	(    
		SELECT  @MeasureCode AS MeasureCode, 
				@MeasureStage AS MeasureStage, 
				@dr_id AS dr_id    
	),    
	NUMERATOR_DATA AS    
	(
		SELECT p.dr_id, COUNT(p.pres_id) AS Numerator 
		FROM prescriptions p 
		INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
		INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
		WHERE 
		p.dr_id = @dr_id AND 
		p.pres_delivery_method > 2 AND
		p.pres_void = 0 AND
		RV.MED_REF_DEA_CD NOT IN (2,3,4,5) AND 
		p.pres_approved_date BETWEEN @reporting_start_date AND @reporting_end_date
		GROUP BY p.dr_id 
	),    
	DENOMINATOR_DATA AS    
	( 
		SELECT count(p.pres_id) AS Denominator, p.dr_id  
		FROM prescriptions p 
		INNER JOIN prescription_details pd WITH(NOLOCK) on pd.pres_id = p.pres_id
		INNER JOIN RMIID1 RV WITH(NOLOCK) on RV.MEDID = pd.ddid
		WHERE 
		p.dr_id = @dr_id AND
		p.pres_void = 0 AND
		RV.MED_REF_DEA_CD NOT IN (2,3,4,5) AND 
		p.pres_approved_date BETWEEN @reporting_start_date AND @reporting_end_date 
		GROUP BY p.dr_id  
	)    
    
	SELECT  VMD.dr_id, MUM.MeasureCode, NUM.Numerator, DEN.Denominator,    
			MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, 
			MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, NULL AS MeasureResult,
			MUM.MeasureGroupName,MUM.Id, MUM.MeasureClass,  MUM.Performace_points_per_10_percent, 
			MUM.MeasureCalculation
	FROM  MEASURES_DATA    VMD  WITH(NOLOCK)    
	INNER JOIN dbo.MIPSMeasures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = VMD.MeasureCode AND 
														MUM.MeasureCode  = @MeasureCode AND 
														MUM.IsActive  = 1 AND 
														MUM.MeasureStage = @MeasureStage    
	LEFT JOIN NUMERATOR_DATA    NUM  WITH(NOLOCK) on NUM.dr_id   = VMD.dr_id    
	LEFT JOIN DENOMINATOR_DATA   DEN  WITH(NOLOCK) on DEN.dr_id   = VMD.dr_id    
     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
