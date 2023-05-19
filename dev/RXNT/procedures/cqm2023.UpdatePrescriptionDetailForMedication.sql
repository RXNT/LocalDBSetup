SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	25-NOV-2022
-- Description:		Update Prescription Detail Based on CQMMedType
-- =============================================
CREATE    PROCEDURE [cqm2023].[UpdatePrescriptionDetailForMedication]
  @FillReqId			BIGINT,
  @HistoryEnabled		BIT,
  @PDID					BIGINT,
  @PresId				BIGINT
AS
BEGIN
	DECLARE @IsDispensed AS BIT=1
	IF @FillReqId = 0
	BEGIN
		SET @FillReqId = NULL
		SET @IsDispensed=0
	END
	UPDATE prescription_details SET history_enabled = @HistoryEnabled, FillReqId = @FillReqId, is_dispensed=@IsDispensed
	WHERE pd_id = @PDID AND pres_id = @PresId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
