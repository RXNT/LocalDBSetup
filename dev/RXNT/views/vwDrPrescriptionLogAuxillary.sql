SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  VIEW [dbo].[vwDrPrescriptionLogAuxillary]
AS
  SELECT A.*,B.pres_id, drug_name, dosage, duration_amount, duration_unit, numb_refills, comments, use_generic, C.dg_id FROM prescription_status A
    INNER JOIN prescription_details B ON A.pd_id = B.pd_id INNER JOIN prescriptions C ON B.pres_id = C.pres_id WHERE off_dr_list = 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
