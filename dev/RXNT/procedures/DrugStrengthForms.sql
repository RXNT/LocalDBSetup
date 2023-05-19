SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu S
-- Create date: 4-Oct-2019
-- Description:	Get all drug strength form
-- =============================================

CREATE PROCEDURE [dbo].[DrugStrengthForms]
	AS
BEGIN
SELECT * FROM drug_strength_forms                         
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
