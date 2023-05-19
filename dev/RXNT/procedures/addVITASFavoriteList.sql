SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addVITASFavoriteList]
AS
	DECLARE @PHARMID INT
	DECLARE @COMPANYID INT
	SET @COMPANYID = 23109
	SET @PHARMID = 63040
	
	create table #temp(dr_id int)
	insert into #temp
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=@COMPANYID)
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
			insert into doc_site_fav_pharms
			select @idrid,pharm_id from pharmacies where pharm_id=@PHARMID and @idrid not in 
			(select dr_id from doc_site_fav_pharms where dr_id=@idrid and pharm_id=@PHARMID)
			
			-- INSERT FAVORITE DRUG LIST
			insert into doc_fav_drugs
			select distinct @idrid,medid from rxntreportutils..vitas_fav_drugs 
			where medid not in (select medid from doc_fav_drugs A with(nolock)	inner join 
			rxntreportutils..vitas_fav_drugs B on A.drug_id=B.medid	where A.dr_id=@idrid and B.dg_id in (select	dg_id from doc_groups where dc_id=@COMPANYID)) and medid not in (select medid from doc_fav_drugs with(nolock) where dr_id=@idrid)
			
			-- INSERT FAVORITE SCRIPT LIST	
			insert into doc_fav_scripts (dr_id,ddid,dosage,use_generic,numb_refills)
			select @idrid,A.ddid,Sig,1,0 from RxNTReportUtils.dbo.VitasScripts A left outer join 
			(select ddid,dosage from doc_fav_scripts where dr_id=@idrid) B on A.ddid=B.ddid and 
			A.Sig=B.dosage where B.ddid is null
			--IF NOT EXISTS(SELECT DR_ID FROM doc_token_info WHERE dr_id=@idrid)
			--BEGIN
			--	INSERT doc_token_info (dr_id,stage,comments,ups_tracking_id,ups_label_file,shipping_fee,shipping_address1,shipping_city,shipping_state,
			--	shipping_zip,shipping_to_name,ship_submit_date,shipment_identification,email,						idretries,maxidretries,token_serial_no)
			--	VALUES (@idrid,0,'ADDED VITAS RECORD<br/>','','',0,'','','','','','1901-01-01','','',0,0,'')
			--END
			IF NOT EXISTS(SELECT DR_ID FROM doc_admin WHERE dr_id=@idrid and dr_partner_participant=262144)
			BEGIN
				insert into doc_admin(dr_id,dr_partner_enabled,dr_partner_participant,dr_service_level,report_date,update_date,fail_lock,version)
				values(@idrid,1,262144,1,'1901-01-01',GETDATE(),0,'10.6')
			END
			ELSE
			BEGIN
				IF EXISTS(SELECT DR_ID FROM doc_admin WHERE dr_id=@idrid and dr_partner_participant=262144 AND dr_service_level > 2049)
				BEGIN
					UPDATE doc_admin SET dr_service_level=2049,update_date=GETDATE(),version='10.6' WHERE  dr_id=@idrid and dr_partner_participant=262144
				END
			END
			
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
	
	--UPDATE doc_token_info SET stage=99 WHERE dr_id IN (select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=@COMPANYID)) AND stage < 99
	
	update doctor_info set versionURL='v7',is_coupon_enabled=0,is_custom_tester=1 where dr_id in (select dr_id from		doctors where dg_id in(select dg_id from doc_groups where dc_id=@COMPANYID)) and 
	(is_coupon_enabled is null or is_coupon_enabled = 1 or versionURL <> 'v7' or is_custom_tester <> 3)
	
	--update doctors set rights = 11403263,epcs_enabled=1 where dr_id in (select dr_id from doctors 
	update doctors set rights = 11403263 where dr_id in (select dr_id from doctors 
	where dg_id in(select dg_id from doc_groups where dc_id=@COMPANYID)) and prescribing_authority > 2 and dr_id <> 72325
	
	insert into doctor_specialities_xref
	select dr_id,83 from doctors where dr_id not in (select dr_id from doctor_specialities_xref where speciality_id=83)
	and dg_id in (select dg_id from doc_groups where dc_id=@COMPANYID)
	
	insert into DOC_FAV_PAGES(fav_page_id,dr_id)
	select 0,dr_id from doctors where dg_id in (select dg_id from doc_groups where dc_id=@COMPANYID) 
	and dr_id not in(select dr_id from DOC_FAV_PAGES)
	
	--TEMPORARY FIX
	delete from patients_coverage_info where pa_id in
	(
		select pa_id from patients PAT with(nolock)
			inner join doc_groups DG on PAT.dg_id = DG.dg_id
		where dc_id=@COMPANYID
	)
	
	UPDATE patients set last_check_date=GETDATE()+300 
	where dg_id in
	(
		select dg_id from doc_groups where dc_id=@COMPANYID
	)
	and add_date > GETDATE()-5
	 and last_check_date < GETDATE() 
	 ---------------------

		update doctor_info set securityset=1 where dr_id in ( 
		select DSA.dr_id from doctors DR with(nolock) 
			inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id
			inner join doc_question_answer DSA with(nolock) on DR.dr_id=DSA.dr_id
			where DG.dc_id = @COMPANYID and DSA.doc_question_id = 1 and doc_answer = 'RxNT')
		
	update doctors set hipaa_agreement_acptd=0,dr_agreement_acptd=0 where dr_id in ( 
		select DSA.dr_id from doctors DR with(nolock) 
			inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id
			inner join doc_question_answer DSA with(nolock) on DR.dr_id=DSA.dr_id
			where DG.dc_id = @COMPANYID and DSA.doc_question_id = 1 and doc_answer = 'RxNT')
			
	delete from doc_question_answer where dr_id in (
			select DSA.dr_id from doctors DR with(nolock) 
			inner join doc_groups DG with(nolock) on DR.dg_id=DG.dg_id
			inner join doc_question_answer DSA with(nolock) on DR.dr_id=DSA.dr_id
			where DG.dc_id = @COMPANYID and DSA.doc_question_id = 1 and doc_answer = 'RxNT')

		insert into patients_fav_pharms(pa_id,pharm_id,pharm_use_date)
			select distinct PT.pa_id,PH.pharm_id,GETDATE() from RxNTReportUtils.dbo.vitas_pharm PH inner join patients PT with(nolock) on 
			PH.ProgramID=
				substring(SUBSTRING(PT.pa_ssn, charIndex('-',PT.pa_ssn) + 1, len(pa_ssn) - charIndex('-',PT.pa_ssn) - 1),0,charindex('-',SUBSTRING(PT.pa_ssn, charIndex('-',
			PT.pa_ssn) + 1, len(PT.pa_ssn) - charIndex('-',PT.pa_ssn) - 1)))
			left outer join patients_fav_pharms PH1 with(nolock) on PH.pharm_id=PH1.pharm_id and pt.pa_id=ph1.pa_id
			where dg_id in (select	dg_id from doc_groups where dc_id=@COMPANYID) and LEN(pa_ssn) > 4 and ph1.pa_id is null
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
