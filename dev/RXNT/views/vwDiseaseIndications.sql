SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    view vwDiseaseIndications AS

SELECT DISTINCT TXR, ICD9, Message from
(
select TXR, ICD9, Message from RxGlobal..ContraIndications C inner join RxGlobal..ContraMessages M on
c.message1 = M.msgNo Union
select  TXR, ICD9, Message from RxGlobal..ContraIndications C inner join RxGlobal..ContraMessages M on
c.message2 = M.msgNo union
select  TXR, ICD9, Message from RxGlobal..ContraIndications C inner join RxGlobal..ContraMessages M on
c.message3 = M.msgNo
union
select  TXR, ICD9, Message from RxGlobal..ContraIndications C inner join RxGlobal..ContraMessages M on
c.message4 = M.msgNo
) Q
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
