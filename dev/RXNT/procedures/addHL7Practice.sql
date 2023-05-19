SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[addHL7Practice]
  @DCID INTEGER, @PMS VARCHAR(125),@UID VARCHAR(10),@PWD VARCHAR(10)
AS
  DECLARE @maxID INTEGER, @HL7PracID INTEGER
  SELECT @maxID = COALESCE(MAX(cast(hl7_cr_id as int)),0) FROM hl7_cross_reference WHERE application = @PMS
  SET @HL7PracID = @maxID + 1
  INSERT INTO hl7_cross_reference (application, dc_id, hl7_prac_id,uid,pwd) VALUES (@PMS, @DCID, @HL7PracID,@UID,@PWD)
  SELECT @HL7PracID hl7_prac_id,@UID,@PWD
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
