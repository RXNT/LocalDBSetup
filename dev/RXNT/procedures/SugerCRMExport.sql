SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SugerCRMExport]	
	@timePeriod INTEGER

AS
BEGIN	
		
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  select  distinct 
			d.dr_id,
			case when d.dr_prefix is null then '' else d.dr_prefix end dr_prefix,
			case when d.professional_designation is null then '' else d.professional_designation end professional_designation,
			d.dr_first_name,
			case when d.dr_middle_initial is null then '' else d.dr_middle_initial end dr_middle_initial,
			case when d.dr_last_name is null then '' else d.dr_last_name end dr_last_name,
			case when d.NPI is null then '' else d.NPI end NPI,
			case when d.dr_address1 is null then '' else d.dr_address1 end dr_address1,
			case when d.dr_address2 is null then '' else d.dr_address2 end dr_address2,
			case when d.dr_city is null then '' else d.dr_city end dr_city,
			case when d.dr_state is null then '' else d.dr_state end dr_state,
			case when d.dr_lic_state is null then '' else d.dr_lic_state end dr_lic_state,
			case when d.dr_zip is null then '' else d.dr_zip end dr_zip,
			case when d.dr_phone is null then '' else d.dr_phone end dr_phone,
			case when d.dr_phone_alt1 is null then '' else d.dr_phone_alt1 end dr_phone_alt1 ,
			case when d.dr_phone_alt2 is null then '' else d.dr_phone_alt2 end dr_phone_alt2 ,
			case when d.dr_phone_emerg is null then '' else d.dr_phone_emerg end dr_phone_emerg ,
			case when d.dr_fax is null then '' else d.dr_fax end dr_fax ,
			case when d.dr_email is null then '' else d.dr_email end dr_email ,
			case when d.dr_create_date is null then '1901-01-01' else d.dr_create_date end dr_create_date ,
			d.dr_enabled,
			d.time_difference,
			d.activated_date,
			d.deactivated_date,
			d.dr_type,
			d.prescribing_authority,
			case when d.how_heard_about is null then '' else d.how_heard_about end how_heard_about ,
			case 
				when dsr.speciality_id is NULL then 0 else dsr.speciality_id end specialityID,
		    case 
				when dspec.speciality is NULL then 'N/A' else dspec.speciality end speciality,	
			d.dr_status,
			case when d.office_contact_name is null then '' else d.office_contact_name end office_contact_name ,
			case when d.office_contact_email is null then '' else d.office_contact_email end office_contact_email ,
			case when d.office_contact_phone is null then '' else d.office_contact_phone end office_contact_phone ,
			case 
				when d.lab_enabled is NULL then 0 else d.lab_enabled end lab_enabled,
			d.dg_id,
			dg.dg_name,
			dc.dc_id,
			dc.dc_name,
			d.lowusage_lock,
			d.billing_enabled,
			case when d.billingDate is null then '1901-01-01' ELSE d.billingDate End billingDate,
			case when dg.billing_date is null then '1901-01-01' ELSE dg.billing_date End billing_date,
			di.is_epcs,			 			
			di.is_custom_tester,	
			epcs_enabled,		
			case 
				when dt.ups_tracking_id is NULL then 'N/A' else dt.ups_tracking_id end ups_tracking_id,	
			case
				when dt.stage = -1 and (epcs_enabled is NULL) and ((di.is_custom_tester & 2) = 2) then 'ID Proof is in the process'								
				when dt.stage = 0  and (epcs_enabled is NULL) then 'ID Proof Complete, Token Processing'
				when dt.stage = 1  and (epcs_enabled is NULL)then 'Shipped'
				when dt.stage = 2  and (epcs_enabled is NULL)then 'Billing completed'
				when dt.stage = 3  and (epcs_enabled is NULL) then 'Ready to be Shipped'	
				when dt.stage = 99 and (epcs_enabled is NULL) then 'SafeNet Email Sent'
				when di.is_epcs = 1 and (epcs_enabled is NULL) then 'Token Activated but pending surescript activation'
				when epcs_enabled = 1 and (epcs_enabled is NULL) then 'Token fully Activated'
				when dt.stage = 4 and (epcs_enabled is NULL) then 'Token is shippment is voided'		
				Else 'NA'				
			END	 EPCSStatus,
			CASE 
			when epcs_enabled = 1 then 6
			when (dt.stage = -1 and (epcs_enabled is NULL) and ((di.is_custom_tester & 2) = 2)) then 1							
			when (dt.stage = 0  and (epcs_enabled is NULL)) then 2
			when dt.stage = 99 and epcs_enabled is NULL then 3
			when dt.stage = 3  and epcs_enabled is NULL then 4	
			when dt.stage = 1  and epcs_enabled is NULL then 5	
			when dt.stage = 4 and epcs_enabled is NULL then 7
			when dt.stage = 2 and epcs_enabled is NULL then 8		
			else 0							
			END	 epcsID,	
			case when pa.PARTNER_ID is null then 1 
				when pa.PARTNER_ID = 1 then 0 
				else pa.PARTNER_ID end PARTNER_ID,
			case when pa.PARTNER_NAME is null then 'RxNT'
				when pa.PARTNER_ID = 1 then 'Santa Barbara Interface' 
				else pa.PARTNER_NAME end PARTNER_NAME,
			si.sale_person_id,
			si.sale_person_fname,
			si.sale_person_mi,
			si.sale_person_lname,
			si.email as [SalesPerson EmailID],
			CASE WHEN App.EHR is null then 0 ELSE App.EHR END EHR,
			case when d.epcs_enabled is null then 0 else d.epcs_enabled END EPCS,
			Case when App.ERX is null then 0 ELSE App.ERX END ERX,
			Case when App.PM is null then 0 ELSE App.PM END PM,
			Case when App.SCHEDULER is null then 0 ELSE App.SCHEDULER END SCHEDULER
			from doctors d with(nolock)									
			inner join doctor_info di with(nolock) on d.dr_id = di.dr_id			
			inner join dbo.sales_person_info si with(nolock) on d.sales_person_id = si.sale_person_id
			inner join doc_groups dg with(nolock) on d.dg_id = dg.dg_id
			inner join doc_companies dc with(nolock) on dg.dc_id = dc.dc_id
			inner join dbo.insert_update_log ul with(nolock) on d.dr_id = ul.DrID			
			left join doc_token_info dt with(nolock) on d.dr_id = dt.dr_id 
			left join doctor_specialities_xref dsr with(nolock) on d.dr_id= dsr.dr_id 
			left join doctor_specialities dspec with(nolock) on dsr.speciality_id = dspec.speciality_id
			Left join dbo.PARTNER_ACCOUNTS pa with(nolock) on dc.partner_id = pa.partner_id
			LEFT OUTER join doctor_app_info App with(nolock) on d.dr_id = App.dr_id
			where  1=1
			---and prescribing_authority > 2 
			--and (dr_enabled=1 or (d.dr_enabled=0 and (d.activated_date is null or d.activated_date > GETDATE()-365)))		
			and ul.UpdatedDate between 	DATEADD(mi,-@timePeriod,GetDate()) and getdate()

  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
