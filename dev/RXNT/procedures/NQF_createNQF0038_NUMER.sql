SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0038_NUMER]
    @dcid VARCHAR(15),
    @PatientIds varchar(max)  
AS
BEGIN
BEGIN TRY
 declare @query varchar(max);
 set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM1'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+')
                     and PAT.pa_id in ('+@PatientIds+') and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id AS varchar(15))= nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN'' and criteriatype=''NUM1'' where pa_id in ('+@PatientIds+')) 
                     and PAT.pa_id not in (select pa_id from patient_active_diagnosis PAD 
                     inner join NQF_Codes nqf on pd.ddid = nqf.code and nqf_id=0038 and isactive=1 and nqf.code_type=''ICD-9'' and criteriatype=''NUM1'' 
                     where pa_id in ('+@PatientIds+')) group by PAT.pa_id having count(PAT.pa_id) >= 4'; 
  exec(@query)
  
  set @query = 'select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM2'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in 
                     ('+@PatientIds+') and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on CAST(PA.allergy_id As Varchar(15)) = nqf.code and PA.allergy_type=6 and
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN6'' and criteriatype=''NUM2'' where pa_id in ('+@PatientIds+')) 
                     and PAT.pa_id not in (select pa_id from patient_new_allergies PA inner join NQF_Codes nqf 
                     on CAST(PA.allergy_id As Varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM2'' where pa_id in ('+@PatientIds+')) 
                     group by PAT.pa_id having count(PAT.pa_id) >= 3';
                     
   exec(@query)   
   
  set @query = 'SELECT * INTO PatientIDList FROM(select pa_id from patients PAT where pa_id in ('+@PatientIds+') AND pa_id not in (
                     select pa_id from patient_active_diagnosis PAD inner join NQF_Codes NQF on PAD.icd9=NQF.code 
                     where pa_id in ('+@PatientIds+') and nqf_id=0038 and isactive=1 and NQF.code_type=''ICD9'' AND
                     criteria=4 and criteriatype=''NUM3'') and pa_id not in (select pa_id from patient_new_allergies PA inner join NQF_Codes NQF 
                     on cast(PA.allergy_id As varchar(15))=NQF.code AND PA.allergy_type=6 where pa_id in ('+@PatientIds+') and
                     nqf_id=0038 and isactive=1 and NQF.code_type=''ALLERGEN6'' and criteria=4 and criteriatype=''NUM3'')) AS PatientsList';
      
   exec(@query)
   
   select distinct pa_id from patients PAT where pa_id in (SELECT pa_id From PatientIDList) AND pa_id in (
                     (select VA.vac_pat_id from tblVaccinationRecord VA inner join tblVaccines PVA on VA.vac_id=PVA.vac_id 
                     inner join patients PAT 
                     on VA.vac_pat_id = PAT.pa_id where VA.vac_pat_id in (SELECT pa_id From PatientIDList) AND 
                     vac_exp_code='07' and  DATEDIFF(month,pa_dob,vac_dt_admin) < 2*12 AND VA.vac_pat_id not in (select 
                 pa_id from patient_new_allergies where pa_id in (SELECT pa_id From PatientIDList) and 
                 ((allergy_id in (7591,116097) and allergy_type=2) Or (allergy_id = 3035 and allergy_type=6))) group by VA.vac_pat_id having count(VA.vac_pat_id) > 1) 
                 UNION (select pa_id from 
                 patient_active_diagnosis where pa_id in (SELECT pa_id From PatientIDList) AND icd9 ='072' and enabled=2)) 
                 AND PAT.pa_id in (
                     (select VA.vac_pat_id from tblVaccinationRecord VA inner join tblVaccines PVA on VA.vac_id=PVA.vac_id inner join patients PAT 
                     on VA.vac_pat_id = PAT.pa_id where VA.vac_pat_id in (SELECT pa_id From PatientIDList) AND
                     DATEDIFF(month,pa_dob,vac_dt_admin) < 2*12 AND vac_exp_code='05' and VA.vac_pat_id not in (select 
                 pa_id from patient_new_allergies where pa_id in (SELECT pa_id From PatientIDList) and 
                 ((allergy_id = 3027 and allergy_type=6))) group by VA.vac_pat_id having count(VA.vac_pat_id) > 1) 
                 UNION (select pa_id from 
                 patient_active_diagnosis where pa_id in (SELECT pa_id From PatientIDList) AND icd9 ='99.45' AND enabled=2)) 
                 AND pa_id in (
                     (select VA.vac_pat_id from tblVaccinationRecord VA inner join tblVaccines PVA on VA.vac_id=PVA.vac_id 
                     inner join patients PAT on VA.vac_pat_id = PAT.pa_id 
                     where VA.vac_pat_id in (SELECT pa_id From PatientIDList) AND vac_exp_code='04' and DATEDIFF(month,pa_dob,vac_dt_admin) < 2*12 
                     AND pa_id not in (select 
                 pa_id from patient_new_allergies where pa_id in (SELECT pa_id From PatientIDList) and 
                 ((allergy_id = 3026 and allergy_type=6))) group by VA.vac_pat_id having count(VA.vac_pat_id) > 1) 
                 UNION (select pa_id from 
                 patient_active_diagnosis where pa_id in (SELECT pa_id From PatientIDList) AND icd9 ='056' AND enabled=2)) AND pa_id not in 
                 (select pa_id from patient_new_allergies where pa_id in (SELECT pa_id From PatientIDList) and 
                 allergy_id = 3116 and allergy_type=6) 
                 
          DROP TABLE PatientIDList
          
      set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM4'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in ('+@PatientIds+') 
                     and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id As varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM4'' where pa_id in ('+@PatientIds+')) 
                     group by PAT.pa_id having count(PAT.pa_id) >= 2';
     
      exec(@query)
      
      set @query ='(select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM5'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in ('+@PatientIds+') and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id as varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM5'' where pa_id in ('+@PatientIds+')) 
                     group by PAT.pa_id having count(PAT.pa_id) >= 3 ) UNION (select pa_id from patient_active_diagnosis where pa_id in ('+@PatientIds+') 
                     and icd9 in (''070.2'',''070.3'',''V02.61'') and enabled=2 and pa_id not in 
                    (select pa_id from patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id As varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM5'' where pa_id in ('+@PatientIds+')))';                                                             
      exec(@query) 
      
      set @query ='select pat.pa_id from patients pat inner join patient_active_diagnosis pad on pat.pa_id=pad.pa_id 
                     where pat.pa_id in ('+@PatientIds+') AND 
                     ICD9 in (''052'', ''053'') AND PAD.enabled=2 and PAT.pa_id in (select pa_id from patient_active_diagnosis 
                     where pa_id in ('+@PatientIds+') And ((ICD9 not in (''201'', ''202'', ''203'',
                     ''042'', ''V08'', ''200'', ''202'', ''204'', ''205'', ''206'', ''207'', ''208'', ''279'')) Or (ICD9 in (''201'', ''202'', ''203'',
                     ''042'', ''V08'', ''200'', ''202'', ''204'', ''205'', ''206'', ''207'', ''208'', ''279'') and enabled=0) )) and PAT.pa_id not in 
                     (select pa_id from patient_new_allergies where pa_id in ('+@PatientIds+') and 
                     allergy_id=45942 and allergy_type=2)'; 
                     
       exec(@query)
       
       set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM7'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in 
                     ('+@PatientIds+') and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id as varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM7'' where pa_id in ('+@PatientIds+')) 
                     group by PAT.pa_id having count(PAT.pa_id) >= 4';  
                     
       exec(@query)  
       
       set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM8'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in 
                     ('+@PatientIds+') and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id As varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM8'' where pa_id in (
                     '+@PatientIds+')) and PAT.pa_id not in (select pa_id from patient_active_diagnosis PAD 
                     inner join NQF_Codes nqf on pd.ddid = nqf.code and nqf_id=0038 and isactive=1 and nqf.code_type=''ICD-9'' and criteriatype=''NUM8'' 
                     where pa_id in ('+@PatientIds+')) group by PAT.pa_id having count(PAT.pa_id) >= 2'; 
                     
       exec(@query)
       
       set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM9'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in 
                     ('+@PatientIds+') and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and PAT.pa_id not in (select pa_id from 
                     patient_new_allergies PA inner join NQF_Codes nqf  on cast(PA.allergy_id As varchar(15)) = nqf.code and PA.allergy_type=2 and 
                     nqf_id=0038 and isactive=1 and nqf.code_type=''ALLERGEN2'' and criteriatype=''NUM9'' where pa_id in (
                     '+@PatientIds+')) group by PAT.pa_id having count(PAT.pa_id) >= 2'; 
                     
       exec(@query)
       
       set @query ='select PAT.pa_id from patients PAT inner join prescriptions PRES on PAT.pa_id=PRES.pa_id 
                     inner join prescription_details pd on pres.pres_id=pd.pres_id inner join NQF_Codes nqf on pd.ddid = nqf.code 
                     and nqf_id=0038 and isactive=1 and nqf.code_type=''MED'' and criteriatype=''NUM10'' 
                     where PRES.DG_ID IN (SELECT dg_id from doc_groups where dc_id='+@dcid+') and PAT.pa_id in 
                     ('+@PatientIds+') and DATEDIFF(DAY,pa_dob,PRES.pres_approved_date) >= 42  and 
                     DATEDIFF(month,pa_dob,PRES.pres_approved_date) < 2*12 and pres_void=0 and 
                     PAT.pa_id not in (select pa_id from patient_active_diagnosis 
                     where pa_id in ('+@PatientIds+') And ((ICD9 not in (''201'', ''202'', ''203'',
                     ''042'', ''V08'', ''200'', ''202'', ''204'', ''205'', ''206'', ''207'', ''208'', ''279'')) Or (ICD9 in (''201'', ''202'', ''203'',
                     ''042'', ''V08'', ''200'', ''202'', ''204'', ''205'', ''206'', ''207'', ''208'', ''279'') and status=0) )) and PAT.pa_id not in 
                     (select pa_id from patient_new_allergies where pa_id in ('+@PatientIds+') and 
                     allergy_id in (3029,3031) and allergy_type=6) group by PAT.pa_id having count(PAT.pa_id) >= 2'; 
                     
   exec(@query)                                
                                                         
END TRY
	  BEGIN CATCH
	   DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
		RAISERROR (@bkErrorMessage, -- Message text.
				   @bkErrorSeverity, -- Severity.
				   @bkErrorState -- State.
				   );
						   
	  END CATCH                     
                     
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
