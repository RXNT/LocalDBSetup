SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  VIEW [dbo].[vwPatients]
AS
SELECT     dbo.patients.pa_id,dbo.patients.pa_field_not_used1, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, dbo.patients.pa_dob, dbo.patients.pa_ssn , dbo.patients.pa_address1, 
                      dbo.patients.pa_city, dbo.patients.pa_state, dbo.patients.pa_zip, dbo.patients.pa_phone, dbo.doc_groups.dc_id,
                          (SELECT     COUNT(dbo.patient_notes.note_id)
                            FROM          dbo.patient_notes
                            WHERE      dbo.patient_notes.pa_id = dbo.patients.pa_id) AS note_count
FROM         dbo.patients INNER JOIN
                      dbo.doc_groups ON dbo.patients.dg_id = dbo.doc_groups.dg_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
