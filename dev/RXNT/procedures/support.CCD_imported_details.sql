SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  CREATE PROCEDURE [support].[CCD_imported_details] 
(  
@request_id INT,
@StatementType nvarchar(20) = ''  
)  
AS  
BEGIN  
IF @StatementType = 'All'  
SELECT TOP 1000 request.request_id,req.requested_on,request.ccd_file_name,pat.pa_id,pat.[pa_first],pat.[pa_middle],pat.[pa_last],pat.[pa_dob],pat.[pa_address1],pat.[pa_address2],pat.[pa_city],pat.[pa_state],pat.[pa_zip] ,pat.[pa_email],pat.[pa_sex],request.status_message
  FROM [Patient_CCD_import_request_details] request
  INNER JOIN [Patient_CCD_import_requests] req ON req.request_id = request.request_id
  LEFT JOIN [patients] pat ON pat.pa_id = request.pa_id

END  
IF @StatementType = 'Select'  
BEGIN  
SELECT TOP 1000 request.request_id,req.requested_on,request.ccd_file_name,pat.pa_id,pat.[pa_first],pat.[pa_middle],pat.[pa_last],pat.[pa_dob],pat.[pa_address1],pat.[pa_address2],pat.[pa_city],pat.[pa_state],pat.[pa_zip] ,pat.[pa_email],pat.[pa_sex],request.status_message
  FROM [Patient_CCD_import_request_details] request
  INNER JOIN [Patient_CCD_import_requests] req ON req.request_id = request.request_id
  LEFT JOIN [patients] pat ON pat.pa_id = request.pa_id
  WHERE request.request_id=@request_id
   ORDER BY pat.pa_id DESC
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
