SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetDoctorDynamicPreference]	

@DoctorId bigint,
		@ColumnName	nvarchar(50)
	AS 
	BEGIN
	   Select @DoctorId,@ColumnName
	   Declare @sql nvarchar(MAX)
	   DECLARE @ParmDefinition nvarchar(500)
	   SET @ParmDefinition = N'@DoctorId bigint';
	   
	   Set @sql = N'SELECT ' + @ColumnName + '  FROM doctor_info  WHERE dr_id = 6;'
	   
	  EXEC sp_executesql @sql, 
              N'@ColumnName NVARCHAR(20)',
              @ColumnName = 'show_encounter_forms_sort_message'


   
	END

	--SELECT show_encounter_forms_sort_message  FROM doctor_info 
	--SELECT  COALESCE('jahabar-yuyy', ',')

--
	EXEC  [dbo].[usp_GetDoctorDynamicPreference]  6, 'dr_dea_address1'
	
   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
