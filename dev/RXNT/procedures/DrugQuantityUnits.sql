SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu S
-- Create date: 4-Oct-2019
-- Description:	Get all drug quantity unit
-- =============================================

CREATE PROCEDURE [dbo].[DrugQuantityUnits]
	AS
BEGIN
SELECT * FROM drug_quantity_units;         
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
