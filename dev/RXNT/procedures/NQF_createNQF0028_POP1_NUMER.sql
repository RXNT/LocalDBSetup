SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0028_POP1_NUMER]
    @doctorid BIGINT,
    @startdate datetime,
    @enddate datetime  
AS
BEGIN
BEGIN TRY
  select count(distinct PAT.pa_id)SM from patients PAT inner join ((select distinct PP.pa_id from patient_procedures PP 
                     INNER JOIN NQF_Codes NQF on PP.code=NQF.code inner join (select distinct pp.pa_id from patient_procedures PP inner join 
                     patient_flag_details pfd on PP.pa_id=pfd.pa_id where PP.date_performed between @startdate AND @enddate
                     AND PP.dr_id=@doctorid AND pfd.flag_id in (5,6,7,10,11) AND 
                     (pfd.date_added is null or datediff(month,pfd.date_added,PP.date_performed) >= 24)) pfd on PP.pa_id=pfd.pa_id 
                     where NQF.NQF_id='0028' and NQF.code_type='CPT' and 
                     criteriatype='POP1' and criteria=1 and NQF.IsActive=1 and PP.date_performed between @startdate AND @enddate
                     AND NQF.IsExclude=0 and PP.dr_id=@doctorid 
                     group by PP.pa_id having count(PP.pa_id) > 1)UNION( select PP.pa_id from patient_procedures PP INNER JOIN NQF_Codes NQF
                     on PP.code=NQF.code inner join (select distinct pp.pa_id from patient_procedures PP inner join patient_flag_details pfd on PP.pa_id=pfd.pa_id where 
                     PP.date_performed between @startdate AND @enddate
                     AND PP.dr_id=@doctorid AND 
                     pfd.flag_id in (5,6,7,10,11) AND (pfd.date_added is null or datediff(month,pfd.date_added,PP.date_performed) >= 24)) pfd on PP.pa_id=pfd.pa_id 
                     where NQF.NQF_id='0028' and NQF.code_type='CPT' and criteriatype='POP2' and criteria=1 
                     and NQF.IsActive=1 and PP.date_performed between @startdate AND @enddate 
                     AND NQF.IsExclude=0 and PP.dr_id=@doctorid
                     group by PP.pa_id having count(PP.pa_id) > 0 
                 ))PPC on PAT.pa_id=PPC.pa_id 
                 where datediff(month,PAT.pa_dob,CONVERT(datetime,@startdate,101)) >= 18*12 
                 and not (pa_dob like '1901-01-01');                              
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
