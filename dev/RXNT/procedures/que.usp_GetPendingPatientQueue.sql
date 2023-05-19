SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vidya
Create date			:	01-Sep-2016
Description			:	This procedure is used to get pending patient queue list
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [que].[usp_GetPendingPatientQueue]	
	@QueueStatus VARCHAR(5)
AS
BEGIN	
	--Update queue status Not Required when the company doesn't have access to PMV2 and SchedulerV2
	UPDATE	PQ
	SET		PQ.QueueStatus = 'QUENR',
			PQ.ModifiedDate = GETDATE()
	From	que.PatientQueue PQ WITH (NOLOCK)
	Where	PQ.QueueStatus = 'PENDG'
			And not exists (Select ExternalCompanyId 
			From [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH (NOLOCK) 
			inner join	[dbo].[RsynRxNTMasterCompaniesTable]				CMP	with(nolock)	on	CMP.CompanyId = CEAM.CompanyId
			inner join	[dbo].[RsynMasterCompanyModuleAccess]		CMA	with(nolock)	on	CMA.CompanyId	=	CMP.CompanyId
			inner join	[dbo].[RsynMasterApplications]			APP	with(nolock)	on	APP.ApplicationId	=	CMA.ApplicationId
			where		1=1
			and			APP.Code in ('PMV2B', 'SCHV2')
			AND CEAM.ExternalCompanyId = PQ.dc_id)
			
	DECLARE @Temp table(  
		PatientQueueId [bigint] NOT NULL,
		pa_id int not null,
		dc_id int not null,
		ActionType varchar(5) not null,
		CreatedBy int null); 
    
	INSERT INTO @Temp 
	Select	top 100 PQ.PatientQueueId, PQ.pa_id, PQ.dc_id, PQ.ActionType, PQ.CreatedBy 
	From	que.PatientQueue PQ WITH (NOLOCK)
			INNER JOIN [dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH (NOLOCK) on CEAM.ExternalCompanyId = PQ.dc_id
	Where	PQ.QueueStatus = @QueueStatus
	Order by 1 asc
	
	Update	PQ
	Set		PQ.QueueStatus = 'QUECR',
			PQ.ModifiedDate = GETDATE()
	From	que.PatientQueue PQ WITH (NOLOCK)
			INNER JOIN @Temp TT ON TT.PatientQueueId = PQ.PatientQueueId
	Where	PQ.QueueStatus = 'PENDG'
				
	Select * From @Temp
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
