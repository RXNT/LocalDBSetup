SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[adddoctorAppInfo]
AS
insert into doctor_app_info
	select DR.dr_id,APP1.PM,APP1.EHR,APP1.ERX,APP1.EPCS,APP1.SCHEDULER from doctors DR with(nolock) 
		inner join (
			select F1.dg_id, 
				case when (F2.billingcount IS null OR F2.billingcount < 1) THEN  0 ELSE 1 END PM,
				CASE WHEN F1.ENCCOUNT > 0 THEN 1 ELSE 0 END EHR,
				CASE WHEN F1.SCHCOUNT > 0 THEN 1 ELSE 0 END SCHEDULER,
				CASE WHEN F1.eRxCount > 0 THEN 1 ELSE 0 END ERX,
				CASE WHEN DGS.ISEPCS > 0 THEN 1 ELSE 0 END EPCS
				 from 
					(
						SELECT DR.DG_ID,MAX(SALES_PERSON_ID)SPID ,MAX(CASE WHEN DR_STATE IS NULL THEN '' ELSE DR_STATE END)DG_STATE,
						MAX(DGS.DG_NAME)GROUP_NAME, COUNT(DR.DR_ID) TOTALDOCS,
						MAX(CASE WHEN EPCS_ENABLED IS NULL THEN 0 ELSE EPCS_ENABLED END) ISEPCS
						FROM DOCTORS DR WITH(NOLOCK) 
						INNER JOIN doc_groups DGS WITH(NOLOCK)ON DR.dg_id=DGS.dg_id
						WHERE prescribing_authority=4  and dr_enabled = 1 and sales_person_id IN (1,30,31)
						GROUP BY  DR.DG_ID
					)dgs 
					INNER JOIN sales_person_info SI WITH(NOLOCK) ON DGS.SPID = SI.sale_person_id
					LEFT OUTER JOIN
					(select  
						sum(case when s.dr_id is null then 0 else 1 END) SCHCOUNT, 
						sum(case when r.dr_id is null then 0 else 1 END) ENCCOUNT, 
						SUM(CASE WHEN eRx.dr_id is null then 0 else 1 end) eRxCount,
						d.dg_id, 
						max(sales_person_id) sales, 
						min(activated_date)FirstActivation
						from doctors d with(nolock) 
						left outer join 
						(
							select dr_id from scheduler_main with(nolock) where event_start_date  > getdate()-90
							group by dr_id
						) s on d.dr_id = s.dr_id
						left outer join 
						(
							select dr_id from enchanced_encounter with(nolock) where enc_date  > getdate()-90
							group by dr_id
						) r on d.dr_id = r.dr_id
						LEFT OUTER JOIN
						(
							SELECT DR_ID FROM prescriptions WITH(NOLOCK) WHERE pres_approved_date > GETDATE()-90
							group by dr_id
						) eRx on d.dr_id=eRx.dr_id
						where prescribing_authority=4  and dr_enabled = 1 and sales_person_id IN (1,30,31)
						group by d.dg_id
					)F1 ON dgs.DG_ID=f1.DG_ID 
					left outer join
					(
							select COUNT(*) billingcount,dg.dg_id from doc_groups DG with(nolock) inner join
							RxNTBilling..encounters be with(nolock) on dg.dc_id = be.dc_id 
							where be.entry_date> getdate()-90  group by dg.dg_id
					)F2 on F1.dg_id=F2.dg_id
	) APP1 on DR.dg_id=APP1.dg_id
	left outer join doctor_app_info DAI with(nolock) on DR.dr_id=DAI.dr_id
	where DR.prescribing_authority > 2 and 
	DAI.dr_id is null

	update doctor_app_info 
		set 
		--PM = APP1.PM,
		EHR = APP1.EHR,
		SCHEDULER = APP1.SCHEDULER,
		ERX = APP1.ERX,
		EPCS = APP1.EPCS
		from doctors DR with(nolock) 
		inner join (
			select F1.dg_id, 
					case when (F2.billingcount IS null OR F2.billingcount < 1) THEN  0 ELSE 1 END PM,
					CASE WHEN F1.ENCCOUNT > 0 THEN 1 ELSE 0 END EHR,
					CASE WHEN F1.SCHCOUNT > 0 THEN 1 ELSE 0 END SCHEDULER,
					CASE WHEN F1.eRxCount > 0 THEN 1 ELSE 0 END ERX,
					CASE WHEN DGS.ISEPCS > 0 THEN 1 ELSE 0 END EPCS
					 from 
						(
							SELECT DR.DG_ID,MAX(SALES_PERSON_ID)SPID ,MAX(CASE WHEN DR_STATE IS NULL THEN '' ELSE DR_STATE END)DG_STATE,
							MAX(DGS.DG_NAME)GROUP_NAME, COUNT(DR.DR_ID) TOTALDOCS,
							MAX(CASE WHEN EPCS_ENABLED IS NULL THEN 0 ELSE EPCS_ENABLED END) ISEPCS
							FROM DOCTORS DR WITH(NOLOCK) 
							INNER JOIN doc_groups DGS WITH(NOLOCK)ON DR.dg_id=DGS.dg_id
							WHERE prescribing_authority=4  and dr_enabled = 1 and sales_person_id IN (1,30,31)
							GROUP BY  DR.DG_ID
						)dgs 
						INNER JOIN sales_person_info SI WITH(NOLOCK) ON DGS.SPID = SI.sale_person_id
						LEFT OUTER JOIN
						(select  
							sum(case when s.dr_id is null then 0 else 1 END) SCHCOUNT, 
							sum(case when r.dr_id is null then 0 else 1 END) ENCCOUNT, 
							SUM(CASE WHEN eRx.dr_id is null then 0 else 1 end) eRxCount,
							d.dg_id, 
							max(sales_person_id) sales, 
							min(activated_date)FirstActivation
							from doctors d with(nolock) 
							left outer join 
							(
								select dr_id from scheduler_main with(nolock) where event_start_date  > getdate()-90
								group by dr_id
							) s on d.dr_id = s.dr_id
							left outer join 
							(
								select dr_id from enchanced_encounter with(nolock) where enc_date  > getdate()-90
								group by dr_id
							) r on d.dr_id = r.dr_id
							LEFT OUTER JOIN
							(
								SELECT DR_ID FROM prescriptions WITH(NOLOCK) WHERE pres_approved_date > GETDATE()-90
								group by dr_id
							) eRx on d.dr_id=eRx.dr_id
							where prescribing_authority=4  and dr_enabled = 1 and sales_person_id IN (1,30,31)
							group by d.dg_id
						)F1 ON dgs.DG_ID=f1.DG_ID 
						left outer join
						(
								select COUNT(*) billingcount,dg.dg_id from doc_groups DG with(nolock) inner join
								RxNTBilling..encounters be with(nolock) on dg.dc_id = be.dc_id 
								where be.entry_date> getdate()-90  group by dg.dg_id
						)F2 on F1.dg_id=F2.dg_id

		) APP1 on DR.dg_id=APP1.dg_id
		inner join doctor_app_info DAI with(nolock) on DR.dr_id=DAI.dr_id
	where DR.prescribing_authority > 2 and 
	(APP1.EHR <> DAI.EHR or APP1.PM <> DAI.PM or APP1.ERX <> DAI.ERX or APP1.SCHEDULER <> DAI.SCHEDULER or APP1.EPCS <> DAI.EPCS)			


	update RxNT.dbo.doctor_app_info 
		set 
		PM = APP1.PM		
		from RxNT.dbo.doctors DR with(nolock) 
		inner join (
		--PMV2 clients
			select		rdr.dr_id,1 PM
			from			[dbo].[RsynMasterCompanies]				cmp		with(nolock)
			inner join		[dbo].[RsynMasterCompanyTypes]				ctp		with(nolock)	on	ctp.CompanyTypeId	=	cmp.CompanyTypeId
			inner join		[dbo].[RsynMasterCompanyModuleAccess]		cma		with(nolock)	on	cma.CompanyId		=	cmp.CompanyId
			inner join		[dbo].[RsynMasterApplications]				app		with(nolock)	on	app.ApplicationId	=	cma.ApplicationId
			inner join		[dbo].[RsynMasterCompanyExternalAppMaps]	cme		with(nolock)	on	cme.CompanyId		=	cmp.CompanyId
			inner join	RxNT.dbo.doc_groups						rdg		with(nolock)	on	rdg.dc_id			=	cme.ExternalCompanyId
			inner join		RxNT.dbo.doctors						rdr		with(nolock)	on	rdr.dg_id			=	rdg.dg_id		
			where		1=1
			and			ctp.Name			=	'Client Company'
			and			app.Name			=	'PMV2'
		) 
		APP1 on DR.dr_id=APP1.dr_id
		inner join RxNT.dbo.doctor_app_info DAI with(nolock) on DR.dr_id=DAI.dr_id
		where DR.prescribing_authority > 2 and 
		APP1.PM <> DAI.PM
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
