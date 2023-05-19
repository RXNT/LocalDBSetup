SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [que].[usp_patientsQueueInsertionManualFix]
@doctorCompanyId	BIGINT ,
@action				VARCHAR(3)
AS 
BEGIN

	SET NOCOUNT ON;
	
	--DECLARE		@action		VARCHAR(5)
	DECLARE		@status		VARCHAR(5)

	--SET			@action		=	'UP'
	SET			@status		=	'PENDG'

	BEGIN
		IF @action = 'INS'
		 BEGIN
			Insert	into	 que.PatientQueue
								(pa_id, dc_id, ActionType, OwnerType, QueueStatus, CreatedDate, CreatedBy)
									
			SELECT			p.pa_id,dg.dc_id,@action,isnull(p.OwnerType, ''), @status,GETDATE(),p.add_by_user
			from			dbo.patients			p				with(nolock)
			inner join		dbo.doc_groups			dg				with(nolock)		on			dg.dg_id				=	p.dg_id
			inner join		dbo.doc_companies		dc				with(nolock)		on			dc.dc_id				=	dg.dc_id
			where			1 = 1
			and				NOT EXISTS
										(
											select		p1.pa_id
											from		dbo.patients		p1							with(nolock)
											inner join	dbo.doc_groups		dg							with(nolock)		on			dg.dg_id				=	p1.dg_id
											inner join	dbo.doc_companies	dc							with(nolock)		on			dc.dc_id				=	dg.dc_id
											inner join	[dbo].[RsynMasterCompanyExternalAppMaps]	a1	with(nolock)	on			a1.ExternalCompanyId	=	dc.dc_id
											inner join	[dbo].[RsynRxNTMasterCompaniesTable]				b	with(nolock)	on			b.CompanyId				=	a1.CompanyId
											inner join	[dbo].[RsynMasterPatientExternalAppMaps]	c	with(nolock)	on			c.ExternalPatientId		=	p1.pa_id		
											and			c.CompanyId	=	b.CompanyId
											where		1 = 1
											--and			c.ExternalPatientId is null
											and			dc.dc_id = @doctorCompanyId
											and			p1.pa_id =	p.pa_id 
										)
			and				dc.dc_id	=		@doctorCompanyId
			order by		p.pa_id		asc
		   END
		  
		 IF @action = 'UPD'
				 BEGIN
					Insert	into	 que.PatientQueue
										(pa_id, dc_id, ActionType, OwnerType, QueueStatus, CreatedDate, CreatedBy)
											
					SELECT			p.pa_id,dg.dc_id,@action,isnull(p.OwnerType, ''), @status,GETDATE(),p.add_by_user
					from			dbo.patients			p				with(nolock)
					inner join		dbo.doc_groups			dg				with(nolock)		on			dg.dg_id				=	p.dg_id
					inner join		dbo.doc_companies		dc				with(nolock)		on			dc.dc_id				=	dg.dc_id
					where			1 = 1
					and				 EXISTS
												(
													select		p1.pa_id
													from		dbo.patients		p1							with(nolock)
													inner join	dbo.doc_groups		dg							with(nolock)		on			dg.dg_id				=	p1.dg_id
													inner join	dbo.doc_companies	dc							with(nolock)		on			dc.dc_id				=	dg.dc_id
													inner join	[dbo].[RsynMasterCompanyExternalAppMaps]	a1	with(nolock)	on			a1.ExternalCompanyId	=	dc.dc_id
													inner join	[dbo].[RsynRxNTMasterCompaniesTable]				b	with(nolock)	on			b.CompanyId				=	a1.CompanyId
													inner join	[dbo].[RsynMasterPatientExternalAppMaps]	c	with(nolock)	on			c.ExternalPatientId		=	p1.pa_id		
													and			c.CompanyId	=	b.CompanyId
													where		1 = 1
													--and			c.ExternalPatientId is null
													and			dc.dc_id = @doctorCompanyId
													and			p1.pa_id =	p.pa_id 
												)
					and				dc.dc_id	=		@doctorCompanyId
					order by		p.pa_id		asc
				END
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
