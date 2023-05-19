SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view vwTempScott99
as
select count(dr_id) as useCnt, dr_username FROM doctors 
group by dr_username
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
