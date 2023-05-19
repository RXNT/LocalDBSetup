SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
==========================================================================================
Author:		Sheik
Create date: 22-Jan-2020
Description: to fetch all get all Person Resource Appointment Schedule
==========================================================================================
*/

CREATE   PROCEDURE [sch].[usp_GetAllAppointmentNotes] 
@AppointmentId BIGINT
AS
BEGIN
	SELECT AN.NoteId,
	AN.AppointmentsId,
	AN.NoteText,
	AN.NoteDate,
	AN.CreatedDate,
	ISNULL(AL.LastName,'')  + ',' + ISNULL(' ' + AL.FirstName,'') +
	COALESCE(' ' + AL.MiddleInitial, '') As FullName
	FROM [dbo].[RsynSchedulerV2AppointmentNotes]  AN WITH (NOLOCK)
	INNER JOIN [dbo].[RsynSchedulerV2vwAppLogins] AL WITH(NOLOCK) ON AL.LogInId = AN.CreatedBy
	WHERE AN.AppointmentsId = @AppointmentId AND AN.Active = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
