SET ANSI_NULLS ON 
GO
CREATE PROCEDURE AddPrescriptionDetails 
@drug_name varchar,
@pres_id int,
@ddid int,
@dosage varchar,
@use_generic bit,
@numb_refills int,
@comments varchar,
@duration_amount varchar,
@duration_unit varchar
AS
INSERT INTO prescription_details (drug_name, pres_id, ddid, dosage, use_generic, numb_refills, comments, duration_amount, duration_unit)
VALUES(@drug_name, @pres_id, @ddid, @dosage, @use_generic, @numb_refills, @comments, @duration_amount, @duration_unit)
SELECT @@identity
GO
SET ANSI_NULLS OFF 
GO

GO
