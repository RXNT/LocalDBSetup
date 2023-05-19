SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal
-- Create date: 09-APRIL-2017
-- Description:	Search Promotions
-- Modified By:
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchBannerAd]
	@ProgrammeName		VARCHAR(80)		= NULL,
	@StartDate			DATE			= NULL,
	@EndDate			DATE			= NULL,
	@States				VARCHAR(256)	= NULL,
	@IncludeDeleted		BIT				= NULL
AS

BEGIN
	SET NOCOUNT ON;
	
	SELECT	SGP.ad_id,
			SGP.name,
			SGP.session_count,
			SGP.medid,
			SGP.med_name,
			SGP.dtStart,
			SGP.current_count,
			SGP.increments,
			SGP.dtEnd,
			SGP.state_exclusion,
			SGP.min_age,
			SGP.iscomplete,
			SGP.max_age,
			SGP.gender,
			SGP.Active,
			SGP.ctrl_fac,
			SGP.message,
			SGP.type,
			SGP.speciality_1,
			SGP.speciality_2,
			SGP.speciality_3,
			SGP.url
			
	FROM	rxnt_sg_promotions SGP
	
	
	WHERE	(SGP.name LIKE '%' + @ProgrammeName + '%'OR @ProgrammeName IS NULL) AND
			(SGP.state_exclusion LIKE'%' + @States + '%'OR @States IS NULL) AND
			SGP.dtStart >= CASE WHEN @StartDate IS NOT NULL THEN DATEADD(D, 0, DATEDIFF(D, 0, @StartDate)) ELSE SGP.dtStart END AND
			SGP.dtEnd <= CASE WHEN @EndDate IS NOT NULL THEN DATEADD(D, 0, DATEDIFF(D, 0, @EndDate))  ELSE SGP.dtEnd END  AND
			((@IncludeDeleted = 1) OR (@IncludeDeleted = 0 AND SGP.Active = 1))
	ORDER BY
			SGP.ad_id DESC
			
				
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
