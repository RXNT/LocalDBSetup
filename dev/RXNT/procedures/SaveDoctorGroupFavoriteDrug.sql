SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	06-APR-2018
-- Description:		Save Doctor Group Favorite Drug
-- =============================================
CREATE PROCEDURE [dbo].[SaveDoctorGroupFavoriteDrug]
  @DoctorGroupId			BIGINT,
  @DoctorId					BIGINT,
  @DrugId					BIGINT,
  @IsDelete					BIT=0,
  @FromDoctorId				BIGINT = 0
AS
BEGIN
	IF(ISNULL(@IsDelete,0)=0)
	BEGIN
		DECLARE @ImportRefId AS BIGINT = 0
		IF(@FromDoctorId > 0)
		BEGIN
			SELECT @ImportRefId = ISNULL(dfd_id,0) FROM doc_fav_drugs WHERE drug_id=@DrugId AND dr_id=@FromDoctorId
		END
		IF NOT EXISTS(SELECT TOP 1 1 FROM doc_group_fav_drugs WHERE dg_id=@DoctorGroupId AND drug_id=@DrugId)
		BEGIN
			INSERT INTO doc_group_fav_drugs (dg_id,added_by_dr_id,added_date,drug_id,import_ref_id,import_date)
			VALUES(@DoctorGroupId,@DoctorId,GETDATE(),@DrugId,@ImportRefId,GETDATE())
		END
	END
	ELSE
	BEGIN
		DELETE FROM doc_group_fav_drugs WHERE dg_id=@DoctorGroupId AND drug_id=@DrugId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
