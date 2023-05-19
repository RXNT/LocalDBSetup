SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SaveRxHubVitasFormVxform]
AS
BEGIN
	IF NOT EXISTS 
	(
		SELECT * FROM Formularies.sys.tables WHERE name = 'RxHub_VITAS_FORM_VXFORM'
	)
	BEGIN
		DECLARE @sqlString VARCHAR(MAX);
		SET	@sqlString = 
		'CREATE TABLE [FORMULARIES].[dbo].[RxHub_VITAS_FORM_VXFORM] 
			( id INT IDENTITY NOT FOR REPLICATION NOT NULL,
				source_ndc VARCHAR(11),
				form_status int,
				rel_value int,
				Text VARCHAR(200),
				GCN VARCHAR(20) 
			)';
		EXEC (@SQLString)
	END
		
		TRUNCATE TABLE Formularies.[dbo].[RxHub_VITAS_FORM_VXFORM];
		
		INSERT INTO Formularies.[dbo].[RxHub_VITAS_FORM_VXFORM]
			(source_ndc, form_status, rel_value, GCN)
		select distinct
		'-1' NDC,
		case when FG.preferred_status like 'PREFERRED' Then 2 ELSE 1 END form_status, 
		-1,
		RM.gcn_string
		from RxNTReportUtils.dbo.vitas_formulary_master_list_temp FG with(nolock)
		inner join FDB..RMIID1 RM with(nolock) on FG.gcn_c = RM.gcn_string
		--
		--left outer join
		--(
		--	select RM.medid medid, MAX(ndc) NDC from 
		--		FDB..RMIID1 RM with(nolock) 
		--		inner join FDB..RNMMIDNDC RMI with(nolock)  on RM.MEDID = RMI.MEDID
		--		WHERE 
		--			1 = 1
		--			--AND MED_REF_GEN_DRUG_NAME_CD  <> 2
		--		--group by RM.GCN_SEQNO,RM.medid
		--		group by RM.medid
		--) RM2 on RM.medid = RM2.medid
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
