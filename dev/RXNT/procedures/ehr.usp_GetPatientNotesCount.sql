SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		NIYAZ
-- Create date: 27-NOV-2018
-- Description:	Search patient Family Hx External
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetPatientNotesCount]   
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	
	Declare @Count as int
	
	SELECT @Count=COUNT(1) FROM  [dbo].[patient_notes] where pa_id = @PatientId AND void=0
	SELECT @Count;

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
