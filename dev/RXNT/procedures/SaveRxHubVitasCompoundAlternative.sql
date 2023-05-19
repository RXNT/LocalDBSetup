SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SaveRxHubVitasCompoundAlternative]
AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(50);  
	DECLARE @SourceNDC VARCHAR(10)
	DECLARE @AlternateNDC VARCHAR(10)
	
	DECLARE @gcn_c VARCHAR(50)
	DECLARE @generic VARCHAR(50)
	DECLARE @alt_gcn VARCHAR(50)
	
	DECLARE @last_gcn_c VARCHAR(50) 
	DECLARE @last_generic VARCHAR(50) 
	
	IF NOT EXISTS (SELECT * FROM Formularies.sys.tables WHERE name = 'RxHub_VITAS_ALT_VXALT')
	BEGIN
		DECLARE @sqlString VARCHAR(MAX);
		SET	@sqlString = 'CREATE TABLE Formularies.[dbo].[RxHub_VITAS_ALT_VXALT] 
		( id INT IDENTITY(1,1) primary key,source_ndc VARCHAR(11),
		alternate_ndc varchar(11), 
		source_gcn varchar(10),
		alt_gcn varchar(10),
		form_status int,
		rel_value int,Text VARCHAR(200) )';
		EXEC (@SQLString)
	END 
	
	--TRUNCATE TABLE Formularies.[dbo].[RxHub_VITAS_ALT_VXALT];		
	DECLARE vendor_cursor CURSOR FOR   
	-- SELECT * FROM vitas_formulary_alternative_list_temp
	-- SELECT * FROM Formularies.[dbo].[RxHub_VITAS_ALT_VXALT];
	SELECT gcn_c,generic,alt_gcn FROM RxNTReportUtils..vitas_formulary_alternative_compound_temp
	OPEN vendor_cursor  
	FETCH NEXT FROM vendor_cursor INTO @gcn_c,@generic,@alt_gcn
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
			IF LEN(@gcn_c)>0
			BEGIN 
				--IF @generic = '(COMPOUND)' 
				--BEGIN
				--	SET @last_gcn_c = ''
				--END
				--ELSE
				--BEGIN 
					SET @last_gcn_c = @gcn_c
				--END
			END
			ELSE IF LEN(@last_gcn_c)>0 AND LEN(@alt_gcn)>0
			BEGIN
				select @SourceNDC = MAX(ndc)  
					from 
						FDB..RMIID1 RM WITH(NOLOCK)
						inner join FDB..rnmmidndc RMI with(nolock)  on RM.MEDID = RMI.MEDID
					WHERE 
					1 = 1
					AND GCN_STRING LIKE @last_gcn_c
					--AND MED_REF_GEN_DRUG_NAME_CD  <> 2
					group by RM.medid
					
				
					select @AlternateNDC = MAX(ndc)  
					from 
						FDB..RMIID1 RM with(nolock)
						inner join FDB..rnmmidndc RMI with(nolock)  on RM.MEDID = RMI.MEDID
					WHERE 
					1 = 1
					AND GCN_STRING LIKE @alt_gcn
					AND MED_REF_GEN_DRUG_NAME_CD  IN (1,4) -- Generic
					group by RM.GCN_SEQNO,RM.medid
					
					
					IF LEN(@last_gcn_c)>0 AND LEN(@alt_gcn)>0
					BEGIN
						INSERT INTO Formularies.[dbo].[RxHub_VITAS_ALT_VXALT]
						(source_ndc, alternate_ndc, form_status, rel_value,source_gcn,alt_gcn)
						VALUES(@SourceNDC,@AlternateNDC,2,-1,@last_gcn_c,@alt_gcn)
					END
					ELSE
					BEGIN
						IF LEN(ISNULL(@SourceNDC,''))=0 
						BEGIN
							SET @ErrorMessage = N'Source NDC not found for the GCN - ' +@last_gcn_c;  
							RAISERROR (@ErrorMessage, -- Message text.  
							   10, -- Severity,  
							   1, -- State,  
							   N'abcde'); 
						END
						
						IF LEN(ISNULL(@AlternateNDC,''))=0
						BEGIN
							SET @ErrorMessage = N'Alternate NDC not found for the GCN - ' +@alt_gcn;  
							RAISERROR (@ErrorMessage, -- Message text.  
							   10, -- Severity,  
							   1, -- State,  
							   N'abcde'); 
						END
					END
				
			END
			FETCH NEXT FROM vendor_cursor  INTO @gcn_c,@generic,@alt_gcn
	END   
	CLOSE vendor_cursor;  
	DEALLOCATE vendor_cursor;  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
