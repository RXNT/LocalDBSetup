SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	To get the custom encounter model information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetCustomEncounterFormByModelId]
	@ModelId BIGINT,
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT TOP 1 1 
       FROM[encounter_form_settings] a WITH(NOLOCK) 
       INNER JOIN encounter_model_definitions b  WITH(NOLOCK) ON a.type = b.type 
       WHERE a.dr_id = @DoctorId AND b.model_defn_id = @ModelId) 
    BEGIN
       SELECT et.enc_lst_id,et.enc_name,et.enc_type,et.speciality 
       FROM encounter_types et
       INNER JOIN encounter_model_definitions emd ON et.enc_type = emd.type 
       WHERE emd.model_defn_id = @ModelId
	END
	ELSE
	BEGIN
		SELECT a.enc_type_id AS enc_lst_id,a.name enc_name, a.type enc_type
		FROM[encounter_form_settings] a WITH(NOLOCK)
		INNER JOIN encounter_model_definitions b  WITH(NOLOCK) ON a.type = b.type 
		WHERE a.dr_id = @DoctorId AND b.model_defn_id =  @ModelId
    END
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
