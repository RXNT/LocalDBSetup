SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 26-Sep-2016
-- Description:	Get Patient - All Vitals MetaData
-- ============================================

CREATE PROCEDURE [ehr].[usp_GetPatientAllVitalsMetaData] 
(
@PatientId BIGINT,
@DoctorGroupId BIGINT,
@MaxRows INT = 10,
@StartDate DATETIME,
@EndDate DATETIME,
@DoctorCompanyId BIGINT
)
AS
BEGIN
	SELECT TOP(@MaxRows)
	 [pa_vt_id],
	 [pa_id],
	 [age],
	 [date_added],
	 [record_date]
	 FROM [dbo].[patient_vitals] pv WITH(NOLOCK)
	 INNER JOIN [dbo].[doctors] dr with(nolock) ON pv.added_by = dr.dr_id
	 INNER JOIN [dbo].[doc_groups] dg with(nolock) ON dg.dg_id = @DoctorGroupId
	 WHERE PA_ID = @PatientId and dg.dc_id = @DoctorCompanyId 
	 AND (pv.record_date >=@StartDate  OR @StartDate IS NULL) AND (pv.record_date <=@EndDate OR @EndDate IS NULL) 
	 ORDER BY RECORD_DATE DESC, pa_vt_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
