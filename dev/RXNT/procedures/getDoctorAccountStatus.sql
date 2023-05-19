SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getDoctorAccountStatus] 
	(@userName VARCHAR(50),
	@password VARCHAR(250))
AS
DECLARE @curretDate AS SMALLDATETIME = GETDATE()
DECLARE @expDate AS DATETIME
DECLARE @accEnable AS INT
DECLARE @result AS INT
BEGIN
	IF EXISTS(SELECT dr_id FROM doctors WITH(NOLOCK) WHERE dr_username=@userName AND dr_password=@password)
		BEGIN
			 SELECT @expDate = password_expiry_date  FROM doctors WITH(NOLOCK) WHERE dr_username=@userName AND dr_password=@password
			 IF @expDate IS NOT NULL
				 BEGIN
					 IF @expDate < @curretDate
					 BEGIN
						--Password Expired
						SET @result=1
					 END
					 ELSE 
					 BEGIN
						SELECT @expDate=ML.PasswordExpiryDate FROM dbo.RsynMasterLoginInfo MLI WITH(NOLOCK) 
						INNER JOIN  dbo.RsynRxNTMasterLogins ML WITH(NOLOCK)ON MLI.LoginId=ML.LoginId
						WHERE MLI.Text1=@userName
						IF @expDate < @curretDate
						 BEGIN
							--Password Expired
							SET @result=1
						 END
					 END		
					 IF @expDate >= @curretDate
						BEGIN
							SELECT @accEnable = dr_enabled FROM doctors WITH(NOLOCK) WHERE dr_username=@userName AND dr_password=@password
							IF @accEnable=1
								BEGIN
									-- Active Account
									SET @result=3
								END
							ELSE
								BEGIN
									--Account InActive
									SET @result=2
								END	
						END	 
				 END
			ELSE
				BEGIN
					--Password Expired
					SET @result=0
				END	 
		END
	ELSE
		BEGIN
			-- InValid Username/Password
			SET @result=0
		END	
		
	SELECT @result AS Result	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
