SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Nambi  
-- ALTER  date: 02/16/2018 
-- Description: Load the Patient Coverage Info
-- Modified By : Nambi
-- Modified Date: 02/16/2018
-- Modified Description:  Created the SP
-- =============================================  
CREATE  PROCEDURE [dbo].[SS_LoadPatientCoverageInfo]
 @PatientId				BIGINT,
 @PBMId					VARCHAR(15)=NULL,
 @PDId					BIGINT
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @IsDirectConnect AS BIT=0
	DECLARE @PBMName AS VARCHAR(50)=NULL
	
	SELECT TOP 1 @IsDirectConnect=ISNULL(is_direct_connect,0), @PBMName=pbm_name FROM Formularies..pbms WHERE rxhub_part_id=@PBMId ORDER BY pbm_id DESC
	
	IF @IsDirectConnect = 1
	BEGIN
		SELECT TOP 1 PAC.card_holder_last, case when len(PAC.pa_bin) < 1 THEN PAC.pbm_member_id ELSE PAC.pa_bin END pa_bin,
		PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id, @PBMName AS pbm_name, @IsDirectConnect AS is_direct_connect FROM patients_coverage_info_external PAC WITH(NOLOCK)
		INNER JOIN prescription_coverage_info PCI WITH(NOLOCK) ON PAC.rxhub_pbm_id=PCI.pbm_id
		WHERE PAC.rxhub_pbm_id=@PBMId AND PAC.pa_id=@PatientId AND PCI.pd_id=@PDId
		ORDER BY PAC.pci_id DESC
	END
	ELSE
	BEGIN
		SELECT TOP 1 PAC.card_holder_last, pa_bin,
		PAC.card_holder_mi,PAC.card_holder_first,PAC.card_holder_id,PAC.pbm_member_id, @PBMName AS pbm_name, @IsDirectConnect AS is_direct_connect FROM patients_coverage_info PAC WITH(NOLOCK)
		INNER JOIN prescription_coverage_info PCI WITH(NOLOCK) ON PAC.rxhub_pbm_id=PCI.pbm_id
		WHERE rxhub_pbm_id=@PBMId AND PAC.pa_id=@PatientId AND PCI.pd_id=@PDId
		ORDER BY PAC.pci_id DESC
	END
		
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
