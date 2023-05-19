SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[vwDisabledGroups]
as
select dg_id from  vwDocCompIDEnableDisable 
inner join doc_groups on vwDocCompIDEnableDisable.dc_id = doc_groups.dc_id
where dr_enabled = 0 and dr_create_date < getdate()-90
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
