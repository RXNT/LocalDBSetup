SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetRxInfoByRxId] 
( 
    @RxId BIGINT,
    @DoctorCompanyId BIGINT
) 
	RETURNS @Output TABLE(PatientId BIGINT,DrugId BIGINT,DoctorId BIGINT,DrugLevel INT,IsEPCSEnabled BIT,RxDetailId BIGINT
) 
BEGIN 
   
    INSERT INTO @Output (PatientId,DrugId,DoctorId,DrugLevel,IsEPCSEnabled,RxDetailId)  
	SELECT TOP 1 a.pa_id,b.ddid,a.dr_id,R.MED_REF_DEA_CD druglevel,case when c.epcs_enabled is null then 0 else c.epcs_enabled end epcs_enabled, b.pd_id 
	FROM prescriptions a with(nolock) 
	INNER JOIN prescription_details b with(nolock) ON a.pres_id=b.pres_id 
	INNER JOIN doctors c with(nolock) ON a.dr_id=c.dr_id inner join doc_groups dg ON c.dg_id=dg.dg_id 
	INNER JOIN RMIID1 R with(nolock) on b.ddid=R.medid 
	WHERE a.pres_id = @RxId AND dg.dc_id=@DoctorCompanyId
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
