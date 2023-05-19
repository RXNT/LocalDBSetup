SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_InsertRxNTInterfaceLogsDetail] 
	-- Add the parameters for the stored procedure here
	@RecIDentifier varchar(50),
	@status BIGINT,		
	@response varchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert Into RxNT_Interface_Logs_Detail
	(  [RecIDentifier]				
           ,[response]
           ,[status]
           ,CreatedDate
           )
	Values(@RecIDentifier,@response,@status, GETDATE())

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
