SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwPatientNotes]
AS
SELECT     TOP 100 PERCENT dbo.patient_notes.note_id, dbo.patient_notes.pa_id, dbo.patient_notes.note_date, dbo.patient_notes.dr_id, 
                      dbo.patient_notes.note_text, dbo.doctors.dr_first_name, dbo.doctors.dr_middle_initial, dbo.doctors.dr_last_name, dbo.doctors.dr_prefix, 
                      dbo.doctors.dr_suffix,dbo.patient_notes.note_html
FROM         dbo.patient_notes INNER JOIN
                      dbo.doctors ON dbo.patient_notes.dr_id = dbo.doctors.dr_id
WHERE     (dbo.patient_notes.void = 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
