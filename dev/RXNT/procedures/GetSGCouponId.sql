SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 11/14/2011
-- Description:	Maintains the script guide coupon id number
-- =============================================
CREATE PROCEDURE [dbo].[GetSGCouponId] 	
	@outputid int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @ID INT;	
	SELECT @outputid =  ID FROM scriptguide_couponids S
	SET @outputid = @outputid + 1
	UPDATE scriptguide_couponids SET id = @outputid	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
