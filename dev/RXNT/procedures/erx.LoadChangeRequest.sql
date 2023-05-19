SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	12-SEP-2017
-- Description:		Load Change Request Segments
-- =============================================
CREATE PROCEDURE [erx].[LoadChangeRequest]
  @DeliveryMethod			BIGINT,
  @PresId					BIGINT
AS
BEGIN
	SELECT PharmSeg, DoctorSeg, SupervisorSeg, PatientSeg, ReqDrug, PrescDrug, RequestSeg, VoidComments, VoidCode,ChgType, PriorAuthNum FROM erx.RxChangeRequests WHERE PresId=@PresId AND DeliveryMethod=@DeliveryMethod
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
