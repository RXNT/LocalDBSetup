SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Afsal Y
-- Create date: 06-APRIL-2017
-- Description:	Save Or Update Promotion
-- =============================================
CREATE PROCEDURE [adm].[usp_SaveBannerAd]
	@SponsorId		INT,
	@LoggedInId     INT,
	@BannerAdId	INT				= NULL,
	@ProgrammeName	VARCHAR(80) = NULL,
	@TargetedPlatform VARCHAR(50)= NULL,
	@StartDate		DATE		= NULL,
	@EndDate		DATE		= NULL,
	@States			VARCHAR(100)= NULL,
	@CurrentCount	INT			= NULL,
	@SessionCount	INT			= NULL,
	@Increments		INT			= NULL,
	@IsComplete		INT			= NULL,
	@Active			BIT			= NULL,
	@ControlFactor	FLOAT		= NULL,
	@Gender			VARCHAR(8)	= NULL,
	@MinAge			INT			= NULL,
	@MaxAge			INT			= NULL,
	@Message		VARCHAR(MAX)= NULL,
	@MedName		VARCHAR(80)	= NULL,
	@MedId			INT			= NULL,
	@Speciality1	INT			= NULL,
	@Speciality2	INT			= NULL,
	@Speciality3	INT			= NULL,
	@Type			INT			= NULL,
	@Url			VARCHAR(80)	= NULL
	
	
AS

BEGIN
	SET NOCOUNT ON;

	IF ISNULL(@BannerAdId,0) = 0 
	BEGIN
		INSERT INTO dbo.rxnt_sg_promotions
			(
			 sponsor_id,
			 medid,
			 med_name,
			 dtStart,
			 dtEnd,
			 state_exclusion,
			 min_age,
			 iscomplete,
			 Active,
			 max_age,
			 gender,
			 ctrl_fac,
			 message,
			 name,
			 session_count,
			 increments,
			 speciality_1,
			 speciality_2,
			 speciality_3,
			 type,
			 url,
			 TargetedPlatform,
			 CreatedDate,
			 CreatedBy
			 ) 
		VALUES 
		   ( 
			@SponsorId,
			@MedId,
			@MedName,
			@StartDate,
			@EndDate,
			@States,
			@MinAge,
			0,
			1,
			@MaxAge,
			@Gender,
			@ControlFactor,
			@Message,
			@ProgrammeName,
			@SessionCount,
			@Increments,
			@Speciality1,
			@Speciality2,
			@Speciality3,
			@Type,
			@Url,
			@TargetedPlatform, 
			GETDATE(),
			@LoggedInId
			)
	END
		
	ELSE
	BEGIN
	
		UPDATE dbo.rxnt_sg_promotions
		
		SET med_name		= @MedName,
			medid			= @MedId,
			dtStart			= @StartDate,
			dtEnd			= @EndDate,
			state_exclusion	= @States,
			min_age			= @MinAge,
			max_age			= @MaxAge,
			gender			= @Gender,
			ctrl_fac		= @ControlFactor,
			message			= @Message,
			name			= @ProgrammeName,
			session_count	= @SessionCount,
			increments		= @Increments,
			iscomplete		= 0,
			speciality_1	= @Speciality1,
			speciality_2	= @Speciality2,
			speciality_3	= @Speciality3,
			type			= @Type,
			url				= @Url,
			TargetedPlatform = @TargetedPlatform,
			ModifiedDate    = GETDATE(),
			ModifiedBy      = @LoggedInId
			
        WHERE ad_id = @BannerAdId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
