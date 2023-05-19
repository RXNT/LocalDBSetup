SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	23-SEP-2016
Description			:	This procedure is used to get patient labs count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_GetPatientLabCount]
	-- Add the parameters for the stored procedure here
	@DoctorId BIGINT, @DoctorGroupId BIGINT, @IsRestrictToPersonalRx bit = 1, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Count as int
	IF @IsRestrictToPersonalRx =1
	BEGIN
		select @Count = COUNT(lm.LAB_ID) from lab_main lm  WITH(NOLOCK)
		INNER JOIN lab_pat_details lpd WITH(NOLOCK) ON lm.lab_id =lpd.lab_id
		where is_read = 0 and dr_id = @DoctorId 
		AND lm.dg_id = @DoctorGroupId
		AND (@PatientFirstName IS NULL OR lpd.pa_first LIKE @PatientFirstName+'%')  
		AND (@PatientLastName IS NULL OR lpd.pa_last LIKE @PatientLastName+'%')  
 
	END
	ELSE
	BEGIN
		select @Count = COUNT(lm.LAB_ID) from lab_main lm WITH(NOLOCK)
		INNER JOIN lab_pat_details lpd WITH(NOLOCK) ON lm.lab_id =lpd.lab_id where is_read = 0 and dg_id = @DoctorGroupId 
		AND (@PatientFirstName IS NULL OR lpd.pa_first LIKE @PatientFirstName+'%')  
		AND (@PatientLastName IS NULL OR lpd.pa_last LIKE @PatientLastName+'%')  
	END
	Select @Count as PatientLabCount
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
