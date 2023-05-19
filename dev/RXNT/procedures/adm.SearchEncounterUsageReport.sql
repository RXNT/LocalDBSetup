SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 19-NOV-2018
-- Description:	Search Encounter Usage Report
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[SearchEncounterUsageReport]
	@FromDate							DATETIME,
	@ToDate								DATETIME,
	@DoctorCompanyId					BIGINT=0,
	@DoctorGroupId						BIGINT=0,
	@DoctorFirstName					VARCHAR(50)=NULL,
	@DoctorLastName						VARCHAR(50)=NULL
AS
BEGIN
	SELECT DC.dc_id, DC.dc_name, DG.dg_id, DG.dg_name, DR.dr_id, DR.dr_first_name, DR.dr_last_name,
	SUM(case WHEN EE.issigned=1 THEN 1 ELSE 0 END) SignedEncounterCount,
	SUM(case WHEN EE.issigned=1 THEN 0 ELSE 1 END) UnsignedEncounterCount
	FROM enchanced_encounter EE WITH(NOLOCK)
	INNER JOIN doctors DR WITH(NOLOCK) ON EE.dr_id=DR.dr_id
	INNER JOIN doc_groups DG WITH(NOLOCK) ON DR.dg_id=DG.dg_id
	INNER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id
	WHERE CAST(CONVERT(VARCHAR(10), EE.enc_date, 101) AS DATETIME) >= CAST(CONVERT(VARCHAR(10), @FromDate, 101) AS DATETIME)
	AND CAST(CONVERT(VARCHAR(10), EE.enc_date, 101) AS DATETIME) <= CAST(CONVERT(VARCHAR(10), @ToDate, 101) AS DATETIME)
	AND (ISNULL(@DoctorCompanyId,0)=0 OR DC.dc_id=@DoctorCompanyId)
	AND (ISNULL(@DoctorGroupId,0)=0 OR DG.dg_id=@DoctorGroupId)
	AND	(@DoctorFirstName IS NULL OR DR.dr_first_name LIKE '%' + @DoctorFirstName + '%')
	AND	(@DoctorLastName IS NULL OR DR.dr_last_name LIKE '%' + @DoctorLastName + '%')
	GROUP BY DC.dc_id, DC.dc_name, DG.dg_id, DG.dg_name, DR.dr_id, DR.dr_first_name, DR.dr_last_name
	ORDER BY DC.dc_name, DG.dg_name, DR.dr_first_name, DR.dr_last_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
