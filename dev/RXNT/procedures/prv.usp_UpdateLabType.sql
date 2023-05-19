SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  Sep 29, 2016
-- Description:	 Update Lab Type
-- =============================================
CREATE PROCEDURE [prv].[usp_UpdateLabType]
(
	@LabId INT,
	@Type varchar(10)
)
AS
BEGIN
	Update LAB_MAIN set Type=@Type where lab_id=@labid
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
