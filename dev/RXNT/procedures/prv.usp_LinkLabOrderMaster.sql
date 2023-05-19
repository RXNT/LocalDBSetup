SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  Sep 28, 2016
-- Description:	 to link lab order master to lab main
-- =============================================
CREATE PROCEDURE [prv].[usp_LinkLabOrderMaster]
(
	@LabId INT,
	@LabOrderMasterId INT
)
AS
BEGIN
	update lab_main 
	set lab_order_master_id=@LabOrderMasterId 
	where lab_id=@LabId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
