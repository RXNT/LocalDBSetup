SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyDocFavDrugsFromOneDoctorToAnother]
@FromDoctorId INT, @ToDoctorId INT

AS
INSERT INTO doc_fav_drugs(dr_id,drug_id)
SELECT  @ToDoctorId,dfg_from.drug_id FROM doc_fav_drugs dfg_from
LEFT OUTER JOIN  doc_fav_drugs dfg_to ON dfg_from.drug_id=dfg_to.drug_id AND dfg_to.dr_id=@ToDoctorId
WHERE dfg_from.dr_id= @FromDoctorId AND dfg_to.dfd_id IS NULL
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
