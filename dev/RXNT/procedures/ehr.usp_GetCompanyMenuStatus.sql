SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-Sep-2016
-- Description:	To Get Company Menu Status
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetCompanyMenuStatus]
	@DoctorCompanyId BIGINT
	
AS
BEGIN
	If NOT EXISTS ( select 1 from 
		[dbo].[RsynReportUtilsDocCompaniesAppInfo] where ehr = 1 and dc_id = @DoctorCompanyId)
		BEGIN
				select 'ENCTR' as PageCode, 0 AS 'Enable'
			UNION
				select 'VITCH' as PageCode, 0 AS 'Enable'
			UNION
				select 'PRFIL' as PageCode, 0 AS 'Enable'
			UNION
				select 'IMMUN' as PageCode, 0 AS 'Enable'
			UNION
				select 'LABSS' as PageCode, 0 AS 'Enable'
			UNION
				select 'PTDOC' as PageCode, 0 AS 'Enable'
			UNION
				select 'PRCDR' as PageCode, 0 AS 'Enable'
			UNION
				select 'REFER' as PageCode, 0 AS 'Enable'
			UNION
				select 'FMHIS' as PageCode, 0 AS 'Enable'
			UNION
				select 'NOTES' as PageCode, 1 AS 'Enable'
			UNION
				select 'ALERG' as PageCode, 1 AS 'Enable'
			UNION
				select 'PRBLM' as PageCode, 1 AS 'Enable'
			UNION
				select 'MEDIC' as PageCode, 1 AS 'Enable'
			UNION
				select 'APNMT' as PageCode, 0 AS 'Enable'
		END
	ELSE
		BEGIN
				select 'ENCTR' as PageCode, 1 AS 'Enable'
			UNION
				select 'VITCH' as PageCode, 1 AS 'Enable'
			UNION
				select 'PRFIL' as PageCode, 1 AS 'Enable'
			UNION
				select 'IMMUN' as PageCode, 1 AS 'Enable'
			UNION
				select 'LABSS' as PageCode, 1 AS 'Enable'
			UNION
				select 'PTDOC' as PageCode, 1 AS 'Enable'
			UNION
				select 'PRCDR' as PageCode, 1 AS 'Enable'
			UNION
				select 'REFER' as PageCode, 1 AS 'Enable'
			UNION
				select 'FMHIS' as PageCode, 1 AS 'Enable'
			UNION
				select 'NOTES' as PageCode, 1 AS 'Enable'
			UNION
				select 'ALERG' as PageCode, 1 AS 'Enable'
			UNION
				select 'PRBLM' as PageCode, 1 AS 'Enable'
			UNION
				select 'MEDIC' as PageCode, 1 AS 'Enable'
			UNION
				select 'APNMT' as PageCode, 0 AS 'Enable'
		END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
