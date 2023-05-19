SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Sandeep Kesarkar
-- Create date: 01/12/2014
-- Description:	Procedure to save data in table [MUMeasureCounts]
-- =============================================
CREATE PROCEDURE [dbo].[StageII_Save_MUMeasureCountsFromExtnApi]
	@MUMeasuresId int, @MeasureCode varchar(3), @dc_id int, @dr_id int, 
	@pa_id int, @enc_id int, @enc_date datetime, @DateAdded datetime,
	@IsNumerator bit, @IsDenominator bit, @RecordCreateUserId int, @RecordCreateDateTime datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;
	DECLARE @dg_id AS INT;
	SELECT @dg_id = dr.dg_id from doctors dr WITH(NOLOCK) where dr.dr_id = @dr_id

	INSERT INTO [dbo].[MUMeasureCounts]
				([MUMeasuresId], [MeasureCode], [dc_id], [dg_id], [dr_id], 
				[pa_id], [enc_id], [enc_date], [DateAdded],
				[IsNumerator], [IsDenominator], [RecordCreateUserId], [RecordCreateDateTime])
		VALUES	(@MUMeasuresId, @MeasureCode, @dc_id, @dg_id, @dr_id,
				@pa_id, @enc_id, @enc_date, @DateAdded,
				@IsNumerator, @IsDenominator, @RecordCreateUserId, @RecordCreateDateTime);
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
