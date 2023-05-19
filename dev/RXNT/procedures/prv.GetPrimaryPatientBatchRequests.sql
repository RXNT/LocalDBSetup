SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 28-October-2016
-- Description:	Get merged request queue
-- =============================================
CREATE PROCEDURE [prv].[GetPrimaryPatientBatchRequests] 
	-- Add the parameters for the stored procedure here
	@PrimaryPatientId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select pa_merge_reqid,primary_pa_id,secondary_pa_id,ms.status,prmpa.pa_last+','+ prmpa.pa_first AS primary_pa_name,
	secpa.pa_last+','+ secpa.pa_first AS secondary_pa_name , d.dr_last_name+','+d.dr_first_name as RequestedBy 
	from Patient_merge_request_queue mrq 
	inner join  patient_merge_status ms on mrq.status=ms.statusid 
	inner join doctors d on d.dr_id=mrq.created_by 
	left join patients prmpa on mrq.primary_pa_id=prmpa.pa_id 
	left join patients secpa on mrq.secondary_pa_id=secpa.pa_id 
	where primary_pa_id=@PrimaryPatientId  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
