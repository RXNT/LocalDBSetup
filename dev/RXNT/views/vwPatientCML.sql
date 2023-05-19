SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwPatientCML]
AS
SELECT MAX(p.pres_id) AS pres_id,p.pa_id,pd.dosage,pd.prn_description FROM prescriptions p WITH(NOLOCK)
INNER JOIN prescription_details pd WITH(NOLOCK) ON p.pres_id = pd.pres_id
LEFT OUTER JOIN prescription_discharge_requests pdr WITH(NOLOCK) ON pdr.pres_id = pd.pres_id AND pdr.approved_by>0
WHERE pd.history_enabled!=0 AND pdr.discharge_request_id IS NULL AND p.pres_approved_date IS NOT NULL AND ISNULL(p.pres_void,0)=0
GROUP BY p.pa_id,pd.ddid,pd.dosage,pd.prn_description
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
