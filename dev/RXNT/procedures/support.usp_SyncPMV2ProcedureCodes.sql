SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 

      
CREATE   PROCEDURE [support].[usp_SyncPMV2ProcedureCodes] 
AS
BEGIN 
	DECLARE @ApplicationTableId BIGINT
	SELECT @ApplicationTableId= ApplicationTableId FROM [ehr].[ApplicationTables]WITH(NOLOCK) WHERE Code='PCTYP'

	INSERT INTO cpt_codes(Code,Description,long_desc,created_at,DataSource,ProcedureCodeTypeId)
	SELECT ProcedureCode,ProcedureName,ProcedureDescription,CreatedDate,DataSource,ApplicationTableConstantId  FROM (SELECT MAX(A.ProcedureCodeId) ProcedureCodeId, A.ProcedureCode,MAX(A.ProcedureName) ProcedureName,MAX(A.ProcedureDescription) ProcedureDescription,MAX(A.CreatedDate) CreatedDate,MAX(A.DataSource) DataSource,MAX(D.ApplicationTableConstantId) ApplicationTableConstantId
	FROM [dbo].[RsynPMV2ProcedureCodes] A WITH(NOLOCK)
	LEFT OUTER JOIN cpt_codes B WITH(NOLOCK) ON A.ProcedureCode=B.Code-- AND A.ProcedureName=B.Description AND A.ProcedureDescription=B.long_desc
	LEFT OUTER JOIN [dbo].[RsynPMV2ApplicationTableConstants] C  WITH(NOLOCK) ON A.ProcedureCodeTypeId = C.ApplicationTableConstantId
	LEFT OUTER JOIN [ehr].[ApplicationTableConstants] D  WITH(NOLOCK) ON D.ApplicationTableId=@ApplicationTableId AND D.Code = C.Code
	WHERE B.Code IS NULL -- AND DataSource='SystemAdmin'
	GROUP BY A.ProcedureCode) A
END
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
