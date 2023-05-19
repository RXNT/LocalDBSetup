SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <02-29-2016>
-- Description:	<Transaction information has to be saved>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InsertRxNTInterfaceLogs] 
	-- Add the parameters for the stored procedure here
	@RecIDentifier varchar(50),
	@ReceivedDatetime datetime,
	@PartnerName varchar(50),
	@IncomingIPAddress varchar(50),
	@msgText varchar(max),
	@RecordId int OUTPUT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert Into RxNT_Interface_Logs
	(RecIDentifier,ReceivedDatetime,PartnerName,IncomingIPAddress,CreatedDate,msgText) 
	Values(@RecIDentifier,@ReceivedDatetime,@PartnerName,@IncomingIPAddress,GETDATE(),@msgText)
	
	Set @RecordId=SCOPE_IDENTITY()
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
