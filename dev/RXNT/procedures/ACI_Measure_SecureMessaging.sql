SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Reiah    
-- Create date: 09/14/2017
-- Description: Procedure to get the measures data for secure messaging    
-- =============================================    
CREATE PROCEDURE [dbo].[ACI_Measure_SecureMessaging]
	@dr_id INT, 
	@dg_id INT = NULL, 
	@reporting_start_date DATE, 
	@reporting_end_date DATE, 
	@meASureCode VARCHAR(3) = 'SEM'    
AS   
BEGIN    
	SET NOCOUNT ON;    
	DECLARE @MeASureStage AS VARCHAR(10);    
	SET @MeASureStage = 'MIPS2017';    
    DECLARE @dr_dgId INT ;    
  
	DECLARE @dc_id INT
	SELECT @dc_id=dg.dc_id FROM doctors d INNER JOIN doc_groups dg ON d.dg_id=dg.dg_id WHERE d.dr_id =  @dr_id ;
	
	IF @dg_id IS NULL
	BEGIN
		SELECT @dr_dgId = dg_id FROM dbo.doctors WITH (NOLOCK) where dr_id = @dr_id
	END
	ELSE
	BEGIN
		SET @dr_dgId = @dg_id;
	END;
	
	WITH MEASURES_DATA AS
	(    
		SELECT  @meASureCode AS MeASureCode, 
			'MIPS2017' AS MeASureStage, 
			@dr_id AS dr_id    
	),   
	 
	DENOMINATOR_PATIENTS AS    
	(    
		 SELECT DISTINCT enc.patient_id as PatientId 
		  FROM enchanced_encounter enc WITH(NOLOCK)
		  INNER JOIN doctors doc WITH(NOLOCK) ON enc.dr_id=doc.dr_id
		  INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=doc.dg_id
		  INNER JOIN doc_groups dg1 WITH(NOLOCK) ON dg1.dc_id=dg.dc_id
		  WHERE dg.dc_id=@dc_id AND
		  ((@dg_id IS NULL AND enc.dr_id = @dr_id) OR
		  (@dg_id IS NOT NULL AND dg1.dg_id=@dr_dgId) )
		  AND enc.type_of_visit = 'OFICE'  
		  AND
		  enc.enc_date BETWEEN @reporting_start_date AND @reporting_end_date
		  AND enc.issigned=1  
	),
 
	NUMERATOR_PATIENTS AS    
	(    
		--SELECT DISTINCT PAT.pa_id AS PatientId  
		--FROM doctor_patient_messages  dpm  WITH(NOLOCK) 
		--INNER JOIN DENOMINATOR_PATIENTS DP WITH(NOLOCK) ON DP.PatientId =  dpm.to_id  NEED TO CONFIRM
		--INNER JOIN patients PAT WITH(NOLOCK) ON PAT.pa_id =  dpm.to_id   
		--where  1=1    
		--AND dpm.from_id = @dr_id    
		--AND dpm.msg_date between @reporting_start_date and @reporting_end_date  
		
		SELECT DISTINCT DP.PatientId AS PatientId  
		FROM  dbo.MUMeasureCounts MDRP    WITH(NOLOCK)
		INNER JOIN  DENOMINATOR_PATIENTS  DP  WITH(NOLOCK) ON  MDRP.pa_id = DP.PatientId 
		INNER JOIN doctors doc WITH(NOLOCK) ON MDRP.dr_id=doc.dr_id
		INNER JOIN patients pat WITH(NOLOCK) ON DP.PatientId = pat.pa_id
		INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
		WHERE dg.dc_id=@dc_id AND MDRP.MeasureCode = @meASureCode and MDRP.IsNumerator = 1 and  
		MDRP.DateAdded  between @reporting_start_date and @reporting_end_date    
		
	)   


	SELECT  
		VMD.dr_id, 
		MUM.MeASureCode,
		(SELECT COUNT(PatientId) AS Numerator FROM  NUMERATOR_PATIENTS) AS Numerator, 
		(SELECT COUNT(PatientId) AS Denominator FROM  DENOMINATOR_PATIENTS) AS Denominator,   
		MUM.MeASureName, 
		MUM.DisplayOrder, 
		MUM.MeASureDescription, 
		MUM.PASsingCriteria, 
		MUM.MeASureGroup, 
		MUM.MeASureStage, 
		NULL AS MeASureResult,
		MUM.MeASureGroupName,
		MUM.Id, 
		MUM.MeASureClASs,  
		MUM.Performace_points_per_10_percent, 
		MUM.MeASureCalculation
	FROM  MEASURES_DATA  VMD  with(nolock)    
	INNER JOIN dbo.MIPSMeASures   MUM  with(nolock) on MUM.MeASureCode  = VMD.MeASureCode    
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
