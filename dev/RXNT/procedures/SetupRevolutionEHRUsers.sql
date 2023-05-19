SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SetupRevolutionEHRUsers]
AS
	insert into doctor_specialities_xref select dr_id,54 from doctors DR inner join doc_groups DG on Dr.dg_id=DG.dg_id inner join doc_companies DC on Dg.dc_id=DC.dc_id where partner_id=12 and dr_enabled=1 and prescribing_authority > 2 and dr_id not in (select dr_id from doctor_specialities_xref where speciality_id=54)

update doctor_info set is_custom_tester=12,is_coupon_enabled=0, is_bannerads_enabled=1, IS_MUALERTS_ENABLED=0,settings=0,VersionURL='ehrv8' where 
dr_id in 
(select dr_id from doctors DR inner join doc_groups DG on Dr.dg_id=DG.dg_id inner join doc_companies DC on Dg.dc_id=DC.dc_id where 
	partner_id=12 AND DC.dc_id in(23726,21552,23363,19189,23771,25636,18482,22682,19657)
	and dr_enabled=1
)
--and (is_custom_tester & 4 <> 4)

update doctor_info set is_custom_tester=12,is_coupon_enabled=0,IS_MUALERTS_ENABLED=0,is_bannerads_enabled=1,settings=0,VersionURL='ehrv8' where 
dr_id in 
(select DR.dr_id from doctors DR WITH(NOLOCK)
	inner join doc_groups DG WITH(NOLOCK) on Dr.dg_id=DG.dg_id 
	inner join doc_companies DC WITH(NOLOCK) on Dg.dc_id=DC.dc_id 
	inner join doctor_info DI WITH(NOLOCK) on Dr.dr_id=DI.dr_id 
	where 
	partner_id=12 
	--AND DC.dc_id in(23726,21552,23363,19189,23771,25636,18482,22682,19657)
	and (VersionURL<>'ehrv8' OR DI.is_custom_tester != 12 
		Or DI.is_coupon_enabled !=0 
		Or DI.is_coupon_enabled is null
		Or DI.is_bannerads_enabled !=0  
		Or DI.is_coupon_enabled is null 
		Or DI.settings != 0
		Or DI.IS_MUALERTS_ENABLED != 0)
	and dr_enabled=1
)

--update doctor_info set is_custom_tester=0,is_coupon_enabled=0,IS_MUALERTS_ENABLED=0,settings=0,VersionURL='v7' where 
--dr_id in 
--(select dr_id from doctors DR inner join doc_groups DG on Dr.dg_id=DG.dg_id inner join doc_companies DC on Dg.dc_id=DC.dc_id where partner_id=12 and dr_enabled=1
--)
--and (is_custom_tester & 4 <> 4)

update doctors set beta_tester=1 where dr_id in (select dr_id from doctors DR inner join doc_groups DG on Dr.dg_id=DG.dg_id inner join doc_companies DC on Dg.dc_id=DC.dc_id where partner_id=12 and dr_enabled=1) and beta_tester=0

update doctors set password_expiry_date=GETDATE() + 365 where dr_id in 
(select dr_id from doctors DR inner join doc_groups DG on Dr.dg_id=DG.dg_id inner join doc_companies DC on Dg.dc_id=DC.dc_id where partner_id=12 and dr_enabled=1) and password_expiry_date < GETDATE() + 7

update doc_companies set emr_modules=2147483647 where dc_id in (select dc_id  from doc_companies where partner_id=12) and emr_modules < 2147483647

insert into doc_company_themes(dc_id,theme_id)
select dc_id,1 from doc_companies where dc_id in (select dc_id  from doc_companies where partner_id=12) and dc_id not in (select dc_id from doc_company_themes)

-- NEW MENU DASHBOARD CHANGE
insert into patient_menu
		(master_patient_menu_id,dc_id,is_show,created_by,created_date, sort_order,active)
	select 21,DC.dc_id,1,1,getdate(),9,1 from doc_companies DC with(nolock) 
		left outer join patient_menu PMU with(nolock) on DC.dc_id = PMU.dc_id 
			AND PMU.master_patient_menu_id = 21
		where partner_id=12 AND PMU.dc_id is null
		
	insert into patient_menu
		(master_patient_menu_id,dc_id,is_show,created_by,created_date, sort_order,active)
	select 24,DC.dc_id,1,1,getdate(),8,1 from doc_companies DC with(nolock) 
		left outer join patient_menu PMU with(nolock) on DC.dc_id = PMU.dc_id 
			AND PMU.master_patient_menu_id = 24
		where partner_id=12 AND PMU.dc_id is null
		
	insert into patient_menu
		(master_patient_menu_id,dc_id,is_show,created_by,created_date, sort_order,active)
	select 26,DC.dc_id,1,1,getdate(),7,1 from doc_companies DC with(nolock) 
		left outer join patient_menu PMU with(nolock) on DC.dc_id = PMU.dc_id 
			AND PMU.master_patient_menu_id = 26
		where partner_id=12 AND PMU.dc_id is null
		
	insert into patient_menu
		(master_patient_menu_id,dc_id,is_show,created_by,created_date, sort_order,active)
	select 27,DC.dc_id,1,1,getdate(),3,1 from doc_companies DC with(nolock) 
		left outer join patient_menu PMU with(nolock) on DC.dc_id = PMU.dc_id 
			AND PMU.master_patient_menu_id = 27
		where partner_id=12 AND PMU.dc_id is null
-----FINISHED MENU SETTINGS --

create table #temp(dr_id int)
	insert into #temp
	select dr_id from doctors where dg_id in(
		select dg_id from doc_groups DG with(nolock) 
		inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id where partner_id=12
	)
	--and dr_enabled=1

	-- Get the number of rows in the looping table
	DECLARE @RowCount INT
	
	SET @RowCount = (SELECT COUNT(dr_id) FROM #temp) 

	-- Declare an iterator
	DECLARE @I INT
	-- Initialize the iterator
	SET @I = 1

	-- Loop through the rows of a table @myTable
	WHILE (@I <= @RowCount)
	BEGIN
			-- Declare variables to hold the data which we get after looping each record 
			DECLARE @idrid int 
	        
			-- Get the data from table and set to variables
			SELECT TOP 1 @idrid = dr_id FROM #temp
			-- Display the looped data
			PRINT 'ID = ' + CONVERT(VARCHAR(20), @idrid)
			insert into doc_message_reads(dr_id,DrMsgID,ReadDate)
			select @idrid,DrMsgID,GETDATE() from doc_messages with(nolock) where DrMsgId not in (
				select DrMsgId from doc_message_reads DMR with(nolock) 
					inner join doctors DR with(nolock) on DMR.dr_id = DR.dr_id
					where Dr.dr_id=@idrid
				)  
			DELETE FROM #TEMP WHERE dr_id=@idrid
			-- Increment the iterator
			SET @I = @I  + 1
	END
	DROP TABLE #temp


	update LI set PasswordExpiryDate = GETDATE() + 365
	from [dbo].[RsynRxNTMasterLogins] LI with(nolock)
	inner join  [dbo].[RsynRxNTMasterLoginExternalAppMaps] LE with(nolock) 
		on LI.LoginId = LE.LoginId
	where LE.ExternalCompanyId in
	(
		select dc_id from doc_companies with(nolock) where partner_id=12
	)
	and LI.PasswordExpiryDate < GETDATE() + 7
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
