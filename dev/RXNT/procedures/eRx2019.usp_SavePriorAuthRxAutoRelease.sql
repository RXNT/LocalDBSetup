SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 12/11/2021
-- Description: Save Prior Auth Rx Auto Release
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SavePriorAuthRxAutoRelease]
@RxId BIGINT,
@RxDetailId BIGINT,
@APIResponseSuccess BIT,
@AuthorizationNumber VARCHAR(50)=NULL,
@PriorAuthorizationStatus VARCHAR(10)=NULL
AS  

  
  BEGIN
	DECLARE @CurrentTime DATETIME = GETDATE()
 
	UPDATE prescription_details SET prior_auth_number=ISNULL(@AuthorizationNumber,prior_auth_number),prior_authorization_status=ISNULL(@PriorAuthorizationStatus,prior_authorization_status)
	WHERE pd_id=@RxDetailId AND pres_id=@RxId
	IF NOT EXISTS(SELECT * FROM prescription_tasks_auto_release WITH(NOLOCK) WHERE pd_id=@RxDetailId AND pres_id=@RxId)
	BEGIN
		INSERT INTO prescription_tasks_auto_release( pd_id, pres_id,performed_on,api_response_success)
		VALUES(@RxDetailId,@RxId,@CurrentTime, @APIResponseSuccess)
	END
	ELSE
	BEGIN
		UPDATE prescription_tasks_auto_release  SET performed_on=@CurrentTime,api_response_success=@APIResponseSuccess
		WHERE pd_id=@RxDetailId AND pres_id=@RxId
	END
	UPDATE prescriptions SET pres_approved_date=@CurrentTime WHERE pres_id=@RxId
	IF @PriorAuthorizationStatus='A' -- Approved
	BEGIN
		DECLARE @PrescriptionType TINYINT
		DECLARE @pa_id BIGINT
		DECLARE @dr_id BIGINT
		DECLARE @drug_id BIGINT
		DECLARE @added_by_dr_id BIGINT
		DECLARE @compound BIT
		DECLARE @dosage VARCHAR(1000)
		DECLARE @drug_name VARCHAR(150)
		DECLARE @duration_amount VARCHAR(15)
		DECLARE @duration_unit VARCHAR(80)
		DECLARE @comments VARCHAR(255)
		DECLARE @numb_refills INT
		DECLARE @use_generic BIT
		DECLARE @days_supply INT
		DECLARE @prn BIT
		DECLARE @prn_description VARCHAR(50)
		DECLARE @order_reason VARCHAR(500)
		DECLARE @pres_start_date DATETIME
		DECLARE @pres_end_date DATETIME
		SELECT @PrescriptionType=b.pres_prescription_type,@pa_id=b.pa_id,@drug_id=A.ddid
		,@added_by_dr_id=B.prim_dr_id,@compound=A.compound,@dosage=A.dosage
		,@duration_amount=A.duration_amount
		,@drug_name=A.drug_name
		,@duration_unit=A.duration_unit
		,@comments=A.comments
		,@numb_refills=A.numb_refills
		,@use_generic = A.use_generic
		,@days_supply=A.days_supply
		,@prn=A.prn
		,@prn_description=A.prn_description
		,@pres_start_date=ISNULL(B.pres_start_date,CAST('01/01/1901' AS DATETIME))
		,@pres_end_date=ISNULL(B.pres_end_date,CAST('01/01/1901' AS DATETIME))
		,@order_reason=A.order_reason
		,@dr_id=B.dr_id
		FROM  prescription_details A WITH (NOLOCK) 
		INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
		WHERE B.pres_id=@RxId AND A.pd_id=@RxDetailId

		--Add Active Med Start
		DELETE FROM patient_active_meds WHERE pa_id=@pa_id  and drug_id = @drug_id
		INSERT INTO [dbo].[patient_active_meds] ([pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description], [date_start], [date_end], [for_dr_id], [order_reason]) 
		VALUES (@pa_id, @drug_id, @CurrentTime, @added_by_dr_id, @RxDetailId, @compound, Left('', 255), 0, NULL, NULL, left('', 150), ISNULL(@drug_name, ' '), left(@dosage, 255), @duration_amount, @duration_unit, left(@comments,255), @numb_refills, @use_generic, @days_supply, @prn, left(@prn_description,50), @pres_start_date, @pres_end_date, @dr_id, @order_reason)
		--Add Active Med End
		INSERT INTO [dbo].[patient_measure_compliance] ([pa_id] ,[dr_id],[src_dr_id],[rec_type],[rec_date]) VALUES (@pa_id, @dr_id, @dr_id, 7 /*enPatientActiveMeds*/, @CurrentTime)
		--Transmit the prescription start
		EXEC insertPrescriptionTransmittal @PDID=@RxId,@DeliveryMethod=262144, @TransFlags=0, @PrescType=@PrescriptionType, @QueuedDate=@CurrentTime, @ForceSend=1
		--Transmit the prescription end
	END
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
