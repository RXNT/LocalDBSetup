SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author    : Vinod
Create date   : 
Description   : 
Last Modified By :
Last Modifed Date :
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SearchFaxDoctors] 
 @Name    VARCHAR(50),
 @DoctorCompanyId bigint
AS
BEGIN
	select  d.target_dr_id as LoginId,
	d.first_name as Firstname,
	d.last_name as LastName,
	d.fax as Fax from [RxNT].[dbo].[referral_target_docs] d
	where (d.first_name like '%'+@Name+'%' or d.last_name like '%'+@Name+'%') and d.fax!= '' 
	and d.dc_id=@DoctorCompanyId
	 and LEN(d.fax) >=10
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
