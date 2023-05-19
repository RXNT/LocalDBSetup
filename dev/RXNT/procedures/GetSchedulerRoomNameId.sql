SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[GetSchedulerRoomNameId] 
	(
		@DoctorGroupId AS BIGINT,
		@RoomName AS VARCHAR(50),
		@RoomId AS BIGINT OUTPUT
	)
AS
BEGIN 
	SELECT TOP 1 @RoomId=room_id 
	FROM scheduler_rooms WITH(NOLOCK)
	WHERE dg_id=@DoctorGroupId AND room_name=@RoomName AND is_active=1
	
	IF ISNULL(@RoomId,0)=0
	BEGIN
		INSERT INTO scheduler_rooms (room_name,dg_id,is_active)
		VALUES(@RoomName,@DoctorGroupId,1)
		SET @RoomId=SCOPE_IDENTITY();
	END
	RETURN @RoomId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
