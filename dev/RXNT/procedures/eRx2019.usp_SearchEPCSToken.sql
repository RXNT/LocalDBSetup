SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author : Rasheed
Create date : 07-Oct-2019
Description : This procedure is used to get Search active tokens
Last Modified By :
Last Modifed Date :
=======================================================================================
*/

CREATE PROCEDURE [eRx2019].[usp_SearchEPCSToken]  --118031
AS
BEGIN
SELECT distinct
      dti.[dr_id]
      ,dti.[dr_id] DoctorId
      ,dr.dr_username UserName
      ,CAST(1 AS BIT)AS IsIdProofingCompleted
      FROM doc_token_info dti WITH(NOLOCK)
      INNER JOIN doctors dr WITH(NOLOCK) ON dti.dr_id=dr.dr_id
      WHERE  [token_type] IN (1,2) AND LEN(dr.spi_id)>0
 AND ISNULL([is_activated],0)!=1
 AND stage IN (6) AND LEN(dr.spi_id)>0 AND dr.ss_enable=1 AND dr.dr_enabled=1
 AND (epcs_enabled is null or epcs_enabled = 0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
