SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Thomas K
-- Create date	: 2017/19/Jan
-- Description	: Import Vitas Master Drug List
-- =============================================
CREATE PROCEDURE [dbo].[ImportVitasMasterDrugList]
	@dg_id int
AS
BEGIN
	DECLARE @GCN AS VARCHAR(10)
	DECLARE @DRUGNAME AS VARCHAR(255)
	DECLARE @MEDID AS INT
	If exists(select top 1 * from RxNTReportUtils..vitas_formulary_master_list_temp)
	Begin
		PRINT 'STARTED'
		create table #temp(GCN varchar(10))
		insert into #temp
		SELECT gcn_c from RxNTReportUtils..vitas_formulary_master_list_temp
		DECLARE @RowCount INT
	
		SET @RowCount = (SELECT COUNT(GCN) FROM #temp) 

		-- Declare an iterator
		DECLARE @I INT
		-- Initialize the iterator
		SET @I = 1

		-- Loop through the rows of a table @myTable
		WHILE (@I <= @RowCount)
		BEGIN
			SET @GCN = ''
			SET @DRUGNAME = ''
			
			
			SELECT TOP 1 @GCN = GCN FROM #temp
			-- Display the looped data
			PRINT 'ID = ' + CONVERT(VARCHAR(20), @GCN)
			SELECT @DRUGNAME=medication from RxNTReportUtils..vitas_formulary_master_list_temp 
			where gcn_c = @GCN
			
			-- If GCN does not exists ADD the new drug as freetext
			If not exists 
				(select * from RMIID1 RM with(nolock) 
					inner join rnmmidndc RMN with(nolock) on RM.MEDID = RMN.MEDID
					where GCN_STRING =@GCN)
			BEGIN
				If(LEN(@DRUGNAME)) > 0
				BEGIN
					EXEC addDocGroupFreeTextMeds @drug_name=@DRUGNAME,
					@drug_level=3,@dg_id = @DG_id,@added_by_dr_id = 1,
					@drug_category = 1,@GCN = @GCN -- check this please with rasheed
				END
			END 
			-- Loop Here
			create table #tempMed(medid int)
			insert into #tempMed
			SELECT DISTINCT MEDID from RMIID1 WITH(NOLOCK) WHERE GCN_STRING = @GCN
			DECLARE @RowCountMed INT
	
			SET @RowCountMed = (SELECT COUNT(medid) FROM #tempMed) 

			-- Declare an iterator
			DECLARE @IMed INT
			-- Initialize the iterator
			SET @IMed = 1

			-- Loop through the rows of a table @myTable
			WHILE (@IMed <= @RowCountMed)
			BEGIN
				SET @MEDID = 0
				SELECT TOP 1 @MEDID = medid FROM #tempMed
				--Now drug is there in the system now check doc_group_fav_drugs for this drug. 
				--If it does not exist add it to the group favorite
				If not exists 
				(select * from doc_group_fav_drugs DG with(nolock)
					inner join RMIID1 RM with(nolock) on DG.drug_id = RM.MEDID
					where dg_id = @DG_id and RM.MEDID = @MEDID
				)
				BEGIN
					PRINT 'ADDING ' + CAST(@MEDID AS VARCHAR(20))
					INSERT INTO doc_group_fav_drugs(dg_id,added_by_dr_id,added_date,drug_id)
					SELECT TOP 1 @DG_id,1,GETDATE(),medid 
					from RMIID1 with(nolock) 
						where medid=@MEDID
				END
				DELETE FROM #tempMed WHERE medid=@MEDID
				SET @IMed = @IMed  + 1
			END
			DROP TABLE #tempMed
			DELETE FROM #TEMP WHERE GCN=@GCN
			-- Increment the iterator
			SET @I = @I  + 1
		END
	End
	Else
	Begin
		PRINT 'Master Table does not exist'
	End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
