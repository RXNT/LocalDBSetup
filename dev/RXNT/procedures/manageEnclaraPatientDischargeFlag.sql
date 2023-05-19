SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[manageEnclaraPatientDischargeFlag]
	-- Add the parameters for the stored procedure here
	@dc_id int, 
	@pa_id int,
	@discharge_flag bit
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @FLAG_ID AS INT
	DECLARE @PA_FLAG_ID INT

	IF(@discharge_flag < 1)
	BEGIN
		-- delete discharge flag if any exists
		DELETE PFD FROM [patient_flags] PF with(nolock) 
			inner join [patient_flag_details] PFD with(nolock) on PF.flag_id = PFD.flag_id
		where PFD.pa_id = @pa_id and lower(PF.flag_title) like 'discharged'
		return;
	END
    -- Insert statements for procedure here
	select @FLAG_ID=flag_id from [dbo].[patient_flags] with(nolock) where dc_id=@dc_id and lower(flag_title) like 'discharged'
	IF @FLAG_ID IS NULL Or NOT(@FLAG_ID > 0)
		BEGIN
			INSERT INTO [dbo].[patient_flags] ([flag_title],[dc_id], is_enabled) VALUES ('Discharged', @dc_id, 1)
			SET @FLAG_ID=SCOPE_IDENTITY()
		END
	select @PA_FLAG_ID = PA_FLAG_ID from [dbo].[patient_flag_details] with(nolock) where pa_id=@pa_id and FLAG_ID = @FLAG_ID
	IF @PA_FLAG_ID is NULL Or NOT(@PA_FLAG_ID > 0)
		BEGIN
			INSERT INTO [dbo].[patient_flag_details] ([pa_id],[flag_id],[flag_text],[dr_id]) VALUES (@pa_id, @FLAG_ID, 'Discharged',1)
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
