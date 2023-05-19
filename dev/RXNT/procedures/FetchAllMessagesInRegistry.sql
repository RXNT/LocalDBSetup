SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[FetchAllMessagesInRegistry]
  @drid BIGINT  
  
AS
BEGIN
SELECT vq.[vac_rec_id],
	vq.pat_id,
	P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE,
     vr.vac_name,vq.exportedDate,     
     CASE WHEN vq.isIncluded=1 AND vq.exportedDate IS NULL
     THEN 'Pending'
     ELSE 'Completed'
     END AS [Status]
    ,vr.vac_dt_admin
  FROM [dbo].[tblVaccinationQueue] vq,tblVaccinationRecord vr,tblVaccines v,patients p
  WHERE  vq.isIncluded=1 AND  vq.dr_id=@drid AND vq.pat_id=p.pa_id
  AND vq.vac_rec_id=vr.vac_rec_id AND vr.vac_id=v.vac_id AND vq.exportedDate IS NULL
  ORDER BY [Status],vq.vac_rec_id--,vq.exportedDate 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
