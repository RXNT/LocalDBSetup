SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
  
CREATE  VIEW [dbo].[vwPatientPayers]  
AS  
 /*
 A - Medicare
 B - Medicaid
 C - Private Health Insurance
 D - Other
 */
SELECT  b.medicare_type_code,a.pa_id  from RxNTBilling.dbo.cases a   
INNER JOIN RxNTBilling.dbo.case_payers b on a.case_id=b.case_id  
WHERE LEN(LTRIM(RTRIM(b.medicare_type_code)))>0
GROUP BY  b.medicare_type_code,a.pa_id   
  
  
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
