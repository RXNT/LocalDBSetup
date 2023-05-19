SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 6-9-2019
-- Description:	to Save Doctor Restriction List
-- =============================================
CREATE PROCEDURE [dbo].[usp_SaveDoctorRestriction] --17821,40931190
	
	@DoctorId BIGINT,
	@PatientId BIGINT,
	@isRestricted BIT
AS

BEGIN
	SET NOCOUNT ON;
	IF EXISTS(select * from patient_chart_restricted_users with(nolock) where dr_id=@DoctorId and pa_id = @PatientId)
		update patient_chart_restricted_users set isRestricted = @isRestricted where dr_id=@DoctorId and pa_id = @PatientId
	ELSE
		insert into patient_chart_restricted_users (pa_id,dr_id,isRestricted) values(@PatientId,@DoctorId,@isRestricted);


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
