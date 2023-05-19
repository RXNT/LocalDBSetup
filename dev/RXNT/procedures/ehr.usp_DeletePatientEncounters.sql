SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Mukhil Padmanabhan
Create date			:	03-MARCH-2021
Description			:	This procedure is used to delete patient encounters
Last Modified By	:	Samip Neupane (Use added_by_dr_id instead of dr_id while getting encounters to delete)
Last Modifed Date	:	02-01-2023
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_DeletePatientEncounters]
@EncounterIds XML,
@DoctorId BIGINT
AS

BEGIN

DELETE ee FROM ENCHANCED_ENCOUNTER ee
INNER JOIN @EncounterIds.nodes('/ArrayOfInt/int') AS t(ArrayOfInt) ON ee.enc_id=  t.ArrayOfInt.value('.','int')
WHERE ADDED_BY_DR_ID=@DoctorId AND ISSIGNED=0

UPDATE pv  
SET ENC_ID = 0,chkout_notes=''
FROM patient_visit pv 
INNER JOIN @EncounterIds.nodes('/ArrayOfInt/int') AS t(ArrayOfInt) ON pv.enc_id=  t.ArrayOfInt.value('.','int')

WHERE   DR_ID=@DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
