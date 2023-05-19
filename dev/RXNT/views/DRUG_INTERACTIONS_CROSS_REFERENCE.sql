SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[DRUG_INTERACTIONS_CROSS_REFERENCE]
as
SELECT  DISTINCT S.MEDID, S.MED_MEDID_DESC, R.MEDID INTERACTING_DRUG_ID, R.MED_MEDID_DESC INTERACTING_DRUG_NAME, S.DDI_CODEX
  FROM
(SELECT A.MEDID, A.MED_MEDID_DESC, A.GCN_SEQNO, B.DDI_CODEX,  B.DDI_DIFF FROM RMIID1 A INNER JOIN
RADIMGC4 B ON A.GCN_SEQNO = B.GCN_SEQNO WHERE A.MEDID IN
(SELECT MEDID FROM RMIID1)) S INNER JOIN
(SELECT A.MEDID, A.MED_MEDID_DESC, A.GCN_SEQNO, B.DDI_CODEX, B.DDI_DIFF FROM RMIID1 A INNER JOIN
RADIMGC4 B ON A.GCN_SEQNO = B.GCN_SEQNO WHERE A.MEDID IN
(SELECT MEDID FROM RMIID1)) R ON S.DDI_CODEX = R.DDI_DIFF
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO