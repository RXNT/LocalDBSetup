SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[updateLabInfo]
  @labName VARCHAR(20),
  @sendApp VARCHAR(20),
 -- @recvFacility VARCHAR(20),
  @dgID INTEGER,
  @lab_partner_id BIGINT = NULL
  
AS    
  BEGIN
		
	UPDATE [dbo].[lab_partners] SET  [partner_name]=@labName,[partner_sendapp_text]=@sendApp WHERE lab_partner_id = @lab_partner_id
   
   /*
   UPDATE
    im
SET
    dg_lab_id = @recvFacility
FROM
    doc_groups_lab_info im
    JOIN
    lab_partners gm ON im.lab_participant=gm.partner_participant 
WHERE
	gm.lab_partner_id = @lab_partner_id  AND
    im.dg_id = @dgID
    */
    
    
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
