SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetCCDDataExportConfigurationForExecute]
(
	@Day As VARCHAR(10),
	@Date AS VARCHAR(10),
	@RunDate AS DATETIME
)
AS
BEGIN
	DECLARE @CurrentTime AS VARCHAR(10)
	SELECT @CurrentTime = RIGHT('0'+CAST(DATEPART(hour, @RunDate) as varchar(2)),2) + ':' + RIGHT('0'+CAST(DATEPART(minute, @RunDate)as varchar(2)),2)

	--Specific Time
	SELECT	DEX.DataExportSettingId, DEX.DoctorCompanyId, DEX.DoctorId, DEX.StartDate, DEX.EndDate,
			ISNULL(DC.dr_last_name, '') + ', ' + ISNULL(DC.dr_first_name, '') As DoctorName
	FROM	dbo.DataExportSettings DEX WITH (NOLOCK)
			INNER JOIN dbo.doctors DC WITH (NOLOCK) ON DC.dr_id = DEX.DoctorId
			INNER JOIN ehr.ApplicationTableConstants ET WITH (NOLOCK) ON ET.ApplicationTableConstantId = DEX.ExportType AND ET.Code = 'ONTME'
			INNER JOIN ehr.ApplicationTables ETT WITH (NOLOCK) ON ETT.ApplicationTableId = ET.ApplicationTableId AND ETT.Code = 'STTPE'
			INNER JOIN ehr.ApplicationTableConstants RT WITH (NOLOCK) ON RT.ApplicationTableConstantId = DEX.RunAtTimeId
			INNER JOIN ehr.ApplicationTables RTT WITH (NOLOCK) ON RTT.ApplicationTableId = RT.ApplicationTableId AND RTT.Code = 'RTIME'
	WHERE	CONVERT(DATETIME, CONVERT(CHAR(8), DEX.RunAt, 112) 
			 + ' ' + CONVERT(CHAR(8), RT.Description, 108))  <= CONVERT(DATETIME, @RunDate) AND 
			 (DEX.LastRunDate IS NULL OR 
			 CONVERT(DATETIME, CONVERT(CHAR(8), DEX.RunAt, 112) 
			 + ' ' + CONVERT(CHAR(8), RT.Description, 108)) > CONVERT(DATETIME, DEX.LastRunDate))
	Union All
	--Relative Time
	SELECT	DEX.DataExportSettingId, DEX.DoctorCompanyId, DEX.DoctorId,
			CASE WHEN DEX.StartDate IS NOT NULL THEN DEX.StartDate ELSE CASE WHEN CFT.Code = 'MNTLY' THEN DATEADD(day,-30, @RunDate) ELSE DATEADD(day,-7, @RunDate) END END AS StartDate,  -- Need to modify while adding more criterias
			CASE WHEN DEX.EndDate IS NOT NULL THEN DEX.EndDate ELSE DATEADD(day,-1, @RunDate) END AS EndDate, 
			ISNULL(DC.dr_last_name, '') + ', ' + ISNULL(DC.dr_first_name, '') As DoctorName
	FROM	dbo.DataExportSettings DEX WITH (NOLOCK)
			INNER JOIN dbo.doctors DC WITH (NOLOCK) ON DC.dr_id = DEX.DoctorId
			INNER JOIN ehr.ApplicationTableConstants ET WITH (NOLOCK) ON ET.ApplicationTableConstantId = DEX.ExportType AND ET.Code = 'RCRNG'
			INNER JOIN ehr.ApplicationTables ETT WITH (NOLOCK) ON ETT.ApplicationTableId = ET.ApplicationTableId AND ETT.Code = 'STTPE'
			INNER JOIN ehr.ApplicationTableConstants RT WITH (NOLOCK) ON RT.ApplicationTableConstantId = DEX.RunAtTimeId
			INNER JOIN ehr.ApplicationTables RTT WITH (NOLOCK) ON RTT.ApplicationTableId = RT.ApplicationTableId AND RTT.Code = 'RTIME'
			INNER JOIN ehr.ApplicationTableConstants CFT WITH (NOLOCK) ON CFT.ApplicationTableConstantId = DEX.CycleFrequencyTypeId
			INNER JOIN ehr.ApplicationTables CFTT WITH (NOLOCK) ON CFTT.ApplicationTableId = CFT.ApplicationTableId AND CFTT.Code = 'CLFRQ'
			INNER JOIN ehr.ApplicationTableConstants RDT WITH (NOLOCK) ON RDT.ApplicationTableConstantId = DEX.RunDayTypeId
	WHERE	(
				(RDT.Code = (CASE WHEN CFT.Code = 'WEKLY' THEN @Day ELSE RDT.Code END) AND
				RDT.Code = (CASE WHEN CFT.Code = 'MNTLY' THEN @Date ELSE RDT.Code END))
				OR
				(CFT.Code = 'MNTLY' AND RDT.Code = 'MNLTD' AND 
				 DAY(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0, @RunDate)+1,0))) = DAY(@RunDate))
			) AND
			 (DEX.LastRunDate IS NULL OR 
			 CONVERT(DATETIME, CONVERT(CHAR(8), @RunDate, 112) 
			 + ' ' + CONVERT(CHAR(8), RT.Description, 108)) > CONVERT(DATETIME, DEX.LastRunDate))
			 AND RIGHT('0'+CAST(DATEPART(hour, CONVERT(DATETIME, CONVERT(CHAR(8), @RunDate, 112) 
			 + ' ' + CONVERT(CHAR(8), RT.Description, 108))) as varchar(2)),2) + ':' + RIGHT('0'+CAST(DATEPART(minute,
			 CONVERT(DATETIME, CONVERT(CHAR(8), @RunDate, 112) 
			 + ' ' + CONVERT(CHAR(8), RT.Description, 108))) as varchar(2)),2) <= @CurrentTime	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
