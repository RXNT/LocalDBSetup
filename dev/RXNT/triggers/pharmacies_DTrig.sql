SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER pharmacies_DTrig ON dbo.pharmacies FOR DELETE AS
/*
 * CASCADE DELETES TO 'pharmacy_users'
 */
DELETE pharmacy_users FROM deleted, pharmacy_users WHERE deleted.pharm_id = pharmacy_users.pharm_id
/*
 * CASCADE DELETES TO 'doc_fav_pharms'
 */
DELETE doc_fav_pharms FROM deleted, doc_fav_pharms WHERE deleted.pharm_id = doc_fav_pharms.pharm_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[pharmacies_DTrig] ON [dbo].[pharmacies]
GO

GO
