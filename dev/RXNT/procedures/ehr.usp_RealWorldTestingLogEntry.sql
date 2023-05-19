SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		jahabarYusuff M
-- Create date: 10-05-2022
-- Description: Save Real World testing Log
-- =============================================
CREATE PROCEDURE  [ehr].[usp_RealWorldTestingLogEntry]
(
    @DrId BIGINT,
	@EventMessage Varchar(200),
	@EventStatus Varchar(7),
	@EventDatetime DATETIME
)
AS
BEGIN
	INSERT INTO dbo.[real_world_testing_log] (dr_id,  event_name ,event_status, event_date ) 	VALUES ( @DrId, @EventMessage,@EventStatus,@EventDatetime ); 

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
