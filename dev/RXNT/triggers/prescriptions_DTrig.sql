SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[prescriptions_DTrig] ON [dbo].[prescriptions] FOR DELETE AS
/*
 * CASCADE DELETES TO 'prescription_details'
 */
DELETE prescription_details FROM deleted, prescription_details WHERE deleted.pres_id = prescription_details.pres_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[prescriptions_DTrig] ON [dbo].[prescriptions]
GO

GO
