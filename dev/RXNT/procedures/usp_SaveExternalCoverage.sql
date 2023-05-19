SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  <Kanniyappan >  
-- Create date: <04-22-2016>  
-- Description: <Insert/Update external coverage data>  
-- =============================================  
CREATE PROCEDURE [dbo].[usp_SaveExternalCoverage]   
 -- Add the parameters for the stored procedure here  
 @patientId bigint,
 @HolderId varchar(30),  
 @HolderFstName varchar(100),  
 @HolderMI varchar(50),  
 @HolderLstName varchar(100),  
 @InsPlanID varchar(30),  
 @InsGrpNumb varchar(50),  
 @FormularyID varchar(50),  
 @PlanName varchar(50),  
 @MemberNumber varchar(50),  
 @BinNumb varchar(150),
 @rxhubPBM varchar(15),
 @Address1 varchar(100),
 @Address2 varchar(100),
 @City varchar(50),
 @State varchar(50),
 @Zip varchar(50),
 @DOB date,
 @Sex varchar(1)
    
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
 delete from patients_coverage_info_external where pa_id = @patientId and rxhub_pbm_id like @rxhubPBM;
 
IF EXISTS(SELECT DG.DC_ID from patients PAT with(nolock)
	inner join doc_groups DG with(nolock) on PAT.dg_id = DG.DG_ID
	inner join doc_companies DC with(nolock) on DG.DC_id = DC.dc_id
	inner join partner_accounts PART with(nolock) on DC.partner_id = PART.partner_id
	where PAT.pa_id = @patientId AND PART.PARTNER_NAME like '%ENCLARA%'
 )
 BEGIN
	 Insert Into patients_coverage_info_external 
	  (pa_id,ic_group_numb,card_holder_id,card_holder_first,card_holder_mi,card_holder_last,
	  ic_plan_numb,formulary_id,pa_bin,rxhub_pbm_id,pbm_member_id,def_ins_id,formulary_type,add_date,
	  coverage_id,ic_plan_name,PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX,ss_pbm_name) 
	  values 
	  (@patientId,@InsGrpNumb,@HolderId,@HolderFstName,@HolderMI,@HolderLstName,@InsPlanID,'FRM001',
	  @BinNumb,@rxhubPBM,@MemberNumber,0,1,GETDATE(),
	  @FormularyID,@FormularyID,@Address1,@Address2,@City,@State,@Zip,@DOB,@Sex,@rxhubPBM)
END
ELSE
BEGIN
	Insert Into patients_coverage_info_external 
	  (pa_id,ic_group_numb,card_holder_id,card_holder_first,card_holder_mi,card_holder_last,
	  ic_plan_numb,formulary_id,pa_bin,rxhub_pbm_id,pbm_member_id,def_ins_id,formulary_type,add_date,
	  coverage_id,ic_plan_name,PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX,ss_pbm_name) 
	  values 
	  (@patientId,@InsGrpNumb,@HolderId,@HolderFstName,@HolderMI,@HolderLstName,@InsPlanID,@FormularyID,
	  @BinNumb,@rxhubPBM,@MemberNumber,0,1,GETDATE(),
	  @FormularyID,@FormularyID,@Address1,@Address2,@City,@State,@Zip,@DOB,@Sex,@rxhubPBM)
	DELETE patients_coverage_info  where pa_id = @patientId
	update patients set last_check_date=getdate()-2 where pa_id = @patientId
  END
  


   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
