SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Niyaz Hussain  
-- Create DATE: 13-March-2018
-- Description: Procedure to get the measures data based ON @MeasureCode passed      
-- =============================================      
CREATE PROCEDURE [dbo].[StageIII_Measures_Get_Stats]      
	@dr_id INT, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@MeasureCode VARCHAR(3)      
AS      
BEGIN            
	SET NOCOUNT ON;      
	DECLARE @MeasureStage AS VARCHAR(10);      
	SET @MeasureStage = 'MU2014';      
      
	IF EXISTS(
		SELECT TOP 1 id FROM dbo.[MUMeasures] WITH(NOLOCK)  
		WHERE 
		PassingCriteria = 'Yes/No' 
		AND MeasureCode = @MeasureCode
	)      
		BEGIN      
			SELECT 
				@dr_id AS dr_id,@MeasureCode AS MeasureCode,
				0 AS Numerator, 
				0 AS Denominator,
				MUM.MeasureName, 
				MUM.DisplayOrder, 
				MUM.MeasureDescription, 
				MUM.PassingCriteria, 
				MUm.MeasureGroup, 
				MUM.MeasureStage, 
				'Yes' AS MeasureResult,
				MUM.MeasureGroupName,MUM.Id  
			FROM dbo.MUMeasures    MUM  WITH(NOLOCK)      
			WHERE MUM.MeasureCode  = @MeasureCode      
		END      
	ELSE      
	BEGIN       
		WITH MeasureStat AS      
		(      
			SELECT  
				@dr_id AS dr_id, 
				@MeasureCode AS MeasureCode, 
				SUM(CASE WHEN MUC.IsNumerator = 1 THEN 1 ELSE 0 END) AS Numerator, 
				SUM(CASE WHEN MUC.IsDenominator = 1 THEN 1 ELSE 0 END) AS Denominator      
			FROM  dbo.MUMeasureCounts   MUC  WITH(NOLOCK)      
			WHERE  1=1      
			AND   MUC.dr_id     =  @dr_id      
			AND   MUC.MeasureCode    =  @MeasureCode      
			AND   MUC.RecordCreateDateTime BETWEEN @reporting_start_date AND @reporting_end_date      
		) 
		     
		SELECT  
			MST.dr_id, 
			MST.MeasureCode, 
			MST.Numerator, 
			MST.Denominator,      
			MUM.MeasureName, 
			MUM.DisplayOrder, 
			MUM.MeasureDescription, 
			MUM.PassingCriteria, 
			MUm.MeasureGroup, 
			MUM.MeasureStage,  
			NULL AS MeasureResult,
			MUM.MeasureGroupName,MUM.Id      
		FROM  MeasureStat     MST  WITH(NOLOCK)      
		INNER JOIN dbo.MUMeasures    MUM  WITH(NOLOCK) ON MUM.MeasureCode  = MST.MeasureCode      
		AND MUM.MeasureCode  = @MeasureCode      
		AND MUM.IsActive  = 1      
		AND MUM.MeasureStage = @MeasureStage;      
	END      
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
