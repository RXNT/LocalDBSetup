SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE  [dbo].[STAGEII_MISSING_PATIENT_RADIOLOGY_LABS] 
@dr_id INT,  
@reporting_start_date DATETIME,  
@reporting_end_date DATETIME,
@measureCode VARCHAR(3)   
AS  
BEGIN  
--SELECT PA_ID as Patient,PA_FIRST AS FirstName, PA_LAST AS LastName, PA_DOB AS DateOfBirth, PA_SEX AS sex,
--	   PA_ADDRESS1 AS Address1, PA_CITY AS City,
--	   PA_STATE AS State, PA_ZIP AS ZipCode,PA_SSN AS CHART FROM PATIENTS   
--WHERE PA_ID IN (SELECT DISTINCT PA_ID FROM MUMEASURECOUNTS MUC WITH(NOLOCK)   
-- WHERE 1=1   
-- AND MUC.DR_ID = @dr_id   
-- AND MUC.MEASURECODE = @measureCode  
-- AND MUC.DateAdded BETWEEN CONVERT(VARCHAR(10),@reporting_start_date,120) AND CONVERT(VARCHAR(10),@reporting_end_date,120) 
-- AND MUC.ISDENOMINATOR = 1  
-- AND MUC.PA_ID NOT IN (SELECT DISTINCT PA_ID FROM MUMEASURECOUNTS MUC WITH(NOLOCK)   
-- WHERE 1=1   
-- AND MUC.DR_ID = @dr_id   
-- AND MUC.MEASURECODE = @measureCode  
-- AND MUC.DateAdded BETWEEN CONVERT(VARCHAR(10),@reporting_start_date,120) AND CONVERT(VARCHAR(10),@reporting_end_date,120) 
-- AND MUC.ISNUMERATOR= 1)  

	SELECT PA_ID as Patient,PA_FIRST AS FirstName, PA_LAST AS LastName, PA_DOB AS DateOfBirth, PA_SEX AS sex,
	PA_ADDRESS1 AS Address1, PA_CITY AS City,
	PA_STATE AS State, PA_ZIP AS ZipCode,PA_SSN AS CHART FROM PATIENTS   
	WHERE PA_ID IN (select PLO.pa_id 
	from patient_lab_orders PLO with(nolock)
	inner join patient_lab_orders_master PLM with(nolock) on PLO.lab_master_id = PLM.lab_master_id
	where test_type=1 
	and PLM.dr_id =@dr_id 
	and PLO.added_date between @reporting_start_date and @reporting_end_date 
	and PLO.pa_id NOT IN 
	(
	select PLO.pa_id 
	from patient_lab_orders PLO with(nolock)
	inner join patient_lab_orders_master PLM with(nolock) on PLO.lab_master_id = PLM.lab_master_id
	inner join lab_main LBR with(nolock) on PLO.lab_master_id = LBR.lab_order_master_id
	where test_type=1
	and PLM.dr_id =@dr_id
	and PLO.added_date between @reporting_start_date and @reporting_end_date
	))
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
