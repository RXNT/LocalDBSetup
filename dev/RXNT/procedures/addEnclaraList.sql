SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addEnclaraList]
AS
	DECLARE @GROUPID INT
	DECLARE @APPNAME AS varchar(30)
	SET @GROUPID = 0
	SET @APPNAME = 'ExcellRx'
	
	create table #temp(dg_id int)
	create table #tempDrId(dr_id int)
	
	insert into #temp
		select dg_id from doc_groups DG with(nolock) 
		inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
		inner join hl7_cross_reference HC with(nolock) on DC.dc_id=HC.dc_id
		where application like @APPNAME group by dg_id

	insert into #tempDrId
		select Dr.dr_id from doctors DR with(nolock)
		inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
		inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
		inner join hl7_cross_reference HC with(nolock) on DC.dc_id=HC.dc_id
		where application like @APPNAME
		
	-- Get the number of rows in the looping table
	DECLARE @RowCount INT
	
	SET @RowCount = (SELECT COUNT(dg_id) FROM #temp) 

	-- Declare an iterator
	DECLARE @I INT
	-- Initialize the iterator
	SET @I = 1

	-- Loop through the rows of a table @myTable
	WHILE (@I <= @RowCount)
	BEGIN
			-- Declare variables to hold the data which we get after looping each record 
			DECLARE @idgid int 
	        
			-- Get the data from table and set to variables
			SELECT TOP 1 @idgid = dg_id FROM #temp
			-- Display the looped data
			PRINT 'ID = ' + CONVERT(VARCHAR(20), @idgid)
			
			insert into doc_site_fav_pharms(dr_id,pharm_id)
				select DR.dr_id,63040 from doctors DR with(nolock) 
					left outer join doc_site_fav_pharms PH with(nolock) on DR.dr_id = PH.dr_id and PH.pharm_id =63040
					where DR.dg_id = @idgid and DR.dg_id <> 27112 and PH.dr_id is null 

					 
			delete from patients_coverage_info where pci_id in (
				select PCI.pci_id from patients P 
				LEft outer join patients_coverage_info PCI on P.pa_id=PCI.pa_id
				where dg_id=@idgid and (PCI.rxhub_pbm_id is null or not(PCI.rxhub_pbm_id like 'HPENCLARA')))
				
			insert into patients_coverage_info(pa_id,ic_group_numb,card_holder_id,card_holder_first,
			card_holder_mi,card_holder_last,ic_plan_numb,
			ins_relate_code,formulary_id,alternative_id,pa_bin,rxhub_pbm_id,pbm_member_id,def_ins_id,mail_order_coverage,
			retail_pharmacy_coverage,formulary_type,add_date,copay_id,coverage_id,ic_plan_name,
			PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX)
			select 
				P.pa_id,'HPENCL','',P.pa_first,P.pa_middle,P.pa_last,'','01','FRM001','','610106',
				'HPENCLARA','610106',0,0,0,1,GETDATE(),'','','HP ENCLARA',P.pa_address1,P.pa_address2,
				P.pa_city,P.pa_state,P.pa_zip,P.pa_dob,P.pa_sex from patients P with(nolock)
				LEft outer join patients_coverage_info PCI with(nolock) on P.pa_id=PCI.pa_id
				where dg_id=@idgid and (PCI.rxhub_pbm_id is null or not(PCI.rxhub_pbm_id like 'HPENCLARA'))
				
			UPDATE patients set last_check_date=GETDATE()+300 where dg_id=@idgid and last_check_date < GETDATE()
			
			
			
			DELETE FROM #TEMP WHERE dg_id=@idgid
			-- Increment the iterator
			SET @I = @I  + 1
	END

	-- Loop through doctor ids for setting favorite list
	SET @I = 1
	SET @RowCount = (SELECT COUNT(dr_id) FROM #tempDrId) 
	
	WHILE (@I <= @RowCount)
	BEGIN
			-- Declare variables to hold the data which we get after looping each record 
			DECLARE @idrid int 
	        
			-- Get the data from table and set to variables
			SELECT TOP 1 @idrid = dr_id FROM #tempDrId
			-- Display the looped data
			PRINT 'ID = ' + CONVERT(VARCHAR(20), @idrid)
			
			-- INSERT FAVORITE DRUG LIST
			insert into doc_fav_drugs
			select @idrid,drug_id from rxntreportutils..[Enclara_fav_drugs] 
			where drug_id not in 
				(select B.drug_id from doc_fav_drugs A	inner join 
					rxntreportutils..[Enclara_fav_drugs] B on A.drug_id=B.drug_id
					where A.dr_id=@idrid
				)
			
			-- INSERT FAVORITE SCRIPT LIST		
			insert into doc_fav_scripts (dr_id,ddid,dosage,use_generic,numb_refills,comments)
			select @idrid,A.ddid,A.dosage,A.use_generic,A.numb_refills,A.comments
			from RxNTReportUtils.dbo.[Enclara_fav_scripts] A left outer join 
			(select ddid,dosage,comments from doc_fav_scripts where dr_id=@idrid) B 
			on A.ddid=B.ddid and A.dosage=B.dosage and A.comments = B.comments
			where B.ddid is null
			
			DELETE FROM #tempDrId WHERE dr_id=@idrid
			-- Increment the iterator
			SET @I = @I  + 1
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
