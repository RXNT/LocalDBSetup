SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 28-Jan-2019
-- Description: Save Patient Lab Order
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[SavePatientLabOrderTest]
		
		@PatientLabId  As BIGINT = 0, 
		@LabMasterId  As BIGINT = 0, 
        @PatientId BIGINT,
        @LabTestId BIGINT,
        @LabTestName VARCHAR(MAX), 
        @LabTestType INT  , 
        @AddedDate DATETIME=NULL,
        @OrderDate DATETIME=NULL   ,  
        @SpecimenTime DATETIME=NULL   ,  
        @OrderStatus INT   ,   
        @Comments VARCHAR(MAX),  
        @LastEditBy INT,
        @LastEditDate DATETIME=NULL  ,
        @FromMainLabId INT,
        @RecurringInformation VARCHAR(MAX),   
        @DiagnosisText VARCHAR(MAX),   
        @Urgency VARCHAR(MAX), 
        @DoctorId BIGINT,
        @IsActive BIT ,
        @return  VARCHAR(MAX)  OUTPUT
	
AS
BEGIN			
	IF ISNULL(@PatientLabId,0) = 0
		BEGIN
			INSERT INTO patient_lab_orders( lab_master_id, pa_id, lab_test_id, lab_test_name,test_type,
			added_date, order_date, specimen_time,order_status, comments, last_edit_by,last_edit_date,
			 from_main_lab_id, recurringinformation, diagnosis, urgency, dr_id, isActive)
			VALUES(@LabMasterId, @PatientId, @LabTestId, @LabTestName, @LabTestType,
           @AddedDate, @OrderDate,@SpecimenTime, @OrderStatus, @Comments, 
           @LastEditBy,GETDATE(), @FromMainLabId, @RecurringInformation,
            @DiagnosisText, @Urgency, @DoctorId, @IsActive
            )
            SET @return = 'INTSERT';
		END
	ELSE
		BEGIN
			UPDATE patient_lab_orders SET  
					comments=@Comments,dr_id=@DoctorId ,lab_test_id=@LabTestId,lab_test_name=@LabTestName,
					test_type=@LabTestType,diagnosis=@DiagnosisText,order_date=@OrderDate,
					order_status=@OrderStatus,urgency=@Urgency 
					WHERE lab_master_id=@LabMasterId AND pa_lab_id=@PatientLabId 
					 SET @return = 'UPDATE';
		END			        
END       
         
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
