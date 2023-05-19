SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 12-OCT-2017
-- Description:	To get RxFill Count
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [prv].[GetFillRxCount]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0
AS
BEGIN
	SET NOCOUNT ON;
	Declare @Count as int=0
	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT  @Count=COUNT(1) FROM [erx].[RxFillRequests] fillReq WITH(NOLOCK)
					INNER JOIN prescriptions p WITH(NOLOCK) ON fillReq.PresId=p.pres_id WHERE p.prim_dr_id=@UserId
				END
			ELSE
				BEGIN
					SELECT  @Count=COUNT(1) FROM [erx].[RxFillRequests] fillReq WITH(NOLOCK)
					INNER JOIN prescriptions p WITH(NOLOCK) ON fillReq.PresId=p.pres_id WHERE p.dr_id=@UserId
				END
			SELECT  @Count += COUNT(1) FROM [erx].[RxFillRequests] fillReq WITH(NOLOCK) WHERE fillReq.PresId <= 0 AND fillReq.DoctorId=@UserId				
		END
	ELSE
		BEGIN
			SELECT  @Count=COUNT(1) FROM [erx].[RxFillRequests] fillReq WITH(NOLOCK)
					INNER JOIN prescriptions p WITH(NOLOCK) ON fillReq.PresId=p.pres_id WHERE p.dg_id=@DoctorGroupId
					
			SELECT  @Count += COUNT(1) FROM [erx].[RxFillRequests] fillReq WITH(NOLOCK) WHERE fillReq.PresId <= 0 AND fillReq.DoctorGroupId=@UserId
		END 
	
	
	Select @Count as FillRxCount	  
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
