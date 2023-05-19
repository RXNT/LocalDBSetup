SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0024_POP1_NUMER] 
	@PatientIds varchar(max)  
AS
BEGIN
declare @query varchar(max);
set @query = 'SELECT count(distinct PAT.pa_id)SM FROM patients PAT INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id 
                 WHERE PAT.pa_id in ('+@PatientIds+') 
                 AND PAD.icd9 in (select code from NQF_Codes NQF where NQF.code_type=''ICD-9'' and NQF.IsActive = 1 
                 and NQF.IsExclude=0 and NQF.NQF_id=0024 and NQF.criteriatype=''NUM1'' and NQF.criteria=1)'; 
exec(@query);

set @query = 'SELECT count(distinct PAT.pa_id)SM FROM patients PAT INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id 
                 WHERE PAT.pa_id in ('+@PatientIds+') AND 
                 PAD.icd9 in (select code from NQF_Codes NQF where NQF.code_type=''ICD-9'' and NQF.IsActive = 1 
                 and NQF.IsExclude=0 and NQF.NQF_id=0024 and NQF.criteriatype=''NUM2'' and NQF.criteria=1)'; 
exec(@query);

set @query = 'SELECT count(distinct PAT.pa_id)SM FROM patients PAT INNER JOIN patient_active_diagnosis PAD ON PAT.pa_id=PAD.pa_id 
                 WHERE PAT.pa_id in ('+@PatientIds+') AND 
                 PAD.icd9 in (select code from NQF_Codes NQF where NQF.code_type=''ICD-9'' and NQF.IsActive = 1 
                 and NQF.IsExclude=0 and NQF.NQF_id=0024 and NQF.criteriatype=''NUM3'' and NQF.criteria=1)';
exec(@query);                       
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
