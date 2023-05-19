SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  VIEW [dbo].[vwPatientsExtended]
AS
SELECT patients.*, deleted_pa_id,MergePatientsXRef.pa_id old_pa_id FROM patients INNER JOIN MergePatientsXRef ON patients.pa_id = MergePatientsXRef.deleted_pa_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
