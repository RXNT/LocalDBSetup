SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Pradeep
-- Create date: 17-Mar-2021
-- Description:	To save the doctor fav procedure codes
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE   PROCEDURE [enc].[usp_SaveDoctorFavoriteProcedures2]
@DoctorId INT,
@Code VARCHAR(50),
@MaxRows INT = 5
AS

BEGIN
	SET NOCOUNT ON;
	SET @Code = LTRIM(RTRIM(@Code))
    
    -- Move current code to the "top"
    UPDATE [dbo].[doc_fav_procedure_codes]
    SET created_date = GETDATE()
    WHERE dr_id = @DoctorId 
      AND cpt_code = @Code
  
    -- If code isn't already in the MRU, we want to keep a total of @MaxRows AFTER THIS LATEST INSERT
	IF NOT EXISTS(SELECT  *  FROM [dbo].[doc_fav_procedure_codes]WITH(NOLOCK) WHERE dr_id=@DoctorId AND cpt_code=@Code)
	BEGIN

		INSERT INTO [dbo].[doc_fav_procedure_codes]
		(dr_id, cpt_code, created_date)
		VALUES(@DoctorId,  @Code, GETDATE())
	END

    
    -- Evict all but the @MaxRows oldest favorites
    DECLARE @CurrentCount BIGINT
    SELECT @CurrentCount=COUNT(*) FROM [dbo].[doc_fav_procedure_codes] WHERE dr_id=@DoctorId

    IF(ISNULL(@CurrentCount,0) >= @MaxRows)
    BEGIN
        WITH T
        AS (SELECT TOP ((@CurrentCount - @MaxRows))  *
            FROM  [dbo].[doc_fav_procedure_codes] a WITH(NOLOCK) WHERE dr_id=@DoctorId ORDER BY created_date ASC)
        DELETE FROM T 
    END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
