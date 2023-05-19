SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0043_NUMER]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME 
AS
BEGIN
BEGIN TRY
	select count(distinct PAT.pa_id)SM from patients PAT inner join (select pa_id from patient_procedures PP 
                     INNER JOIN NQF_Codes NQF on PP.code=NQF.code where NQF.NQF_id='0043' and NQF.code_type='CPT' 
                     and criteriatype='POP1' and criteria=1 and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid
                     AND PP.date_performed between @startdate AND @enddate
                     group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id INNER JOIN prescriptions pres 
                     on pat.pa_id=pres.pa_id inner join prescription_details pd
                     on pres.pres_id=pd.pres_id where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 64*12 and 
                     PD.ddid in 
                     (select code from NQF_CODES where IsActive=1 AND IsExclude=0 AND NQF_id='0043' AND criteriatype='NUM1' AND code_type='MED');
                     
    
                     
    select count(distinct PAT.pa_id)SM from patients PAT inner join (select pa_id from patient_procedures PP 
                     INNER JOIN NQF_Codes NQF on PP.code=NQF.code where NQF.NQF_id='0043' and NQF.code_type='CPT' 
                     and criteriatype='POP1' and criteria=1 and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid
                     AND PP.date_performed between @startdate AND @enddate 
                     group by pa_id having count(pa_id) > 0)PPC on PAT.pa_id=PPC.pa_id INNER JOIN tblVaccinationRecord VAC 
                     on pat.pa_id=vac.vac_pat_id inner join tblVaccines vc on VAC.vac_id=vc.vac_id 
                     where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 64*12 and VAC.vac_dt_admin between @startdate AND @enddate
                     and vc.vac_exp_code in 
                     (select code from NQF_CODES where IsActive=1 AND IsExclude=0 AND NQF_id='0043' AND criteriatype='NUM1' AND code_type='CVX' AND criteria=2);                  
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
