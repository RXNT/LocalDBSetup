SET ANSI_NULLS ON 
GO
CREATE PROCEDURE AddPrescription  
@dr_id int,
@dg_id int,
@pharm_id int,
@pa_id int,
@pres_entry_date datetime,
@pres_is_refill bit,
@rx_number varchar(50),
@last_pharm_name  varchar(50),
@last_pharm_address  varchar(50),
@last_pharm_city  varchar(50),
@last_pharm_state  varchar(50),
@last_pharm_phone  varchar(50),
@pharm_state_holder varchar(50),
@pharm_city_holder varchar(50),
@pharm_id_holder varchar(50),
@pres_delivery_method int

AS
INSERT INTO prescriptions (dr_id, dg_id, pharm_id, pa_id, pres_entry_date, pres_is_refill, rx_number, last_pharm_name, last_pharm_address,
last_pharm_city, last_pharm_state, last_pharm_phone, pharm_state_holder, pharm_city_holder, pharm_id_holder, pres_delivery_method)
VALUES (@dr_id, @dg_id, @pharm_id, @pa_id, @pres_entry_date, @pres_is_refill, @rx_number, @last_pharm_name, @last_pharm_address,
@last_pharm_city, @last_pharm_state, @last_pharm_phone, @pharm_state_holder, @pharm_city_holder, @pharm_id_holder, @pres_delivery_method)

SELECT @@identity
GO
SET ANSI_NULLS OFF 
GO

GO
