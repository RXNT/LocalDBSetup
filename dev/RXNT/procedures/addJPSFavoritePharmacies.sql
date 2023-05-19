SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addJPSFavoritePharmacies]
AS
	create table #temp(dr_id int)
	insert into #temp
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=17245)
	and dr_id not in(
	select dr_id from doc_site_fav_pharms where dr_id in(
	select dr_id from doctors where dg_id in(select dg_id from doc_groups where dc_id=17245))
	and pharm_id in (select pharm_id from pharmacies where (pharm_id=137603 OR pharm_company_name like '%JPS%')
	and pharm_enabled=1 and pharm_pending_addition=1))

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
			select @idrid,pharm_id from pharmacies where (pharm_id=137603 OR pharm_company_name like '%JPS%')
			and pharm_enabled=1 and pharm_pending_addition=1			
			DELETE FROM #TEMP WHERE dr_id=@idrid
			-- Increment the iterator
			SET @I = @I  + 1
	END
	update lab_main set message_date=getdate()-1 where dg_id=4

	update lab_main set is_read=1 where is_read=0 and dg_id in (select distinct dg_id from doctors where lab_enabled <> 1)
	and dg_id not in (select distinct dg_id from doctors where lab_enabled = 1)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
