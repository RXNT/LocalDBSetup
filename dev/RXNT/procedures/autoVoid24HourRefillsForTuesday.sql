SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[autoVoid24HourRefillsForTuesday]
AS
/*** TRUNCATE PREVIOUS SCRIPTS ****/
TRUNCATE TABLE RxNTReportUtils..auto_void_scripts

/***FIND SCRIPTS TO BE VOIDED *****/
INSERT INTO RxNTReportUtils..auto_void_scripts SELECT A.pres_id FROM prescriptions A INNER JOIN refill_requests B
ON A.pres_id=B.pres_id WHERE pres_prescription_type=2 AND A.pres_delivery_method>3 AND pres_approved_date IS NULL AND 
pres_entry_date <= DateAdd(n,-1434,getdate())
AND pres_entry_date >= DateAdd(n,-4320,getdate())

/*** VOID SCRIPTS *****/
UPDATE prescriptions SET pres_approved_date = GETDATE(), 
pres_void = 1, pres_void_comments = 'Please send request by fax', pres_void_code = 0 WHERE pres_id in (SELECT pres_id FROM RxNTReportUtils..auto_void_scripts)

/***PUT SCRIPT INTO VOID TRANSMITTALS ****/
INSERT INTO prescription_void_transmittals (refreq_id, pres_id, pd_id, queued_date, delivery_method)
SELECT refreq_id, A.pres_id, pd_id, GETDATE(), pres_delivery_method & 0xFFFF0000 FROM prescriptions A,
refill_requests B, prescription_details C WHERE A.pres_id = B.pres_id AND A.pres_id = C.pres_id
AND A.pres_id IN
(SELECT pres_id FROM RxNTReportUtils..auto_void_scripts)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
