SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	18-APR-2018
-- Description:		Save Doctor Group Favorite Script
-- =============================================
CREATE PROCEDURE [dbo].[SaveDoctorGroupFavoriteScript]
  @DoctorGroupId			BIGINT,
  @DoctorId					BIGINT = 0,
  @DrugId					BIGINT = 0,
  @ScriptId					BIGINT = 0,
  @Dosage					VARCHAR(255) = NULL,
  @DaysSupply				SMALLINT = 0,
  @UseGeneric				BIT = 0,
  @DurationUnit				VARCHAR(80) = NULL,
  @DurationAmount			VARCHAR(10) = NULL,
  @NoOfRefills				INT = 0,
  @Comments					VARCHAR(255) = NULL,
  @IsPRN					BIT = 0,
  @AsDirected				BIT = 0,
  @PRNDescription			VARCHAR(50) = 0,
  @Compound					BIT = 0,
  @IsDelete					BIT=0,
  @FromDoctorId				BIGINT = 0
AS
BEGIN
	IF(ISNULL(@IsDelete,0)=0)
	BEGIN
		DECLARE @ImportRefId AS BIGINT = 0
		IF(@FromDoctorId > 0)
		BEGIN
			SELECT TOP 1 @ImportRefId = ISNULL(script_id,0) FROM doc_fav_scripts WHERE ddid=@DrugId AND dr_id=@FromDoctorId
			AND dosage=@Dosage AND duration_unit=@DurationUnit AND duration_amount=@DurationAmount AND numb_refills=@NoOfRefills
			AND comments=@Comments AND prn_description=@PRNDescription AND compound=@Compound AND ISNULL(days_supply,0)=ISNULL(@DaysSupply,0)
		END
		IF NOT EXISTS(SELECT TOP 1 1 FROM doc_group_fav_scripts WHERE dg_id=@DoctorGroupId AND ddid=@DrugId
			AND dosage=@Dosage AND duration_unit=@DurationUnit AND duration_amount=@DurationAmount AND numb_refills=@NoOfRefills
			AND comments=@Comments AND prn_description=@PRNDescription AND compound=@Compound AND ISNULL(days_supply,0)=ISNULL(@DaysSupply,0)
			AND ISNULL(import_ref_id,0)=ISNULL(@ImportRefId,0))
		BEGIN
			INSERT INTO doc_group_fav_scripts (dg_id,dr_id, ddid, days_supply, dosage, use_generic, duration_unit, duration_amount,
                        numb_refills, comments, prn, as_directed, prn_description,compound,import_ref_id,import_date)
			VALUES(@DoctorGroupId,@DoctorId,@DrugId,@DaysSupply,@Dosage,@UseGeneric,@DurationUnit,@DurationAmount,@NoOfRefills,
						@Comments,@IsPRN,@AsDirected,@PRNDescription,@Compound,@ImportRefId,GETDATE())
		END
	END
	ELSE
	BEGIN
		DELETE FROM doc_group_fav_scripts WHERE dg_id=@DoctorGroupId AND script_id=@ScriptId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
