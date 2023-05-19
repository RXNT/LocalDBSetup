SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji Jogi>
-- Create date: <2017-07-14>
-- Description:	<Update prescription and signature>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateSignAndPrescription] 
	-- Add the parameters for the stored procedure here
	@PrescriptionId int,
	@DeliveryMethod int,
	@PharmacyId int,
	@DoctorId int,
	@PrimaryDoctorId int,
	@AuthorizingDoctorId int,
	@IsSigned bit,
	@PrintingOptions int,
	@PresApprovedDate datetime,
	@PresStartDate datetime,
	@PresEndDate datetime,
	@IsVoid bit,
	@IsPendingRx bit,
	@pd_id int,
	@pa_id int,
	@pa_first varchar(50),
	@pa_middle varchar(50),
	@pa_last varchar(50),
	@pa_dob datetime,
	@pa_gender varchar(1),
	@pa_address1 varchar(100),
	@pa_address2 varchar(100),
	@pa_city varchar(50),
	@pa_state varchar(2),
	@pa_zip varchar(20),
	@dg_id int,
	@dr_first_name varchar(50),
	@dr_middle_initial varchar(10),
	@dr_last_name varchar(50),
	@dr_address1 varchar(100),
	@dr_address2 varchar(100),
	@dr_city varchar(30),
	@dr_state varchar(50),
	@dr_zip varchar(20),
	@dr_dea_numb varchar(30),
	@ddid int,
	@drug_name varchar(125),
	@dosage varchar(255),
	@qty varchar(20),
	@units varchar(50),
	@days_supply int,
	@refills int,
	@approved_date datetime,
	@signature varchar(max),
	@OverridePrimDoctor bit,
	@IsSignAndAprove bit,
	@pres_src tinyint = 0,
	@IsSuccess bit OUTPUT
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @IsAproveSigned bit;
    -- Insert statements for procedure here
	BEGIN TRY
		BEGIN TRANSACTION 
		
		if @IsPendingRx=1 --update pending Rx
			Begin
				UPDATE prescriptions SET  pres_delivery_method =@DeliveryMethod ,pharm_id =@PharmacyId, dr_id =@DoctorId , last_edit_dr_id =@PrimaryDoctorId, prim_dr_id =CASE WHEN @OverridePrimDoctor=1 THEN @PrimaryDoctorId ELSE prim_dr_id END, authorizing_dr_id =@AuthorizingDoctorId ,
				is_signed =@IsSigned , print_options = @PrintingOptions, pres_approved_date =@PresApprovedDate, pres_start_date =@PresStartDate , pres_end_date = @PresEndDate, pres_void = @IsVoid, presc_src = @pres_src
				WHERE PRES_ID =@PrescriptionId
			End
		Else
			Begin
				--Approved Prescription, only pharmacy change allowed
				UPDATE PRESCRIPTIONS SET PHARM_ID = @PharmacyId, 
				print_options = @PrintingOptions , 
				PRES_DELIVERY_METHOD = @DeliveryMethod  WHERE PRES_ID = @PrescriptionId

			ENd
			
		if @IsSignAndAprove=1
		Begin
			if @OverridePrimDoctor=0 And len(@signature)>50
				Begin
					INSERT INTO [dbo].[scheduled_rx_archive] ([pres_id],[pd_id],[pa_id],[pa_first],[pa_middle],[pa_last],[pa_dob],[pa_gender],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip],[dr_id],[dg_id],[dr_first_name],[dr_middle_initial],[dr_last_name],[dr_address1],[dr_address2],[dr_city],[dr_state],[dr_zip],[dr_dea_numb],[ddid],[drug_name],[dosage],[qty],[units],[days_supply],[refills],[approved_date],[signature]) 
					values (@PrescriptionId, @pd_id, @pa_id, @pa_first, @pa_middle, @pa_last, @pa_dob, @pa_gender, @pa_address1, @pa_address2, @pa_city, @pa_state, @pa_zip, @DoctorId, @dg_id, @dr_first_name, @dr_middle_initial, @dr_last_name, @dr_address1, @dr_address2, @dr_city, @dr_state, @dr_zip, @dr_dea_numb, @ddid, @drug_name, @dosage, @qty, @units, @days_supply, @refills, @approved_date, @signature)
					
					set @IsAproveSigned=1;
				End
			else
				Begin
					set @IsAproveSigned=0;
				End
						
			if @OverridePrimDoctor=1
				Begin
					UPDATE prescriptions SET is_signed =@IsAproveSigned  , pres_approved_date = getdate()  , prim_dr_id = @PrimaryDoctorId , last_edit_dr_id =@PrimaryDoctorId , last_edit_date = getdate() WHERE pres_id = @PrescriptionId
				ENd
				
			else
				Begin
					UPDATE prescriptions SET is_signed =@IsAproveSigned  , pres_approved_date = getdate()  , last_edit_dr_id =@PrimaryDoctorId , last_edit_date = getdate() WHERE pres_id = @PrescriptionId
				End
		End
		
		Set @IsSuccess=1;	
		
		COMMIT
	  
	END  TRY
	
	BEGIN CATCH
		ROLLBACK -- Rollback TRANSACTION
		Set @IsSuccess=0;	
		
		DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','UpdateSignAndPrescription','PrescriptionId:'+CONVERT(VARCHAR(500),@PrescriptionId),ERROR_LINE ())				   
	END CATCH
	
	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
