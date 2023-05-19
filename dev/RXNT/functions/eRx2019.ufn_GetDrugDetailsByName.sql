SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetDrugDetailsByName] 
( 
    @DrugName VARCHAR(255)
) 
	RETURNS @Output TABLE(DrugId BIGINT,DrugName VARCHAR(255),DrugLevel INT
) 
BEGIN 
   
    INSERT INTO @Output (DrugId,DrugName,DrugLevel)  
	SELECT TOP 1 a.medid,b.med_medid_desc,B.med_REF_DEA_CD FROM rmindc1 a WITH(NOLOCK) 
	INNER JOIN rmiid1 b  WITH(NOLOCK)  ON a.medid=b.medid 
	WHERE med_medid_desc =@DrugName+'%'
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
