SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Reiah
-- Create date	: 2017/14/Jul
-- Description	: Fetch the Sig
-- =============================================
CREATE PROCEDURE [dbo].[LoadPrescriptionSigByPdId]
	@pd_id int
AS
BEGIN
	SELECT  
	pd_sig_id,
	pd_id,
	sig_sequence_number,
	sig_action,sig_qty,
	sig_form,sig_route,
	sig_time_qty,
	sig_time_option 
	FROM prescription_sig_details WITH(NOLOCK)
	WHERE pd_id = @pd_id	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
