SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CreateCompanyLevelFlags] 
AS
BEGIN
	SELECT fg.* INTO #MasterFlags 
	FROM patient_flags fg WITH(NOLOCK) WHERE dc_id=0 AND NOT EXISTS (SELECT 1 FROM  ehr.ApplicationTableConstants ATC 
	INNER JOIN ehr.ApplicationTables AT ON ATC.ApplicationTableId=AT.ApplicationTableId 
	WHERE AT.Code='SMOKE' AND ATC.Code = CAST(FLAG_ID AS VARCHAR(50)))
 
	UPDATE pf SET parent_flag_id=mf.flag_id 
	FROM patient_flags pf WITH(NOLOCK) 
	INNER JOIN #MasterFlags mf  WITH(NOLOCK) ON pf.flag_title=mf.flag_title
	WHERE pf.dc_id>0

	SELECT TOP 100 mf.flag_title,mf.is_enabled,dc.dc_id,mf.hide_on_search,mf.flag_id AS parent_flag_id
	INTO #MissingCompanyFlags
	FROM doc_companies dc WITH(NOLOCK)
	CROSS JOIN #MasterFlags mf  WITH(NOLOCK)  
	LEFT OUTER JOIN patient_flags pf WITH(NOLOCK) ON dc.dc_id=pf.dc_id AND mf.flag_title=pf.flag_title AND  pf.dc_id>0 
	WHERE pf.flag_id IS NULL
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #MissingCompanyFlags)
	BEGIN 
		INSERT INTO patient_flags (flag_title,is_enabled,dc_id,hide_on_search,parent_flag_id )
		SELECT flag_title,is_enabled,dc_id,hide_on_search,parent_flag_id FROM #MissingCompanyFlags
		DELETE FROM #MissingCompanyFlags	
		
		INSERT INTO #MissingCompanyFlags
		SELECT TOP 100 mf.flag_title,mf.is_enabled,dc.dc_id,mf.hide_on_search,mf.flag_id 
		FROM doc_companies dc WITH(NOLOCK)
		CROSS JOIN #MasterFlags mf  WITH(NOLOCK)  
		LEFT OUTER JOIN patient_flags pf WITH(NOLOCK) ON dc.dc_id=pf.dc_id AND mf.flag_title=pf.flag_title AND  pf.dc_id>0 
		WHERE pf.flag_id IS NULL
	END
	DROP TABLE #MissingCompanyFlags
	DROP TABLE #MasterFlags
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
