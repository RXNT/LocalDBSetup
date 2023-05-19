SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addHOVFavoritePharmacies]
AS
	DECLARE @PHARMID INT
	DECLARE @COMPANYID INT
	SET @COMPANYID = 21878
	SET @PHARMID = 34309
	
	create table #temp(dr_id int)
	insert into #temp
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=21878)
	and dr_id not in(
	select dr_id from doc_site_fav_pharms where dr_id in(
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=21878))
	and pharm_id = 34309) and dr_enabled=1

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
			-- PRINT 'ID = ' + CONVERT(VARCHAR(20), @idrid)
			insert into doc_site_fav_pharms
			select @idrid,pharm_id from pharmacies where pharm_id=34309		
			DELETE FROM #TEMP WHERE dr_id=@idrid
			-- Increment the iterator
			SET @I = @I  + 1
	END
	TRUNCATE TABLE #temp
	
	insert into #temp
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=@COMPANYID)
	--and dr_enabled=1

	-- Get the number of rows in the looping table
	
	SET @RowCount = (SELECT COUNT(dr_id) FROM #temp) 

	-- Initialize the iterator
	SET @I = 1

	-- Loop through the rows of a table @myTable
	WHILE (@I <= @RowCount)
	BEGIN	        
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
	
	update doctor_info set is_coupon_enabled=0 where dr_id in (select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=21878)) and (is_coupon_enabled is null or is_coupon_enabled = 1)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
