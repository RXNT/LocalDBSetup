SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE addFavDrugs
  @dr_id INTEGER,
  @drug_id INTEGER
AS
  IF NOT EXISTS (SELECT dr_id, drug_id FROM doc_fav_drugs WHERE dr_id = @dr_id AND drug_id = @drug_id)
  BEGIN
    INSERT INTO doc_fav_drugs (dr_id, drug_id) VALUES(@dr_id, @drug_id)
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
