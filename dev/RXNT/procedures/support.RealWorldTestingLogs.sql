SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	JahabarYusuff
Create date			:	15-feb-2023
Description			:	This procedure is used to update the Patient's plugin visibility in PHR
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE   PROCEDURE [support].[RealWorldTestingLogs]	
	 
AS
BEGIN
	 
DECLARE @body NVARCHAR(MAX)
DECLARE @today DateTime =  DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)
DECLARE @thirtyDaysAgo DateTime =  DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)
DECLARE @emailSubject VARCHAR(500) = 'Real World Testing Logs -' + FORMAT(@today,'MM/dd/yyyy')
DECLARE @event_name VARCHAR(200)
DECLARE @event_name1 NVARCHAR(MAX) 
DECLARE @event_name2 NVARCHAR(MAX)
DECLARE @event_name3 NVARCHAR(MAX)


-- START PHR Health Summary Email --
SET @event_name='PHR Health Summary Email'
DECLARE @phr_ccd_email_section NVARCHAR(MAX)
DECLARE @phr_ccd_email_xml NVARCHAR(MAX)
 
SET @phr_ccd_email_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE (phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND  phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@phr_ccd_email_xml) > 0)
	BEGIN
		SET @phr_ccd_email_section = '<div>
										<H3>--------PHR CCD Email--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @phr_ccd_email_xml +
										'</table>
									</div>'
	END
ELSE 
	BEGIN 
	SET @phr_ccd_email_section = '<div>
										<H3>--------PHR CCD Email--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END  PHR Health Summary Email --			
		
-- START QRDA-III --
SET @event_name='QRDA Generated'
DECLARE @ehr_qrda_section NVARCHAR(MAX)
DECLARE @ehr_qrda_xml NVARCHAR(MAX)
 
SET @ehr_qrda_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE (phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@ehr_qrda_xml) > 0)
	BEGIN
	SET @ehr_qrda_section = '<div>
										<H3>--------QRDA-III--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @ehr_qrda_xml +
										'</table>
									</div>'
	END
ELSE 
	BEGIN 
	SET @ehr_qrda_section = '<div>
										<H3>--------QRDA-III--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END QRDA-III --

		
-- Immunization File Generated --
SET @event_name='New Immunization Record'
DECLARE @immunization_outgng_section NVARCHAR(MAX)
DECLARE @immunization_outgng_section_xml NVARCHAR(MAX)
 
SET @immunization_outgng_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE (phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@immunization_outgng_section_xml) > 0)
	BEGIN
	SET @immunization_outgng_section = '<div>
										<H3>--------Immunization File Generated--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @immunization_outgng_section_xml +
										'</table>
									</div>'	
	END		
ELSE 
	BEGIN 
		SET @immunization_outgng_section = '<div>
										<H3>--------Immunization File Generate--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Immunization File Generated --

-- START Immunization File Received --
SET @event_name='Immunization History Received'
DECLARE @immunization_incmg_section NVARCHAR(MAX)
DECLARE @immunization_incmg_section_xml NVARCHAR(MAX)
 
SET @immunization_incmg_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@immunization_incmg_section_xml) > 0)
	BEGIN
	SET @immunization_incmg_section = '<div>
										<H3>--------Immunization File Received--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @immunization_incmg_section_xml +
										'</table>
									</div>'	
	END		
ELSE 
	BEGIN 
		SET @immunization_incmg_section = '<div>
										<H3>--------Immunization File Received--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Immunization File Received --


-- START Bulk CCD Requests --
SET @event_name1='Bulk CCD Requests'
SET @event_name2='Bulk CCD Requests by Timeframe'
DECLARE @bulk_ccd_requests_section NVARCHAR(MAX)
DECLARE @bulk_ccd_requests_section_xml NVARCHAR(MAX)
 
SET @bulk_ccd_requests_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND  
 phr_log.[event_name] IN (@event_name1, @event_name2)
 ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@bulk_ccd_requests_section_xml) > 0)
	BEGIN
	SET @bulk_ccd_requests_section = '<div>
										<H3>--------Bulk CCD Requests--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @bulk_ccd_requests_section_xml +
										'</table>
									</div>'
	END	
ELSE 
	BEGIN 
		SET @bulk_ccd_requests_section = '<div>
										<H3>--------Bulk CCD Requests--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Bulk CCD Requests --

-- START Direct Email CCD --
SET @event_name='Direct Email CCD - Sent'
DECLARE @direct_email_ccd_section NVARCHAR(MAX)
DECLARE @direct_email_ccd_section_xml NVARCHAR(MAX)
 
SET @direct_email_ccd_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@direct_email_ccd_section_xml) > 0)
	BEGIN
	SET @direct_email_ccd_section = '<div>
										<H3>--------Direct Email CCD--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @direct_email_ccd_section_xml +
										'</table>
									</div>'
	END	
ELSE 
	BEGIN 
		SET @direct_email_ccd_section = '<div>
										<H3>--------Direct Email CCD--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Direct Email CCD --


-- START Direct Email Received --
SET @event_name ='Direct Email Received'
DECLARE @direct_email_received_section NVARCHAR(MAX)
DECLARE @direct_email_received_section_xml NVARCHAR(MAX)
SET @direct_email_received_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name] = @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@direct_email_received_section_xml) > 0)
	BEGIN
	SET @direct_email_received_section = '<div>
										<H3>--------Direct Email Received--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @direct_email_received_section_xml +
										'</table>
									</div>'	
	END	
ELSE 
	BEGIN 
		SET @direct_email_received_section = '<div>
										<H3>--------Direct Email Received--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Direct Email Received --

-- START Direct Email Sent --
SET @event_name='Direct Email Sent'
DECLARE @direct_email_section NVARCHAR(MAX)
DECLARE @direct_email_section_xml NVARCHAR(MAX)
 
SET @direct_email_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND phr_log.[event_name]= @event_name ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@direct_email_section_xml) > 0)
	BEGIN
	SET @direct_email_section = '<div>
										<H3>--------Direct Email Sent--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @direct_email_section_xml +
										'</table>
									</div>'	
	END	
ELSE 
	BEGIN 
		SET @direct_email_section = '<div>
										<H3>--------Direct Email Sent--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Direct Email Sent --



-- START Patient API --
SET @event_name1 ='Patient API - Patient Selection'
SET @event_name2 ='Patient API - Data Category Request'
SET @event_name3  ='Patient API - All Data Request'
DECLARE @patient_api_section NVARCHAR(MAX)
DECLARE @patient_api_section_xml NVARCHAR(MAX)
 
SET @patient_api_section_xml = CAST(( SELECT  phr_log.[event_name] AS 'td','', phr_log.[event_status] AS 'td','', FORMAT (phr_log.[event_date], 'MM/dd/yyyy hh:mm tt')    AS 'td','' 
FROM  [RxNT].[dbo].[real_world_testing_log] phr_log WHERE(phr_log.[event_date] BETWEEN @thirtyDaysAgo AND @today) AND  
 phr_log.[event_name] IN (@event_name1, @event_name2, @event_name3)
 ORDER BY phr_log.[event_date]  ASC
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))
IF (LEN(@patient_api_section_xml) > 0)
	BEGIN
	SET @patient_api_section = '<div>
										<H3>--------Patient API--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>' 
											 + @patient_api_section_xml +
										'</table>
									</div>'	
	END	
ELSE 
	BEGIN 
		SET @patient_api_section = '<div>
										<H3>--------Patient API--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Event Status </th> <th> Event Date </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END Patient API --


-- START Medication Reconciliation --
SET @event_name='Medication Reconciliation'
DECLARE @med_reconciliation_section NVARCHAR(MAX)
DECLARE @med_reconciliation_xml NVARCHAR(MAX)
 
SET @med_reconciliation_xml = CAST(( SELECT  'Medication Reconciliation' AS 'td','', COUNT(1) AS 'td',''
FROM  [RxNT].[dbo].[patient_measure_compliance]  phr_log WHERE phr_log.rec_type=7 AND phr_log.rec_date BETWEEN @thirtyDaysAgo AND @today
AND EXISTS(SELECT * FROM  [RxNT].[dbo].[patient_active_meds_external] pnae WHERE pnae.pame_pa_id=phr_log.pa_id AND pnae.pame_date_added BETWEEN @thirtyDaysAgo AND @today AND pnae.is_from_ccd=1)
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@med_reconciliation_xml) > 0)
	BEGIN
		SET @med_reconciliation_section = '<div>
										<H3>--------Medication Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th> </tr>' 
											 + @med_reconciliation_xml +
										'</table>
									</div>'
	END
ELSE 
	BEGIN 
	SET @med_reconciliation_section = '<div>
										<H3>--------Medication Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th> </tr>
											 <tr><td colspan="2">No Data Found</td>
										</table>
									</div>'
	END
-- END  Medication Reconciliation --			

-- START Problem Reconciliation --
SET @event_name='Problem Reconciliation'
DECLARE @problem_reconciliation_section NVARCHAR(MAX)
DECLARE @problem_reconciliation_xml NVARCHAR(MAX)
 
SET @problem_reconciliation_xml = CAST(( SELECT  'Problem Reconciliation' AS 'td','', COUNT(1) AS 'td','' 
FROM  [RxNT].[dbo].[patient_measure_compliance]  phr_log WHERE phr_log.rec_type=6 AND phr_log.rec_date BETWEEN @thirtyDaysAgo AND @today
AND EXISTS(SELECT * FROM  [RxNT].[dbo].[patient_active_diagnosis_external] pnae WHERE pnae.pde_pa_id=phr_log.pa_id AND pnae.pde_date_added BETWEEN @thirtyDaysAgo AND @today AND pnae.is_from_ccd=1)
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@problem_reconciliation_xml) > 0)
	BEGIN
		SET @problem_reconciliation_section = '<div>
										<H3>--------Problem Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th> </tr>' 
											 + @problem_reconciliation_xml +
										'</table>
									</div>'
	END
ELSE 
	BEGIN 
	SET @problem_reconciliation_section = '<div>
										<H3>--------Problem Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th> </tr>
											 <tr><td colspan="2">No Data Found</td>
										</table>
									</div>'
	END
-- END  Problem Reconciliation --			


-- START Allergy Reconciliation --
SET @event_name='Allergy Reconciliation'
DECLARE @allergy_reconciliation_section NVARCHAR(MAX)
DECLARE @allergy_reconciliation_xml NVARCHAR(MAX)
 
SET @allergy_reconciliation_xml = CAST(( SELECT  'Allergy Reconciliation' AS 'td','', COUNT(1) AS 'td','' 
FROM  [RxNT].[dbo].[patient_measure_compliance]  phr_log WHERE phr_log.rec_type=8 AND phr_log.rec_date BETWEEN @thirtyDaysAgo AND @today 
AND EXISTS(SELECT * FROM  [RxNT].[dbo].[patient_new_allergies_external] pnae WHERE pnae.pae_pa_id=phr_log.pa_id AND pnae.pae_add_date BETWEEN @thirtyDaysAgo AND @today AND pnae.is_from_ccd=1)
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))

IF (LEN(@allergy_reconciliation_xml) > 0)
	BEGIN
		SET @allergy_reconciliation_section = '<div>
										<H3>--------Allergy Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th></tr>' 
											 + @allergy_reconciliation_xml +
										'</table>
									</div>'
	END
ELSE 
	BEGIN 
	SET @allergy_reconciliation_section = '<div>
										<H3>--------Allergy Reconciliation--------</H3>
										<table border = 1>  
											 <tr>
											 <th> Event Name </th> <th> Count </th></tr>
											 <tr><td colspan="3">No Data Found</td>
										</table>
									</div>'
	END
-- END  Allergy Reconciliation --	

-- START PHR Summary --
	DECLARE @event_type INT
		SET @event_name='Patient Portal Login Access'
	SET @event_type=1
	DECLARE @phr_login_section NVARCHAR(MAX)
	DECLARE @phr_login_xml NVARCHAR(MAX)

	SET @phr_login_xml = CAST(( 
		SELECT  @event_name AS 'td','', COUNT(DISTINCT phr_log.pa_id) AS 'td','' 
	FROM [RxNT].[dbo].patient_phr_access_log phr_log WITH(NOLOCK)
	INNER JOIN [RxNT].[dbo].patients pat WITH(NOLOCK) ON pat.pa_id = phr_log.pa_id
	WHERE (phr_log.[phr_access_datetime] BETWEEN @thirtyDaysAgo AND @today) 
	AND phr_log.[phr_access_type]= @event_type 
	FOR XML PATH('tr'), ELEMENTS 
	) AS NVARCHAR(MAX))

	IF (LEN(@phr_login_xml) > 0)
		BEGIN
			SET @phr_login_section = '<div>
											<H3>---------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>' 
												+ @phr_login_xml +
											'</table>
										</div>'
		END
	ELSE 
		BEGIN 
		SET @phr_login_section = '<div>
											<H3>--------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>
												<tr><td colspan="2">No Data Found</td></tr>
											</table>
										</div>'
		END
	-- END  PHR Health Summary Email --		




	-- START PHR Summary --
	SET @event_name='Patient Portal Health Summary View'
	SET @event_type=6
	DECLARE @phr_view_section NVARCHAR(MAX)
	DECLARE @phr_view_xml NVARCHAR(MAX)

	SET @phr_view_xml = CAST(( 
		SELECT  @event_name AS 'td','', COUNT(DISTINCT phr_log.pa_id) AS 'td','' 
	FROM [RxNT].[dbo].patient_phr_access_log phr_log WITH(NOLOCK)
	INNER JOIN [RxNT].[dbo].patients pat WITH(NOLOCK) ON pat.pa_id = phr_log.pa_id
	WHERE (phr_log.[phr_access_datetime] BETWEEN @thirtyDaysAgo AND @today) 
	AND phr_log.[phr_access_type]= @event_type 
	FOR XML PATH('tr'), ELEMENTS 
	) AS NVARCHAR(MAX))

	IF (LEN(@phr_view_xml) > 0)
		BEGIN
			SET @phr_view_section = '<div>
											<H3>---------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>'  
												+ @phr_view_xml +
											'</table>
										</div>'
		END
	ELSE 
		BEGIN 
		SET @phr_view_section = '<div>
											<H3>--------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>
												<tr><td colspan="2">No Data Found</td>
											</table>
										</div>'
		END
	-- END  PHR Health Summary Email --		




	-- START PHR Summary --
	SET @event_name='Patient Portal Health Summary Downloaded'
	SET @event_type=2
	DECLARE @phr_download_section NVARCHAR(MAX)
	DECLARE @phr_download_xml NVARCHAR(MAX)

	SET @phr_download_xml = CAST(( 
		SELECT  @event_name AS 'td','', COUNT(DISTINCT phr_log.pa_id) AS 'td','' 
	FROM [RxNT].[dbo].patient_phr_access_log phr_log WITH(NOLOCK)
	INNER JOIN [RxNT].[dbo].patients pat WITH(NOLOCK) ON pat.pa_id = phr_log.pa_id
	WHERE (phr_log.[phr_access_datetime] BETWEEN @thirtyDaysAgo AND @today) 
	AND phr_log.[phr_access_type]= @event_type 
	FOR XML PATH('tr'), ELEMENTS 
	) AS NVARCHAR(MAX))

	IF (LEN(@phr_download_xml) > 0)
		BEGIN
			SET @phr_download_section = '<div>
											<H3>---------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>' 
												+ @phr_download_xml +
											'</table>
										</div>'
		END
	ELSE 
		BEGIN 
		SET @phr_download_section = '<div>
											<H3>--------'+@event_name+'--------</H3>
											<table border = 1>  
												<tr>
												<th> Event Name </th> <th> Count </th> </tr>
												<tr><td colspan="2">No Data Found</td>
											</table>
										</div>'
		END
 								
-- END PHR Summary --

SET @body = '<html><body>'+@phr_ccd_email_section+@ehr_qrda_section+@immunization_outgng_section+@immunization_incmg_section
							+@bulk_ccd_requests_section
							+@direct_email_ccd_section+@direct_email_section+@direct_email_received_section+@patient_api_section
							+@med_reconciliation_section+@problem_reconciliation_section+@allergy_reconciliation_section
							+@phr_login_section+@phr_view_section+@phr_download_section+'</body></html>'

--PRINT @body;


 

EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'RxNTEmail', -- replace with your SQL Database Mail Profile 
@body = @body,
@body_format ='HTML',
@recipients = 'arasheed@rxnt.com;yusuff@rxnt.com;thomask@rxnt.com;product@rxnt.com',
@subject = @emailSubject;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
