SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
      
CREATE   PROCEDURE [support].[usp_CreateDummyRxPharmacyRequestsCompanyLevel] -- [support].[usp_CreateDummyRxPharmacyRequestsCompanyLevel] @dc_ids = '2824',@NoOfRefillRequestsRequired=1
@dc_ids VARCHAR(MAX)=NULL,
@NoOfRefillRequestsRequired INT = 1
AS
BEGIN 
	
	DECLARE @xml XML  
	SET @xml = N'<t>' + REPLACE(@dc_ids,',','</t><t>') + '</t>'  
	DECLARE @dc_id BIGINT
	DECLARE @dr_username VARCHAR(50)
	DECLARE db_cursor_cmp CURSOR FOR 
	SELECT dc.dc_id, dr.dr_username
	FROM doc_companies dc WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dc.dc_id = dg.dc_id
	INNER JOIN doctors dr WITH(NOLOCK) ON dg.dg_id = dr.dg_id
	INNER JOIN  @xml.nodes('/t') as records(r)  ON RTRIM(LTRIM(r.value('.','NVARCHAR(MAX)'))) = dc.dc_id 
	WHERE dr.dr_enabled = 1 AND dr.prescribing_authority>2
	ORDER BY dc.dc_id DESC
	OPEN db_cursor_cmp  
	FETCH NEXT FROM db_cursor_cmp INTO @dc_id,@dr_username  

	WHILE @@FETCH_STATUS = 0  
	BEGIN   
		EXEC [support].[usp_CreateDummyRxPharmacyRequests] @Username = @dr_username, @NoOfRefillRequestsRequired = @NoOfRefillRequestsRequired
		FETCH NEXT FROM db_cursor_cmp INTO @dc_id,@dr_username
	END 

	CLOSE db_cursor_cmp  
	DEALLOCATE db_cursor_cmp 
END

                           
                        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
