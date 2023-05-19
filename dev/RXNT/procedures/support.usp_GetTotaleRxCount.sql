SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	26-JULY-2019
Description			:	This procedure is used to get total eRx Count based on input
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [support].[usp_GetTotaleRxCount]
	-- Add the parameters for the stored procedure here
	@IncludeEPCS				BIT=1, -- Whether to include EPCS(Controlled Meds) count or not
	@IncludeNonEPCS				BIT=1, -- Whether to include Non-EPCS(Non-Controlled Meds) count or not
	@IncludeSuccessfuleRx		BIT=1, -- Whether to include Successfully Completed eRx count or not
	@IncludeUnsuccessfuleRx		BIT=1, -- Whether to include Errored eRx count or not
	@FromDate					VARCHAR(20)=NULL, -- From Date in YYYY/MM/DD or YYYY-MM-DD format
	@ToDate						VARCHAR(20)=NULL -- To Date in YYYY/MM/DD or YYYY-MM-DD format
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT		COUNT(1) as eRxCount
	FROM		prescriptions P WITH(NOLOCK)
				INNER JOIN prescription_details PD WITH(NOLOCK) ON P.pres_id = PD.pres_id
				INNER JOIN prescription_status PS WITH(NOLOCK) ON PD.pd_id = PS.pd_id
				LEFT OUTER JOIN RMIID1 MED WITH(NOLOCK) ON PD.ddid = MED.MEDID
	WHERE		P.pres_void = 0 AND
				P.prim_dr_id >= 0 AND
				P.dr_id >= 0 AND
				P.dg_id >= 0 AND
				PD.cancel_status IS NULL AND
				PS.delivery_method=262144 AND
				(
					(
						@FromDate IS NULL AND
						@ToDate IS NULL
					) OR
					(
						@FromDate IS NOT NULL AND
						@ToDate IS NOT NULL AND
						CONVERT(VARCHAR, P.PRES_APPROVED_DATE, 21) BETWEEN 
						CONVERT(VARCHAR, cast(@FromDate AS DATETIME), 21) AND
						CONVERT(VARCHAR, cast(@ToDate AS DATETIME), 21)
					)
				) AND
				(
					(
						@IncludeEPCS=1 AND
						@IncludeNonEPCS=1
					) OR
					(
						@IncludeEPCS=1 AND
						ISNULL(@IncludeNonEPCS, 0)=0 AND
						MED.MED_REF_DEA_CD >= 2
					) OR
					(
						@IncludeNonEPCS=1 AND
						ISNULL(@IncludeEPCS, 0)=0 AND
						MED.MED_REF_DEA_CD < 2
					)
				) AND
				(
					(
						@IncludeSuccessfuleRx=1 AND
						@IncludeUnsuccessfuleRx=1
					) OR
					(
						@IncludeSuccessfuleRx=1 AND
						ISNULL(@IncludeUnsuccessfuleRx, 0)=0 AND
						PS.response_type=0
					) OR
					(
						@IncludeUnsuccessfuleRx=1 AND
						ISNULL(@IncludeSuccessfuleRx, 0)=0 AND
						PS.response_type<>0
					)
				)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
