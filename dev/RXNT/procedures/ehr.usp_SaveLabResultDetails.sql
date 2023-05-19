SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 13-Sep-2016
-- Description:	To save lab result details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SaveLabResultDetails]
	@LabResultInfoId INT,
	@ValueType TINYINT,
	@ObservationIdentifier VARCHAR(3000),
	@TestName VARCHAR(1000),
	@CodingSystem VARCHAR(100),
	@Value VARCHAR(MAX),
	@Unit VARCHAR(100),
	@Range VARCHAR(500),
	@AbnormalFlags SMALLINT,
	@Status SMALLINT,
	@ObservationDate DATETIME,
	@ProducerIdentifier VARCHAR(500),
	@Notes VARCHAR(MAX),
	@HasEmbeddedData BIT,
	@FileName VARCHAR(500),
	@FileUploadedCategoryId INT
AS
BEGIN
	INSERT INTO lab_result_details
	(lab_result_info_id, value_type, obs_ident, obs_text, obs_cod_sys, obs_value, coding_unit_ident,
	ref_range, abnormal_flags, obs_result_status, dt_last_change, obs_date_time, prod_id, notes, has_embedded_data, file_name, file_uploaded_category_id, file_uploaded_dt)
	VALUES 
	(@LabResultInfoId, @ValueType, @ObservationIdentifier, @TestName, @CodingSystem, @Value, @Unit,
	@Range, @AbnormalFlags, @AbnormalFlags, GETDATE(), @ObservationDate, @ProducerIdentifier, @Notes, @HasEmbeddedData, @FileName, @FileUploadedCategoryId, GETDATE())

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
