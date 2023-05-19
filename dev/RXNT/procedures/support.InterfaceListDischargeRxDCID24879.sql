SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Vinod
-- Create date:  Dec 13, 2016
-- Description:	 Accept All Patient Lab Order
-- =============================================
CREATE PROCEDURE [support].[InterfaceListDischargeRxDCID24879]
(
	@DoctorGroupId BIGINT 
)
AS
BEGIN
	select p.pres_id as PresId, p.pres_prescription_type as PresType ,'C' As OrderStatus, PD.pd_id OrderId, Replace(case when P.pres_approved_date is null then '' else CONVERT(VARCHAR(10), P.pres_approved_date, 110) end,'-','') As[ChangeDate],  dr_dea_numb as DEA,case when ph.pharm_company_name is null then '' else ph.pharm_company_name end As PharmacyName,  case when PA.pa_ssn is null then '' else PA.pa_ssn end PatientAccount#,case when PA.pa_last is null then '' else  PA.pa_last end PatientLastName,  case when PA.pa_first is null then '' else PA.pa_first end PatientFirstName,Replace(case when PA.pa_dob is null then '' else CONVERT(VARCHAR(10), PA.pa_dob, 110) end,'-','')  PatientDOB,   case when PA.pa_sex is null then '' else PA.pa_sex end PatientGender,Replace(case when P.pres_approved_date is null then '' else CONVERT(VARCHAR(10), P.pres_approved_date, 110) end,'-','') As[OrderDate],   DR.NDC AS NDC,PD.drug_name As DrugName,PD.duration_amount As Quantity,PD.duration_unit As QuantityUnits,PD.days_supply As DaysSupply,PD.dosage As Directions,  Replace(case when PDI.dtStartDate is null then '' else CONVERT(VARCHAR(10), PDI.dtStartDate, 110) end,'-','') As StartDate, Replace(case when PDI.dtEndDate is null then '' else CONVERT(VARCHAR(10), PDI.dtEndDate, 110) end,'-','') As StopDate,  pd.prn As PRN,pd.prn_description As PRNDescription,PD.numb_refills As Refills,PD.comments As PharmacistNotes,  RM.MED_STRENGTH as Dose, RxNormCode  
	from prescriptions P with(nolock)
	inner join prescription_details PD with(nolock) on P.pres_id = PD.pres_id  
	inner join doctors D with(nolock) on P.dr_id = D.dr_id and P.dg_id = D.dg_id  
	inner join patients PA with(nolock) on P.pa_id = PA.pa_id  
	inner join RMIID1 RM with(nolock) on PD.ddid = RM.MEDID  
	left outer join pharmacies PH with(nolock) on P.pharm_id = PH.pharm_id  
	inner join
	(    
		select PPT.pd_id,  max(send_date) last_sent_date from prescriptions P with(nolock)
		inner join prescription_details PD with(nolock) on P.pres_id = PD.pres_id
		inner join prescription_partner_transmittals PPT with(nolock) on PD.pd_id = PPT.pd_id   
		where P.dg_id = @DoctorGroupId and PD.discharge_date is not null and PD.discharge_date > getdate()-30  
		 group by PPT.pd_id
	)PT on PD.pd_id = PT.pd_id  
	left outer join    
	(
			select max(NDC) NDC, max(case when EVD_EXT_VOCAB_ID is null then '' else EVD_EXT_VOCAB_ID end ) RxNormCode, RN.medid medid from 
			RMIID1 RM with(nolock)        inner join rnmmidndc RN with(nolock) on RM.medid = RN.medid        
			left outer join REVDEL0 RV with(nolock) on RV.EVD_FDB_VOCAB_TYPE_ID = 3 and Cast(RM.medid As varchar(30)) = RV.EVD_FDB_VOCAB_ID        group by RN.medid   
		)
	DR on PD.ddid = DR.medid  
	Left outer join Prescription_Date_Info PDI with(nolock) on PD.pd_id = PDI.pd_id  
	where p.pres_void = 0 and p.pres_approved_date is not null and PD.discharge_date is not null  
	and not(PT.last_sent_date is null)and PT.last_sent_date < PD.discharge_date 
	and P.dg_id =  @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
