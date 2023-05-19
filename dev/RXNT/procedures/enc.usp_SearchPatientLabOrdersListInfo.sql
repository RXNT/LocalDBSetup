SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 28-Jan-2019
-- Description: Search Patient Lab Order Test
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SearchPatientLabOrdersListInfo]
(
	@PatientId INT
)
AS
BEGIN
	SELECT plo.test_type,plom.lab_master_id,plom.external_lab_order_id,plo.added_date,plom.order_date,plo.order_status,
plom.comments,plom.last_edit_date,DATEADD(hh,-d.time_difference,plom.order_sent_date) as order_sent_date,
plom.doc_group_lab_xref_id,plom.abn_file_path,plom.requisition_file_path, plom.label_file_path,plo.pa_lab_id, plo.lab_test_id,
plo.lab_test_name,plo.urgency,plo.diagnosis,plo.lab_result_info_id,d.dr_id, d.dr_prefix, d.dr_first_name, d.dr_middle_initial,
 d.dr_last_name, d.dr_suffix, ELog.statusresponse, ELOG.http_response_code FROM [RxNT].[dbo].patient_lab_orders_master plom 
  WITH(NOLOCK) INNER JOIN [RxNT].[dbo].patient_lab_orders plo  WITH(NOLOCK) ON plom.lab_master_id=plo.lab_master_id
   INNER JOIN [RxNT].[dbo].doctors d  WITH(NOLOCK) ON d.dr_id=plo.dr_id 
   Left Outer Join [RxNT].[dbo].ScalabullLog ELog ON Elog.ScalabullLogId=plom.ScalabullLogId AND Elog.message_type='ORDER'
 WHERE plom.pa_id=@PatientId  AND plo.isActive=1  AND plo.added_date >= DATEADD(day, -1, GETDATE())  
  ORDER BY plom.order_date DESC,plo.pa_lab_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
