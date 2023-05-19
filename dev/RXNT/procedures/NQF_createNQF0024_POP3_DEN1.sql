SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0024_POP3_DEN1]
	@PatientIds varchar(max)  
AS
BEGIN
   declare @query varchar(max)
   set @query ='select distinct PAT.PA_ID FROM PATIENTS PAT INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id where 
                 PAT.pa_id in ('+@PatientIds+') AND PAD.icd9 not in (select code from NQF_Codes 
                 NQF where NQF.code_type=''ICD-9'' and NQF.IsActive = 1 
                 and NQF.IsExclude=1 and NQF.NQF_id=0024 and NQF.criteriatype=''DENOM'' and NQF.criteria=1)';
                 
   exec(@query)             
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
