SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	16- June-2016
Description			:	This procedure is used to get Fax Unassigned count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[GetFaxCount]	
	-- Add the parameters for the stored procedure here
	@DoctorCompanyId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Count as int
    -- Insert statements for procedure here
	
	SELECT @Count=COUNT(1)
	from [dbo].[RsynFaxFaxReceiveMessages] where PatientId = 0 OR PatientId IS NULL 
	
	
	Select @Count as FaxCount	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
