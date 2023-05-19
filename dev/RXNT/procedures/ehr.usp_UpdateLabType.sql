SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Ramakrishna
-- Create date:  Sep 23, 2016
-- Description:	 Update Lab Type
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdateLabType]
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
