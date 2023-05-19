﻿SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.DRUG_INTERACTIONS_CROSS_REFERENCE
AS
SELECT DISTINCT S.MEDID, S.MED_MEDID_DESC, R.MEDID INTERACTING_DRUG_ID, 
R.MED_MEDID_DESC INTERACTING_DRUG_NAME, S.DDI_CODEX
FROM (
	SELECT A.MEDID, A.MED_MEDID_DESC, A.GCN_SEQNO, B.DDI_CODEX,  B.DDI_DIFF 
	FROM dbo.RMIID1 A 
	INNER JOIN dbo.RADIMGC4 B ON A.GCN_SEQNO = B.GCN_SEQNO 
	WHERE A.MEDID IN (
		SELECT MEDID 
		FROM dbo.RMIID1
	)
) S 
INNER JOIN (
	SELECT A.MEDID, A.MED_MEDID_DESC, A.GCN_SEQNO, B.DDI_CODEX, B.DDI_DIFF 
	FROM dbo.RMIID1 A 
	INNER JOIN dbo.RADIMGC4 B ON A.GCN_SEQNO = B.GCN_SEQNO 
	WHERE A.MEDID IN (
		SELECT MEDID 
		FROM dbo.RMIID1
	)
) R ON S.DDI_CODEX = R.DDI_DIFF
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[duration_units] AS
SELECT * FROM RxGlobal..duration_units
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW ETC_SEARCH_TABLE AS SELECT * FROM RXGLOBAL..ETC_SEARCH_TABLE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create view MED_NAME_DRUG_COUNT as select * from rxglobal..MED_NAME_DRUG_COUNT	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view rgerigc0 as select * from rxglobalnew..rgerigc0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[RGERIMA0]
AS
 SELECT * FROM RXGLOBALNEW..RGERIMA0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view RPEDIGC0 as select * from rxglobalnew..RPEDIGC0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view RPEDIMA0 as select * from rxglobalnew..RPEDIMA0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
