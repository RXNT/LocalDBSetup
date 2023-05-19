SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	07-Jul-2015
Description			:	This procedure is used to insert any new lab order compendiums provided by scalabull
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE   PROCEDURE [dbo].[UpdateNewScalabullLabResources]	
AS
BEGIN
	--lab_test_lists start
	INSERT INTO lab_test_lists (
		lab_test_name,
		active,test_type,
		loinc_code,code_type,
		lab_test_name_long) 
	SELECT DISTINCT 
		partner_test_short_name,
		1,
		0,
		ISNULL(t.loinc_code,''),
		'LOINC',
		partner_test_long_name
	FROM RxNTReportUtils..[lab_partner_tests_temp] t 
	LEFT OUTER JOIN lab_test_lists m ON		m.lab_test_name = t.partner_test_short_name AND 
											m.test_type		= 0 AND 
											ISNULL(m.loinc_code,'') = ISNULL(t.loinc_code,'') AND
											m.code_type		= 'LOINC'
	WHERE m.lab_test_id IS NULL    

	--UPDATE m SET m.active=1 
	--FROM lab_test_lists m 
	--INNER JOIN RxNTReportUtils..[lab_partner_tests_temp] t  
	--		ON  m.lab_test_name	= t.partner_test_short_name AND 
	--			m.test_type		= 0 AND 
	--			m.code_type		= 'LOINC'
	--WHERE m.active!=1 
--lab_test_lists end                    

--lab_partner_tests start
	INSERT INTO [lab_partner_tests] (
		[external_lab_id],
		[partner_test_id],
		[partner_local_test_id],
		[partner_test_short_name],
		[partner_test_long_name],
		[lab_test_id],
		active,
		last_modified_by,
		last_modified_date,
		created_date,created_by) 
	SELECT t.external_lab_id,
		t.partner_test_id,
		t.partner_local_test_id,
		t.partner_test_short_name,
		t.partner_test_long_name,
		l.lab_test_id,
		1,
		1,
		GETDATE(),
		GETDATE(),
		1
	FROM RxNTReportUtils..[lab_partner_tests_temp] t
	LEFT OUTER JOIN [lab_partner_tests] m	
			ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_local_test_id	= t.partner_local_test_id AND
			m.partner_test_id		=	t.partner_test_id
	LEFT OUTER JOIN
		(	select lab_test_name,loinc_code,MAX(lab_test_id) lab_test_id from [lab_test_lists] where test_type = 0 AND
			code_type='LOINC' AND
			active=1
			group by lab_test_name,loinc_code
		) l	ON  l.lab_test_name	= t.partner_test_short_name AND ISNULL(l.loinc_code,'')=ISNULL(t.loinc_code,'')
	WHERE m.lab_partner_tests_id IS NULL
	
	UPDATE m 
	SET active=0
	FROM [lab_partner_tests] m	
	LEFT OUTER JOIN RxNTReportUtils..[lab_partner_tests_temp] t
			ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_local_test_id	= t.partner_local_test_id AND
			m.partner_test_id		=	t.partner_test_id
	WHERE m.active = 1 AND t.temp_id IS NULL
	 

--UPDATE m 
--	SET		m.partner_test_short_name	= t.partner_test_short_name,
--			m.partner_test_long_name	= t.partner_test_long_name,
--			m.last_modified_date = GETDATE(),
--			m.last_modified_by = 1
--	FROM RxNTReportUtils..[lab_partner_tests_temp] t
--	INNER JOIN [lab_partner_tests] m	
--			ON  m.external_lab_id	= t.external_lab_id AND 
--			m.partner_local_test_id	= t.partner_local_test_id AND
--			m.partner_test_id		=	t.partner_test_id
--	INNER JOIN [lab_test_lists] l	
--			ON  l.lab_test_name	= t.partner_test_short_name AND
--			l.test_type			= 0 AND
--			l.code_type			= 'LOINC' AND
--			l.active			= 1
	
-- lab_partner_tests end
-- lab_partner_test_info start

	
--UPDATE m
--	SET 
--		m.property_name = t.property_name,
--		m.comments = t.comments,
--		m.last_modified_date = GETDATE(),
--		m.last_modified_by = 1
--	FROM RxNTReportUtils..lab_partner_test_info_temp t
--	INNER JOIN lab_partner_test_info m  
--			ON  m.external_lab_id	= t.external_lab_id AND 
--			m.partner_test_id		= t.partner_test_id
	
	INSERT INTO [lab_partner_test_info] (
		[external_lab_id],
		[partner_test_id],
		[property_name],
		[comments],    
		active,
		last_modified_by,
		last_modified_date,
		created_date,created_by)
	SELECT 
		t.external_lab_id,
		t.partner_test_id, 
		t.property_name,
		t.comments,
		1,
		1,
		GETDATE(),
		GETDATE(),
		1 
	FROM RxNTReportUtils..lab_partner_test_info_temp t
	LEFT OUTER JOIN lab_partner_test_info m  
			ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_test_id		= t.partner_test_id
	WHERE m.test_info_id IS NULL
	

-- lab_partner_test_info end	
                                
-- lab_partner_aoes start

--UPDATE m
--	SET 
--		m.partner_aoe_type = t.partner_aoe_type,
--		m.partner_aoe_label = t.partner_aoe_label,                                           
--		m.partner_aoe_menu = t.partner_aoe_menu,
--		m.partner_aoe_radios = t.partner_aoe_radios,
--		m.last_modified_date = GETDATE(),
--		m.last_modified_by = 1
--	FROM RxNTReportUtils..lab_partner_aoes_temp t
--	INNER JOIN lab_partner_aoes m  
--			ON  m.external_lab_id	= t.external_lab_id AND 
--				m.partner_aoe_id	= t.partner_aoe_id
--	WHERE m.lab_partner_aoes_id IS NULL	
	
	INSERT INTO [lab_partner_aoes](
		[external_lab_id],
		[partner_aoe_id],
		[partner_aoe_type],
		[partner_aoe_label],
		[partner_aoe_menu],
		[partner_aoe_radios],
		[active],
		[last_modified_by],
		[last_modified_date],
		[created_date],
		[created_by])
	SELECT 
		t.external_lab_id,
		t.partner_aoe_id,
		t.partner_aoe_type,
		t.partner_aoe_label,                                           
		t.partner_aoe_menu,
		t.partner_aoe_radios,
		1,
		1,
		GETDATE(),
		GETDATE(),1
	FROM RxNTReportUtils..lab_partner_aoes_temp t
	LEFT OUTER JOIN lab_partner_aoes m  
			ON  m.external_lab_id	= t.external_lab_id AND 
				m.partner_aoe_id	= t.partner_aoe_id
	WHERE m.lab_partner_aoes_id IS NULL
	
	

-- lab_partner_aoes end

-- lab_partner_aoes_testlevel start

	INSERT INTO [lab_partner_aoes](
		[external_lab_id],
		[partner_aoe_id],
		[partner_aoe_type],
		[partner_aoe_label], 
		[partner_aoe_menu],
		[partner_aoe_radios],
		[active],
		[last_modified_by],
		[last_modified_date],
		[created_date],
		[created_by])   
	SELECT 
		t.external_lab_id,
		t.partner_aoe_id,
		t.partner_aoe_type,
		t.partner_aoe_label,                                           
		t.partner_aoe_menu,
		case when t.partner_aoe_radios is null then '' else t.partner_aoe_radios end partner_aoe_radios,
		1,
		1,
		GETDATE(),
		GETDATE(),
		1
	FROM RxNTReportUtils..lab_partner_aoes_testlevel_temp t
	LEFT OUTER JOIN lab_partner_aoes m  
		ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_aoe_id	= t.partner_aoe_id
	WHERE m.lab_partner_aoes_id IS NULL

	INSERT INTO [lab_partner_aoes_testlevel] (
		[lab_partner_aoes_id],
		[external_lab_id],
		[partner_aoe_id],
		[partner_test_id],
		[active],
		[last_modified_by],
		[last_modified_date],
		[created_date],
		[created_by])
	SELECT	
		m.lab_partner_aoes_id,
		t.external_lab_id,
		t.partner_aoe_id,
		t.partner_test_id,
		1,
		1,
		GETDATE(),
		GETDATE(),
		1 
	FROM  RxNTReportUtils..lab_partner_aoes_testlevel_temp t
	INNER JOIN lab_partner_aoes  m  
		ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_aoe_id	= t.partner_aoe_id
	WHERE m.lab_partner_aoes_id IS NULL

	
	INSERT INTO [lab_partner_aoes_testlevel] (
		[lab_partner_aoes_id],
		[external_lab_id],
		[partner_aoe_id],
		[partner_test_id],
		[active],
		[last_modified_by],
		[last_modified_date],
		[created_date],
		[created_by])
	SELECT	
		m.lab_partner_aoes_id,
		t.external_lab_id,
		t.partner_aoe_id,
		t.partner_test_id,
		1,
		1,
		GETDATE(),
		GETDATE(),
		1 
	FROM  RxNTReportUtils..lab_partner_aoes_testlevel_temp t
	INNER JOIN lab_partner_aoes  m  
		ON  m.external_lab_id	= t.external_lab_id AND 
			m.partner_aoe_id	= t.partner_aoe_id
	left outer join [lab_partner_aoes_testlevel] L  
		ON  L.external_lab_id	= t.external_lab_id AND 
			L.partner_aoe_id	= t.partner_aoe_id  AND
			L.partner_test_id   = t.partner_test_id
	WHERE L.lab_partner_aoes_testlevel_id IS NULL
	
-- lab_partner_aoes_testlevel end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
