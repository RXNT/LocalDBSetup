SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 05-SEP-2017
-- Description:	To get RxChange Count
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [prv].[GetChangeRxCount]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0
AS
BEGIN
	SET NOCOUNT ON;
	Declare @Count as int
	IF @IsRestrictToPersonalRx = 1 
		BEGIN
			IF @IsAgent = 1 
				BEGIN
					SELECT  @Count=COUNT(1) 
					FROM [erx].[RxChangeRequests] chgReq WITH(NOLOCK)
					INNER JOIN prescriptions p WITH(NOLOCK) ON chgReq.PresId=p.pres_id 
					INNER JOIN prescription_details pd WITH(NOLOCK) ON pd.pres_id=p.pres_id 
					WHERE p.prim_dr_id=@UserId 
					AND p.pres_prescription_type=5 AND p.pres_approved_date IS NULL 
					AND ISNULL(p.pres_void,0)=0 AND ISNULL(chgReq.IsApproved,0)=0 
					AND ISNULL(chgReq.IsVoided,0)=0
				END
			ELSE
				BEGIN
					SELECT  @Count=COUNT(1) 
					FROM [erx].[RxChangeRequests] chgReq WITH(NOLOCK)
					INNER JOIN prescriptions p WITH(NOLOCK) ON chgReq.PresId=p.pres_id 
					INNER JOIN prescription_details pd WITH(NOLOCK) ON pd.pres_id=p.pres_id 
					WHERE p.dr_id=@UserId
					AND p.pres_prescription_type=5 AND p.pres_approved_date IS NULL 
					AND ISNULL(p.pres_void,0)=0 AND ISNULL(chgReq.IsApproved,0)=0 AND ISNULL(chgReq.IsVoided,0)=0
				END		
		END
	ELSE
	BEGIN
		SELECT  @Count=COUNT(1) 
		FROM [erx].[RxChangeRequests] chgReq WITH(NOLOCK)
		INNER JOIN prescriptions p WITH(NOLOCK) ON chgReq.PresId=p.pres_id 
		INNER JOIN prescription_details pd WITH(NOLOCK) ON pd.pres_id=p.pres_id 
		WHERE p.dg_id=@DoctorGroupId
		AND p.pres_prescription_type=5 AND p.pres_approved_date IS NULL AND ISNULL(p.pres_void,0)=0 
		AND  ISNULL(chgReq.IsApproved,0)=0 AND ISNULL(chgReq.IsVoided,0)=0
	END 
	
	
	Select @Count as ChangeRxCount	  
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
