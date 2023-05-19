SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 05-OCT-2017
-- Description:	Search BenefitsCoordination For Patient
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [prv].[SearchBenefitsCoordinationForPatient]
  @PatientId					BIGINT
AS
BEGIN
	SELECT TOP 1 ic_group_numb,card_holder_first, card_holder_last,pa_bin,card_holder_id FROM patients_coverage_info WHERE pa_id=@PatientId ORDER BY pci_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
