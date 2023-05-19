SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	17-APRIL-2017
Description			:	Used to update the state, city, zip, phone, fax, address for particular company
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [support].[UpdateDoctorDetails]	
    @DoctorCompanyId	INT 
		
AS
BEGIN
	update d set d.dr_address1='6408 Bannington Road', d.dr_address2='', 
	d.dr_city='Charlotte', d.dr_state='NC', d.dr_zip='28226', 
	d.dr_phone='704-247-9186', d.dr_fax='704-926-2045'
	from doctors d with(nolock)
	inner join doc_groups dg with(nolock) on d.dg_id = dg.dg_id 
	where dg.dc_id=@DoctorCompanyId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
