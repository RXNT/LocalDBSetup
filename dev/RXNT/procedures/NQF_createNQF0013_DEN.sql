SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[NQF_createNQF0013_DEN]
    @doctorid BIGINT , 
	@startdate DATETIME ,
	@enddate DATETIME ,
	@dcid INT
AS
BEGIN
	select count(distinct A.pa_id)SM from patients A inner join patient_active_diagnosis B on A.pa_id=B.pa_id  
                   inner join (select pa_id from PATIENT_PROCEDURES PR INNER JOIN NQF_Codes NQ on PR.code=NQ.code 
                       where dr_id=@doctorid and NQ.code_type LIKE 'CPT' AND NQ.IsExclude=0 AND NQ.IsActive=1 
                       AND PR.date_performed between @startdate AND @enddate 
                       group by pa_id having count(pa_id) > 1)C on A.pa_id=C.pa_id inner join NQF_Codes NQ on B.icd9=NQ.code 
                       where A.dg_id in (select dg_id from doc_groups where 
                       dc_id=@dcid) and datediff(month,A.pa_dob,CONVERT(datetime,@startdate,101)) >= 18*12 and not (pa_dob like '1901-01-01') 
                       AND NQ.NQF_id='0013' AND NQ.code_type LIKE 'ICD-9' AND NQ.IsExclude=0 AND NQ.IsActive=1 AND B.enabled=1;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
