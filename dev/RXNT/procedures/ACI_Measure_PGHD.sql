SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	14-DEC-2017
-- Description:		Search ACI Measure data for PGHD
-- =============================================

CREATE PROCEDURE [dbo].[ACI_Measure_PGHD]    
 @dr_id int, @dg_id int=NULL, @reporting_start_date date, @reporting_end_date date    
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 SET NOCOUNT ON;    
 DECLARE @MeasureStage as varchar(10), @MeasureCode VARCHAR(3);
 SET @MeasureStage = 'MIPS2017';    
 SET @MeasureCode = 'PPD';  
 DECLARE @dc_id INT
 SELECT @dc_id=dg.dc_id FROM doctors d INNER JOIN doc_groups dg ON d.dg_id=dg.dg_id WHERE d.dr_id =  @dr_id ;
    
	DECLARE @DENOMINATOR_PATIENTS TABLE 
	(
		PatientId BIGINT
	);
	IF @dg_id IS  NULL
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT enc.patient_id as DenomPatient 
		FROM enchanced_encounter enc WITH(NOLOCK)
		WHERE 
		enc.dr_id = @dr_id AND
		enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
		AND enc.issigned=1  
		AND enc.type_of_visit = 'OFICE'
		GROUP BY enc.patient_id
	END
	ELSE
	BEGIN
		INSERT INTO @DENOMINATOR_PATIENTS
		SELECT  enc.patient_id as DenomPatient 
		FROM enchanced_encounter enc WITH(NOLOCK)
		INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
		WHERE 
		doc.dg_id=@dg_id AND
		enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
		AND enc.issigned=1 
		AND enc.type_of_visit = 'OFICE'
		GROUP BY enc.patient_id
	END ;
    
 WITH measures_data AS    
 (    
  SELECT  @MeasureCode AS MeasureCode, @MeasureStage AS MeasureStage, @dr_id AS dr_id, @dg_id  AS dg_id
 ),  
 Numerator_Data AS    
 (
	SELECT DISTINCT ppd.pat_id  AS NumPatient
	FROM patient_documents ppd WITH(NOLOCK)
	INNER JOIN @DENOMINATOR_PATIENTS den  ON ppd.pat_id=den.PatientId
	WHERE 
	ppd.upload_date BETWEEN @reporting_start_date AND @reporting_end_date 
	AND ppd.cat_id=11
 )   
     
    
 select  VMD.dr_id, MUM.MeasureCode, (SELECT COUNT(PatientId) FROM @DENOMINATOR_PATIENTS) AS Denominator, 
 (SELECT COUNT(NumPatient) FROM Numerator_Data) AS Numerator, 
    MUM.MeasureName, MUM.DisplayOrder, MUM.MeasureDescription, MUM.PassingCriteria, MUm.MeasureGroup, MUM.MeasureStage, null as MeasureResult,MUM.MeasureGroupName,MUM.Id, MUM.MeasureClass,  MUM.Performace_points_per_10_percent, MUM.MeasureCalculation
 from  measures_data    VMD  with(nolock)    
 inner join dbo.MIPSMeasures    MUM  with(nolock) on MUM.MeasureCode  = VMD.MeasureCode    
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
