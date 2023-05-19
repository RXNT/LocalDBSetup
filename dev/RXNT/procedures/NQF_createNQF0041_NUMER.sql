SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0041_NUMER]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME 
AS
BEGIN
BEGIN TRY
	select count(distinct PAT.pa_id)SM from patients PAT inner join 
                     ((select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0041' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=1 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND ((PP.date_performed between 
                     @startdate AND @enddate)) 
                     group by pa_id having count(pa_id) > 0) union (select pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF on PP.code=NQF.code 
                     where NQF.NQF_id='0041' and NQF.code_type='CPT' and criteriatype='POP1' and criteria=2 
                     and NQF.IsActive=1 and NQF.IsExclude=0 and dr_id=@doctorid AND PP.date_performed between 
                     @startdate AND @enddate 
                     group by pa_id having count(pa_id) > 2))PPC on PAT.pa_id=PPC.pa_id inner join tblVaccinationRecord VAC ON
                     VAC.vac_pat_id=PAT.pa_id inner join tblVaccines TVAC on VAC.vac_id=TVAC.vac_id inner join 
                     NQF_codes NQF on TVAC.vac_exp_code=NQF.code inner join patient_procedures PP on PAT.pa_id=PP.pa_id 
                     where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 50*12 and 
                      not (pa_dob like '1901-01-01') AND ((VAC.vac_dt_admin between 
                     DATEADD(month,0,@startdate) AND  DATEADD(month,2,@startdate)) OR (VAC.vac_dt_admin between 
                     DATEADD(month,8,@startdate) AND @enddate) 
                     ) AND  NQF.NQF_id='0041' 
                     and NQF.code_type='CVX' and criteriatype='NUM1' AND PP.date_performed between 
                     @startdate AND @enddate AND 
                     PP.CODE in (select code from NQF_Codes where NQF_id='0041' and  code_type='CPT' 
                     and IsActive = 1 and criteria = 3 and criteriatype = 'POP1') 
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
