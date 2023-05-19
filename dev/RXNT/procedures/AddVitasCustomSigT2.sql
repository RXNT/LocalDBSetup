SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Ramakrishna
-- Create date	: 2016/11/Jan
-- Description	: Add vitas custom sig
-- =============================================
CREATE PROCEDURE [dbo].[AddVitasCustomSigT2]
	 @DoctorId		BIGINT, -- 78038
	 @DoctorGroupId BIGINT -- 63104
AS
BEGIN

	DECLARE @GCN varchar(50)
	DECLARE @Generic varchar(50)
	DECLARE @Medication varchar(50)
	DECLARE @Strength varchar(50)
	DECLARE @Form varchar(50)
	DECLARE @CustomSig varchar(250)
	DECLARE @Action varchar(150)
	DECLARE @Quantity varchar(50)
	DECLARE @Formulation varchar(150)
	DECLARE @Route varchar(50)
	DECLARE @Frequency varchar(50)
	DECLARE @FrequencyTranslation varchar(150)	
	DECLARE @DrugId BIGINT
	DECLARE @ScriptId BIGINT
	
	DECLARE structure_sig_cursor CURSOR FOR  
	SELECT GCN,Generic,medication,strength,form,[Custom Sig],[Action],Quantity,
		Formulation,Route,Frequency,FreqTranslation 
	FROM RxNTReportUtils.dbo.Vitas_CustomSig_Temp 
	OPEN structure_sig_cursor   
	FETCH NEXT FROM structure_sig_cursor INTO @GCN,@Generic,@Medication,@Strength,@Form,@CustomSig,
	@Action,@Quantity,@Formulation,@Route,@Frequency,@FrequencyTranslation 	
	WHILE @@FETCH_STATUS = 0   
	BEGIN   	
		IF LEN(@GCN)>0 AND @DoctorGroupId>0
		BEGIN 
			create table #temp(medid int)
			insert into #temp
			select distinct RM.MEDID  
			from FDB..RMIID1 RM with(nolock) 
			WHERE 1 = 1 
				AND GCN_STRING LIKE @GCN		
			
			--select TOP 1 @DrugId =RM.MEDID  
			--from FDB..RGCN0 RG with(nolock)
			--	inner join FDB..RMIID1 RM with(nolock) on RG.GCN_SEQNO = RM.GCN_SEQNO
			--	--inner join FDB..rnmmidndc RMI with(nolock)  on RM.MEDID = RMI.MEDID
			--WHERE 1 = 1 AND cast(GCN as varchar(50)) LIKE @GCN			
			--group by RM.GCN_SEQNO,RM.medid
			DECLARE @RowCount INT
	
			SET @RowCount = (SELECT COUNT(medid) FROM #temp) 

			-- Declare an iterator
			DECLARE @I INT
			-- Initialize the iterator
			SET @I = 1

			-- Loop through the rows of a table @myTable
			WHILE (@I <= @RowCount)
			BEGIN
				-- Declare variables to hold the data which we get after looping each record 
				--DECLARE @DrugId int 	
					-- Get the data from table and set to variables
				SELECT TOP 1 @DrugId = medid FROM #temp
				-- Display the looped data
				PRINT 'ID = ' + CONVERT(VARCHAR(20), @DrugId)
				IF LEN(@DrugId)>0
			BEGIN 
				SET @ScriptId=0
				INSERT INTO [dbo].[doc_group_fav_scripts] 
				(dr_id,dg_id,ddid,dosage,use_generic,numb_refills,
					duration_unit,duration_amount,comments,prn,as_directed,
					update_code,drug_version,compound,days_supply
				)
				values (@DoctorId,@DoctorGroupId,@DrugId,@CustomSig,1,0,@Formulation,
					@Quantity,'', 0, 0,NULL,'FDB1.1',0,NULL
				) 
				SET @ScriptId= SCOPE_IDENTITY()
				
				IF @ScriptId>0 AND NOT EXISTS
					(SELECT TOP 1 1  FROM [dbo].[doc_group_fav_scripts_sig_details] with(nolock)
						WHERE script_id=@ScriptId
					)
				BEGIN
					INSERT INTO [dbo].[doc_group_fav_scripts_sig_details] 
					(script_id,sig_sequence_number,sig_action,sig_qty,sig_form,
						sig_route,sig_time_qty,sig_time_option
					)
					values (@ScriptId,1,@Action,@Quantity, @Formulation, @Route, 
						@Frequency,@FrequencyTranslation) 
				END				
			END
				DELETE FROM #TEMP WHERE medid=@DrugId
				-- Increment the iterator
				SET @I = @I  + 1
			END
			DROP TABLE #temp
		END		
	FETCH NEXT FROM structure_sig_cursor   INTO @GCN,@Generic,@Medication,@Strength,@Form,@CustomSig,
	@Action,@Quantity,@Formulation,@Route,@Frequency,@FrequencyTranslation 	
	END  
	CLOSE structure_sig_cursor      
	DEALLOCATE structure_sig_cursor
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
