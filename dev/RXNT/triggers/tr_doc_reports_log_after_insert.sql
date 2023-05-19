SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER tr_doc_reports_log_after_insert
ON dbo.doc_reports_log
AFTER INSERT
AS
  DECLARE @DrId As INTEGER, @PrintDate As SMALLDATETIME, @ExistingPrintDate As SMALLDATETIME
  SELECT @DrId = dr_id, @PrintDate = print_date FROM inserted
  SELECT @ExistingPrintDate = report_print_date FROM doctors WHERE dr_id = @DrId
  IF @PrintDate > @ExistingPrintDate
    UPDATE doctors SET report_print_date = @PrintDate WHERE dr_id = @DrId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[tr_doc_reports_log_after_insert] ON [dbo].[doc_reports_log]
GO

GO
