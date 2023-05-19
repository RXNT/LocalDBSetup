SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	05-JULY-2016
Description			:	This procedure is used to Get All Patient Documents Category
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetAllPatientDocumentsCategory]	
	@DoctorGroupId			BIGINT	
AS
BEGIN
	select title, cat_id from  patient_documents_category with(nolock)
	 where dg_id IN( @DoctorGroupId, 0)  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
