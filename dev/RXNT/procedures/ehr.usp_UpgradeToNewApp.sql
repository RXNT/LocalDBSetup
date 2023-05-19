SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 21-Sep-2016
-- Description:	To Upgrade new app
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpgradeToNewApp]
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@DashboardVersion BIGINT OUTPUT,
	@EncounterVersion VARCHAR(MAX),
	@MenuList XML
AS
BEGIN
	
	DECLARE @PageCode VARCHAR(MAX),
			@Enable BIT;
	
		DECLARE PNCursor CURSOR LOCAL FAST_FORWARD FOR
				SELECT  A.S.value('(key)[1]', 'VARCHAR(MAX)') AS 'PageCode',
						A.S.value('(value)[1]', 'BIT') AS 'Enable'
				FROM @MenuList.nodes('ArrayOfConstantKeyValues/ConstantKeyValues') A(S);
	OPEN PNCursor
		FETCH NEXT FROM PNCursor into @PageCode, @Enable
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			DECLARE @MasterId INT, @SortOrder INT;
			select @MasterId = master_patient_menu_id, @SortOrder = sort_order from master_patient_menu with(nolock) where code = @PageCode
			
			IF NOT EXISTS (select 1 from patient_menu with(nolock) where master_patient_menu_id = @MasterId and dc_id = @DoctorCompanyId)
			BEGIN
				INSERT INTO patient_menu
				(master_patient_menu_id, dc_id, is_show, created_date, created_by, sort_order, active)
				values
				(@MasterId, @DoctorCompanyId, @Enable, GETDATE(), @LoggedInUserId, @SortOrder, 1)
				print 'new' ;
			END
			ELSE
			BEGIN
				UPDATE patient_menu
				SET is_show = @Enable,
					modified_date = GETDATE(),
					modified_by = @LoggedInUserId,
					active = 1
				where master_patient_menu_id = @MasterId and dc_id = @DoctorCompanyId
				print  'updated';
			END
			FETCH NEXT FROM PNCursor into @PageCode, @Enable
		END
	CLOSE PNCursor
	DEALLOCATE PNCursor
		
	--UPDATE doctor_info
	--SET is_custom_tester = @DashboardVersion,
	--	encounter_version = @EncounterVersion
	--WHERE dr_id = @LoggedInUserId
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester ^ 1
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 1) = 1
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester | 4
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 4) <> 4
	
	UPDATE doctor_info
	SET is_custom_tester = is_custom_tester | 8
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	AND (is_custom_tester & 8) <> 8
	
	UPDATE doctor_info
	SET encounter_version = 'v1.1'
	WHERE 1 = 1
	AND dr_id = @LoggedInUserId
	
	SELECT @DashboardVersion = is_custom_tester from doctor_info where dr_id = @LoggedInUserId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
