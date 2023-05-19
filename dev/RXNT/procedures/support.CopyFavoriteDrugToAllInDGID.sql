SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyFavoriteDrugToAllInDGID]
@GROUPID INT, @FROMDRID INT
AS
	
	create table #tempDrId(dr_id int)
	

	insert into #tempDrId
		select Dr.dr_id from doctors DR with(nolock)
		inner join doc_groups DG with(nolock) on DR.dg_id = DG.dg_id
		inner join doc_companies DC with(nolock) on DG.dc_id=DC.dc_id
		where DR.dg_id = @GROUPID
		
	-- Get the number of rows in the looping table
	DECLARE @RowCount INT
	DECLARE @I INT

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
			
			EXEC [CopyDocFavDrugsAndScripts]  @FROMDRID ,@idrid
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
