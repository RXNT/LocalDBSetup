SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	03-AUGUST-2016
Description			:	This procedure is used to Get List Patient Profile Items
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetListPatientProfileItems]	
	
AS
BEGIN
		SELECT A.HEADERID, A.HEADERTEXT, A.ORDERID,
        B.ITEM_ID, B.ITEM_LABEL, B.ITEM_TYPE, B.ORDER_ID FROM patient_profile_headers A INNER JOIN 
        patient_profile_items B ON A.HEADERID =B.HEADER_ID ORDER 
        BY A.ORDERID, B.ORDER_ID
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
