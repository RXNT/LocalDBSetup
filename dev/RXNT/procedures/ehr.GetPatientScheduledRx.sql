SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*   
=======================================================================================   
Author    : Niyaz  
Create date   : 10th-Sep-2018  
Description   :   
Last Modified By :   
Last Modifed Date :   
=======================================================================================   
*/   
CREATE PROCEDURE [ehr].[GetPatientScheduledRx]  
 @PatientId INT  
AS   
BEGIN    
 --SELECT * FROM vwDrRecurringPrescriptionsLog WITH(NOLOCK) WHERE pa_id=@PatientId  
  
 DECLARE @StartDate DATETIME =CAST(convert(varchar(10), getdate(),120) AS DATETIME)   
  
 SELECT dr.dr_last_name,dr.dr_first_name,pres.pres_entry_date,pat.pa_dob,  
                        pat.pa_first,pat.pa_last,pat.pa_middle,pat.pa_phone,pd.pres_id,  
      V.pd_id,pd.drug_name,pd.dosage,pd.duration_amount,pd.duration_unit,pd.numb_refills,pd.use_generic,  
                        pd.comments,pd.DAYS_SUPPLY,pd.compound,pd.prn,pd.prn_description,pd.max_daily_dosage,ph.pharm_company_name,pres.pharm_id,ph.pharm_address1,  
                        ph.pharm_address2,  
                        ph.pharm_city,ph.pharm_state,ph.pharm_zip,ph.pharm_zip,ph.pharm_phone,V.se_id,V.next_fire_date,V.repeat_count,V.fire_count,V.repeat_interval,V.repeat_unit ,
						CASE WHEN rm.med_ref_dea_cd IS NULL THEN 0 ELSE rm.med_ref_dea_cd END DRUGLEVEL
 FROM scheduled_events V  WITH(NOLOCK)   
 inner join doctors dr on v.for_user_id = dr.dr_id   
 INNER JOIN prescription_details pd WITH(NOLOCK) ON pd.pd_id=V.pd_id  
 INNER JOIN prescriptions pres WITH(NOLOCK) ON pd.pres_id=pres.pres_id  
 INNER JOIN dbo.patients Pat WITH(NOLOCK) ON pres.pa_id = pat.pa_id   
 LEFT OUTER JOIN pharmacies ph ON ph.pharm_id = pres.pharm_id  
 LEFT OUTER JOIN RMIID1 rm WITH(NOLOCK) ON pd.ddid = rm.MEDID     
 WHERE pres.pa_id=@PatientId  
 AND ((next_fire_date >= @StartDate  
                                 OR (repeat_unit <> '' AND repeat_count <> 0 AND fire_count < repeat_count)   
                                  OR (repeat_unit <> '' AND repeat_count = 0 )    
                                  OR (first_fire_date >=@StartDate)   
                                 )) ORDER BY pa_last, pa_first;   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
