SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientRxCoverageInfo] 
( 
	@PatientId	BIGINT,
	@PBMId		VARCHAR(15)=NULL,
	@PDId		BIGINT
) 
	RETURNS @Output TABLE(CardHolderLastName VARCHAR(100),BinNumber VARCHAR(100),CardHolderMiddleName VARCHAR(50),CardHolderFirstName VARCHAR(50),CardHolderID VARCHAR(50),PBMMemberNumber VARCHAR(100),PBMName VARCHAR(50),IsDirectConnect BIT)
BEGIN 
   
    
	
	DECLARE @IsDirectConnect AS BIT=0
	DECLARE @PBMName AS VARCHAR(50)=NULL
	
	SELECT TOP 1 @IsDirectConnect=ISNULL(is_direct_connect,0), @PBMName=pbm_name FROM Formularies..pbms WHERE rxhub_part_id=@PBMId ORDER BY pbm_id DESC
	
	IF @IsDirectConnect = 1
	BEGIN
		INSERT INTO @Output (CardHolderLastName,BinNumber,CardHolderMiddleName,CardHolderFirstName,CardHolderID,PBMMemberNumber,PBMName,IsDirectConnect)  
		SELECT TOP 1 PAC.card_holder_last CardHolderLastName, case when len(PAC.pa_bin) < 1 THEN PAC.pbm_member_id ELSE PAC.pa_bin END BinNumber,
		PAC.card_holder_mi CardHolderMiddleName,PAC.card_holder_first CardHolderFirstName,PAC.card_holder_id CardHolderID,PAC.pbm_member_id PBMMemberNumber
		, @PBMName AS PBMName, @IsDirectConnect AS IsDirectConnect 
		FROM patients_coverage_info_external PAC WITH(NOLOCK)
		INNER JOIN prescription_coverage_info PCI WITH(NOLOCK) ON PAC.rxhub_pbm_id=PCI.pbm_id
		WHERE PAC.rxhub_pbm_id=@PBMId AND PAC.pa_id=@PatientId AND PCI.pd_id=@PDId
		ORDER BY PAC.pci_id DESC
	END
	ELSE
	BEGIN
		INSERT INTO @Output (CardHolderLastName,BinNumber,CardHolderMiddleName,CardHolderFirstName,CardHolderID,PBMMemberNumber,PBMName,IsDirectConnect)  
		SELECT TOP 1 PAC.card_holder_last CardHolderLastName, pa_bin BinNumber,
		PAC.card_holder_mi CardHolderMiddleName,PAC.card_holder_first CardHolderFirstName,PAC.card_holder_id CardHolderID,PAC.pbm_member_id PBMMemberNumber
		, @PBMName AS PBMName, @IsDirectConnect AS IsDirectConnect FROM patients_coverage_info PAC WITH(NOLOCK)
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
