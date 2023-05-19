SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CCD_import_requests]  
(  
@request_id INT
,@dc_id INTEGER
,@dg_id  INTEGER
,@dr_id INTEGER

,@ccd_file_location  VARCHAR(max)

,@requested_by INTEGER

,@comments VARCHAR(max)
,@StatementType VARCHAR(20) = ''  
)  
AS  
BEGIN  
IF @StatementType = 'Insert'  
	INSERT INTO Patient_CCD_import_requests
	(dc_id,dg_id,dr_id,updated_on,ccd_file_location,max_retry_count,status,requested_by,requested_on,comments)
	VALUES
	(@dc_id,@dg_id,@dr_id,CURRENT_TIMESTAMP,@ccd_file_location
	,0,1,@requested_by,CURRENT_TIMESTAMP,@comments)
END  
IF @StatementType = 'Select'  
BEGIN  
	select * from Patient_CCD_import_requests  
END  
 
else IF @StatementType = 'Delete'  
BEGIN  
	DELETE FROM Patient_CCD_import_requests WHERE request_id = @request_id  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
