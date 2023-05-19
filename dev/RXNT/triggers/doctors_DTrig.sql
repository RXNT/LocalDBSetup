SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[doctors_DTrig] ON [dbo].[doctors] FOR DELETE AS
/*
 * CASCADE DELETES TO 'doc_fav_pharms'
 */
DELETE doc_fav_pharms FROM deleted, doc_fav_pharms WHERE deleted.dr_id = doc_fav_pharms.dr_id
/*
 * CASCADE DELETES TO 'doc_fav_cities'
 */
DELETE doc_fav_cities FROM deleted, doc_fav_cities WHERE deleted.dr_id = doc_fav_cities.dr_id
/*
 * CASCADE DELETES TO 'doc_fav_drugs'
 */
DELETE doc_fav_drugs FROM deleted, doc_fav_drugs WHERE deleted.dr_id = doc_fav_drugs.dr_id
/*
 * Log DELETES TO 'doctors_temp'
 */

INSERT INTO [doctors_log_delete] SELECT deleted.dr_id,deleted.dg_id,deleted.[dr_field_not_used1],deleted.[dr_prefix],deleted.[dr_first_name],deleted.[dr_middle_initial],deleted.[dr_last_name],user FROM  deleted
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[doctors_DTrig] ON [dbo].[doctors]
GO

GO
