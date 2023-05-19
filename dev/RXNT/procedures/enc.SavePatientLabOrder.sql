SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 28-Jan-2019
-- Description: Save Patient Lab Order Test
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [enc].[SavePatientLabOrder]
		
		
		@LabMasterId  As BIGINT = 0 OUTPUT, 
        @PatientId BIGINT,
        @AddedDate DATETIME=NULL,
        @AddedBy INT  ,     
        @OrderDate DATETIME=NULL   ,   
        @OrderStatus INT   ,   
        @Comments VARCHAR(MAX),    
        @DoctorId BIGINT,
        @IsActive BIT,
        @LastEditBy INT,
        @LastEditDate DATETIME=NULL   
	
AS
BEGIN

	IF ISNULL(@LabMasterId,0) = 0
		BEGIN
			INSERT INTO patient_lab_orders_master( pa_id , added_date, added_by, order_date, order_status, comments,
			dr_id, isActive, last_edit_by, last_edit_date) 
			VALUES( @PatientId , @AddedDate, @AddedBy, @OrderDate, 0, @Comments, @DoctorId, @IsActive,@LastEditBy, @LastEditDate) ;
			SET @LabMasterId = SCOPE_IDENTITY();
		END
	ELSE
		BEGIN
			UPDATE patient_lab_orders_master SET  
			comments=@Comments,order_status=@OrderStatus
			WHERE lab_master_id=@LabMasterId 
		END		 
END                          
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
