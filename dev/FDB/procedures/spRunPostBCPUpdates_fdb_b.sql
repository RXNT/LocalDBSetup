SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.spRunPostBCPUpdates_fdb_b
AS
BEGIN
	TRUNCATE TABLE fdb_b.RNMMIDNDC

	INSERT INTO fdb_b.RNMMIDNDC
	(
		NDC,
		OBSDTEC,
		LBLRID,
		GCN_SEQNO,
		LN,
		BN,
		DEA,
		GPI,
		OBC,
		REPACK,
		LN25,
		MEDID,
		MED_STRENGTH,
		MED_STRENGTH_UOM,
		MED_MEDID_DESC,
		MED_REF_DEA_CD,
		GENERIC_MEDID,
		ROUTED_DOSAGE_FORM_MED_ID,
		med_routed_df_med_id_desc,
		ROUTED_MED_ID,
		MED_ROUTED_MED_ID_DESC,
		MED_NAME_ID,
		MED_NAME,
		MED_NAME_TYPE_CD,
		MED_DOSAGE_FORM_ID,
		MED_DOSAGE_FORM_ABBR,
		MED_DOSAGE_FORM_DESC,
		MED_ROUTE_ID,
		MED_ROUTE_ABBR,
		MED_ROUTE_DESC,
		ETC_ID,
		ETC_NAME
	)
	SELECT DISTINCT A.NDC, A.OBSDTEC, A.LBLRID, A.GCN_SEQNO, A.LN, A.BN, A.DEA, A.GPI, A.OBC, A.REPACK,
	A.LN25, R.MEDID, R.MED_STRENGTH, R.MED_STRENGTH_UOM, R.MED_MEDID_DESC, R.MED_REF_DEA_CD, R.GENERIC_MEDID,
	R.ROUTED_DOSAGE_FORM_MED_ID, C.MED_ROUTED_DF_MED_ID_DESC, C.ROUTED_MED_ID, D.MED_ROUTED_MED_ID_DESC,
	E.MED_NAME_ID, E.MED_NAME, E.MED_NAME_TYPE_CD, C.MED_DOSAGE_FORM_ID,
	F.MED_DOSAGE_FORM_ABBR, F.MED_DOSAGE_FORM_DESC, G.MED_ROUTE_ID, G.MED_ROUTE_ABBR,
	G.MED_ROUTE_DESC, 0 ETC_ID, '' ETC_NAME 
	FROM fdb_b.RNDC14 A 
	INNER JOIN fdb_b.RMINDC1 B ON A.NDC = B.NDC 
	INNER JOIN fdb_b.RMIID1 R ON B.MEDID = R.MEDID
	INNER JOIN fdb_b.RMIDFID1 C ON R.ROUTED_DOSAGE_FORM_MED_ID = C.ROUTED_DOSAGE_FORM_MED_ID
	INNER JOIN fdb_b.RMIRMID1 D ON C.ROUTED_MED_ID = D.ROUTED_MED_ID
	INNER JOIN fdb_b.RMINMID1 E ON D.MED_NAME_ID = E.MED_NAME_ID
	INNER JOIN fdb_b.RMIDFD1 F ON C.MED_DOSAGE_FORM_ID = F.MED_DOSAGE_FORM_ID
	INNER JOIN fdb_b.RMIRTD1 G ON D.MED_ROUTE_ID = G.MED_ROUTE_ID
	WHERE A.OBSDTEC IS NULL 

	UPDATE fdb_b.RNMMIDNDC  
	SET RNMMIDNDC.ETC_ID = T.ETC_ID, RNMMIDNDC.ETC_NAME = T.ETC_NAME 
	FROM (
		SELECT Q.MEDID,  Q.ETC_ID, S.ETC_NAME 
		FROM (
			SELECT R.MEDID, MAX(I.ETC_ID) ETC_ID 
			FROM fdb_b.RMIID1 R 
			INNER JOIN fdb_b.RETCMED0 H ON R.MEDID = H.MEDID
			INNER JOIN fdb_b.RETCTBL0 I ON H.ETC_ID = I.ETC_ID 
			WHERE H.ETC_DEFAULT_USE_IND = 1
			GROUP BY R.MEDID
		) Q 
		INNER JOIN fdb_b.RETCTBL0 S ON Q.ETC_ID = S.ETC_ID
	) T
	WHERE RNMMIDNDC.MEDID = T.MEDID 

	UPDATE fdb_b.RNMMIDNDC SET REPACK = '0' WHERE REPACK = '1'

	UPDATE fdb_b.RNMMIDNDC 
	SET MED_MEDID_DESC = MED_NAME + ' ' + MED_STRENGTH + ' ' + MED_STRENGTH_UOM + ' ' + MED_DOSAGE_FORM_ABBR 
	WHERE MED_NAME LIKE 'metoprolol%'

	UPDATE fdb_b.RMIID1 SET MED_REF_GEN_COMP_PRICE_CD = MED_REF_GEN_DRUG_NAME_CD WHERE 1 = 1

	INSERT INTO fdb_b.RMIID1
	SELECT * FROM RxGlobalNew.dbo.RMIID1 
	WHERE EXISTS (
		SELECT OLD_MEDID 
		FROM dbo.unmatched_drugs
		WHERE OLD_MEDID = RMIID1.MEDID
	)
	AND NOT EXISTS (
		SELECT MEDID
		FROM fdb_b.RMIID1
		WHERE MEDID = RMIID1.MEDID
	)

	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC = a.MED_MEDID_DESC 
	FROM fdb_b.RNMMIDNDC a WHERE RMIID1.MEDID = a.MEDID 
	AND a.MED_NAME LIKE 'metoprolol%'

	UPDATE fdb_b.RMIID1 SET MED_STATUS_CD = 3 WHERE MEDID = 448245

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_NAME LIKE 'soma'

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MEDID IN (
		SELECT DISTINCT MEDID FROM fdb_b.RNMMIDNDC WHERE MED_NAME LIKE 'soma'
	)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 3 WHERE MED_MEDID_DESC LIKE 'Fioricet%'
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 3 WHERE MED_MEDID_DESC LIKE 'Fioricet%'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MEDID = 150853
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MEDID = 150853

	--Sudogest 30 mg tablet
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 3 WHERE MEDID = 207818
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 3 WHERE MEDID = 207818

	--Sudogest 60 mg tablet
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 3 WHERE MEDID = 296252
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 3 WHERE MEDID = 296252

	-- Esgic 50 mg-325 mg-40 mg capsule
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 229265
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 229265

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'tramadol%'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'tramadol%'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'ultram %'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'ultram %'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-325 mg-40 mg capsule'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-325 mg-40 mg capsule'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-325 mg-40 mg tablet'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-325 mg-40 mg tablet'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-300 mg-40 mg capsule'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'butalbital-acetaminophen-caffeine 50 mg-300 mg-40 mg capsule'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MED_MEDID_DESC LIKE 'Zyrtec-D 5 mg-120 mg tablet,extended release'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MED_MEDID_DESC LIKE 'Zyrtec-D 5 mg-120 mg tablet,extended release'

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MEDID = 183265
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MEDID = 183265

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MEDID = 261487
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MEDID = 261487

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MEDID = 475510
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MEDID = 475510

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'omnitrope %'
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 4 WHERE MED_MEDID_DESC LIKE 'omnitrope %' 

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 472756
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 472756

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 449050
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 449050

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 591179
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 591179

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 279935
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 279935

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 572978
	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 572978

	IF NOT EXISTS(SELECT 1 FROM fdb_b.RMIID1 WHERE MEDID = 999999)
	BEGIN
		INSERT INTO fdb_b.RMIID1 (MEDID, ROUTED_DOSAGE_FORM_MED_ID, MED_STRENGTH, MED_STRENGTH_UOM, MED_MEDID_DESC,
		GCN_SEQNO, MED_GCNSEQNO_ASSIGN_CD, MED_NAME_SOURCE_CD, MED_REF_FED_LEGEND_IND,MED_REF_DEA_CD,
		MED_REF_MULTI_SOURCE_CD, MED_REF_GEN_DRUG_NAME_CD, MED_REF_GEN_COMP_PRICE_CD,
		MED_REF_GEN_SPREAD_CD, MED_REF_INNOV_IND, MED_REF_GEN_THERA_EQU_CD, MED_REF_DESI_IND, MED_REF_DESI2_IND,
		MED_STATUS_CD, GENERIC_MEDID)
		VALUES (999999, 0, NULL, NULL, 'No Active Meds', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	END

	IF NOT EXISTS(SELECT 1 FROM fdb_b.RETCMED0 WHERE MEDID = 999999 AND ETC_ID = 2753)
	BEGIN
		INSERT INTO fdb_b.RETCMED0 (MEDID, ETC_ID, ETC_COMMON_USE_IND, ETC_DEFAULT_USE_IND)
		VALUES (999999, 2753, 1, 1)
	END

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC = 'Metrogel 1 % Topical Gel Pump' WHERE MEDID = 474502
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC = 'Metrogel 1 % Topical Gel Pump' WHERE MEDID = 474502

	IF NOT EXISTS(SELECT 1 FROM  fdb_b.RMIID1 WHERE MEDID = -1)
	BEGIN
		INSERT INTO fdb_b.RMIID1
					(MEDID
					,ROUTED_DOSAGE_FORM_MED_ID
					,MED_STRENGTH
					,MED_STRENGTH_UOM
					,MED_MEDID_DESC
					,GCN_SEQNO
					,MED_GCNSEQNO_ASSIGN_CD
					,MED_NAME_SOURCE_CD
					,MED_REF_FED_LEGEND_IND
					,MED_REF_DEA_CD
					,MED_REF_MULTI_SOURCE_CD
					,MED_REF_GEN_DRUG_NAME_CD
					,MED_REF_GEN_COMP_PRICE_CD
					,MED_REF_GEN_SPREAD_CD
					,MED_REF_INNOV_IND
					,MED_REF_GEN_THERA_EQU_CD
					,MED_REF_DESI_IND
					,MED_REF_DESI2_IND
					,MED_STATUS_CD
					,GENERIC_MEDID)
				VALUES
					(-1
					,0
					,NULL
					,NULL
					,'Free Text Medication'
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0
					,0)
	END

	IF NOT EXISTS(SELECT 1 FROM fdb_b.RETCMED0 WHERE MEDID = -1)
	BEGIN
		INSERT INTO fdb_b.RETCMED0 (
			MEDID
			,ETC_ID
			,ETC_COMMON_USE_IND
			,ETC_DEFAULT_USE_IND
		) VALUES (
			-1
			,2753
			,1
			,1
		)
	END

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='Morphine 30mg IR tablet' WHERE MEDID IN (235596)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='Morphine 30mg IR tablet' WHERE MEDID IN (235596)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='Morphine 15mg IR tablet' WHERE MEDID IN (282842)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='Morphine 15mg IR tablet' WHERE MEDID IN (282842)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='oxycodone 15 mg IR tablet' WHERE MEDID IN (211994)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='oxycodone 15 mg IR tablet' WHERE MEDID IN (211994)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='oxycodone 30 mg IR tablet' WHERE MEDID IN (272950)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='oxycodone 30 mg IR tablet' WHERE MEDID IN (272950)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='oxycodone 5 mg IR tablet' WHERE MEDID IN (298962)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='oxycodone 5 mg IR tablet' WHERE MEDID IN (298962)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='oxycodone 10 mg IR tablet' WHERE MEDID IN (554375)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='oxycodone 10 mg IR tablet' WHERE MEDID IN (554375)

	UPDATE fdb_b.RNMMIDNDC SET MED_MEDID_DESC='oxycodone 20 mg IR tablet' WHERE MEDID IN (554376)
	UPDATE fdb_b.RMIID1 SET MED_MEDID_DESC='oxycodone 20 mg IR tablet' WHERE MEDID IN (554376)

	INSERT INTO fdb_b.RNMMIDNDC (NDC,MEDID,MED_MEDID_DESC,MED_REF_DEA_CD,ROUTED_DOSAGE_FORM_MED_ID,med_routed_df_med_id_desc,ROUTED_MED_ID,MED_ROUTED_MED_ID_DESC,MED_NAME_ID,MED_NAME,MED_NAME_TYPE_CD,MED_DOSAGE_FORM_ID,MED_DOSAGE_FORM_ABBR,MED_DOSAGE_FORM_DESC,MED_ROUTE_ID,MED_ROUTE_ABBR,MED_ROUTE_DESC,ETC_ID)
	VALUES ('',999999,'No Active Meds',0,0,'No Active Meds',0,'No Active Meds',0,'No Active Meds','',0,'','',0,'','',0)

	UPDATE RM SET GCN_STRING = RG.GCN 
	FROM fdb_b.RMIID1 RM 
	INNER JOIN fdb_b.RGCN0 RG ON RM.GCN_SEQNO = RG.GCN_SEQNO
	WHERE 1 = 1

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 247230
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 247230

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN(162323, 187428, 197020 , 229421, 258949, 271154, 554511, 574742, 574743)

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN(162323, 187428, 197020 , 229421, 258949, 271154, 554511, 574742, 574743)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN(155629, 164059, 192149, 196133, 242690, 263989)

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN(155629, 164059, 192149, 196133, 242690, 263989)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN (247230,594369,188463,259028,452812)

	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 
	WHERE MEDID IN (247230,594369,188463,259028,452812)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID = 288226
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID = 288226

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (156741, 446351)
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (156741, 446351)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (224665, 434834)
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (224665, 434834)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (244365)
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (244365)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (451132, 569501)
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (451132, 569501)

	UPDATE fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (473583)
	UPDATE fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (473583)

	UPDATE  fdb_b.RMIID1 SET MED_REF_DEA_CD = 5 WHERE MEDID IN (291728,430988,259052,476487,564130, 197837)
	UPDATE  fdb_b.RNMMIDNDC SET MED_REF_DEA_CD = 5 WHERE MEDID IN (291728,430988,259052,476487,564130, 197837)

	UPDATE fdb_b.RNMMIDNDC SET OBSDTEC = GETDATE() WHERE MEDID = 999999 

	IF NOT EXISTS (SELECT * FROM fdb_b.RDAMAPM0 WHERE DAM_CONCEPT_ID_DESC = 'Fluoroquinolones')
	BEGIN
		INSERT INTO fdb_b.RDAMAPM0 (
			DAM_CONCEPT_ID, DAM_CONCEPT_ID_TYP, DAM_CONCEPT_ID_DESC
		) VALUES (
			900599, 1, 'Fluoroquinolones'
		)
	END

	TRUNCATE TABLE fdb_b.REVDEL0_Active_Med

	INSERT INTO fdb_b.REVDEL0_Active_Med (EVD_EXT_VOCAB_ID, EVD_FDB_VOCAB_ID)
	SELECT MAX(EVD_EXT_VOCAB_ID) EVD_EXT_VOCAB_ID, EVD_FDB_VOCAB_ID 
	FROM fdb_b.REVDEL0 
	WHERE EVD_FDB_VOCAB_TYPE_ID = 3
	GROUP BY EVD_FDB_VOCAB_ID
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
