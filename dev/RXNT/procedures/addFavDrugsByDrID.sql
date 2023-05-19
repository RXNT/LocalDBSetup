SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addFavDrugsByDrID]
  @FromDrID INTEGER,
  @ToDrID INTEGER
AS

	DECLARE @drugInfo CURSOR
	DECLARE @DRID INT
	DECLARE @DrugID INT
	
	Select 
		dr_id, drug_id FROM doc_fav_drugs WHERE dr_id = @FromDrID	
	OPEN @drugInfo
	FETCH NEXT
		FROM @drugInfo INTO @DRID, @DrugID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	IF (@ToDrID != @DRID)
	BEGIN
		INSERT INTO doc_fav_drugs (dr_id, drug_id) 
		SELECT @ToDrID, drug_id FROM doc_fav_drugs WHERE dr_id = @FromDrID    
	END
	FETCH NEXT
	FROM @drugInfo INTO @DRID, @DrugID
	END
	CLOSE @drugInfo
	DEALLOCATE @drugInfo
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
