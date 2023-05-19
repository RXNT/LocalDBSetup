SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
    
    
    
    
CREATE PROCEDURE [dbo].[SearchCompanyLevelRecentRx]     
 @dc_id BIGINT,    
 @batch_id VARCHAR(50)    
      
AS        
 BEGIN     
    
  delete PEI from [prescription_external_info] PEI with(nolock)    
   inner join  PRESCRIPTIONS P WITH(NOLOCK) on PEI.pres_id = P.pres_id    
   INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID     
   where     
   P.DG_ID IN (SELECT DG_ID FROM DOC_GROUPS WHERE DC_ID = @dc_id )    
    AND PRES_APPROVED_DATE >=GETDATE()-1    
    AND(pei.batch_id IS NULL)    
    
    
  INSERT INTO [dbo].[prescription_external_info]     
  ([pres_id], [pd_id], [external_order_id], [active],    
    [created_date], [created_by], [dc_id],[dg_id],    
    [last_modified_by],[last_modified_date],batch_id    
  )    
  SELECT DISTINCT p.pres_id,pd.pd_id,'',1,GETDATE(),    
   p.prim_dr_id,@dc_id,P.DG_ID,last_edit_dr_id,     
   ISNULL(p.last_edit_date, GETDATE()),@batch_id    
  FROM PRESCRIPTIONS P WITH(NOLOCK)     
  INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID     
  LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK) ON PD.DDID = PAM.DRUG_ID AND PAM.PA_ID = P.PA_ID     
  LEFT OUTER JOIN PHARMACIES PH on P.PHARM_ID=PH.PHARM_ID     
  INNER JOIN PATIENTS PA WITH(NOLOCK) ON P.PA_ID=PA.PA_ID    
  INNER JOIN DOCTORS DR ON P.DR_ID=DR.DR_ID     
  --LEFT OUTER JOIN PRESCRIPTION_STATUS PS ON PD.PD_ID=PS.PD_ID     
  LEFT OUTER JOIN     
   (SELECT RM.MEDID,MAX(ND.NDC)NDC from RMIID1 RM     
    INNER JOIN RMINDC1 ND ON RM.MEDID=ND.MEDID     
     INNER JOIN RNDC14 A on ND.NDC=A.NDC WHERE     
     A.NDCFI in (1,2,3)     
     --AND (A.OBSDTEC is null OR A.OBSDTEC > getdate())    
     group by RM.MEDID    
   ) MED ON PD.DDID=MED.MEDID    
  LEFT OUTER JOIN[dbo].[prescription_external_info] pei WITH(NOLOCK) ON p.pres_id = pei.pres_id     
  WHERE     
   P.DG_ID IN (SELECT DG_ID FROM DOC_GROUPS WHERE DC_ID = @dc_id )    
    AND PRES_APPROVED_DATE >=GETDATE()-1    
    AND(pei.pres_external_info_id IS NULL)    
  ORDER BY PD.PD_ID     
     
  UPDATE prescription_external_info SET external_source_syncdate = GETDATE(),response_status='Success'      
   WHERE dc_id=@dc_id and created_date > GETDATE()-1 and batch_id = @batch_id     
    
  SELECT P.PRES_ID,PD.PD_ID,P.PRES_ENTRY_DATE,    
   P.PRES_APPROVED_DATE,PD.DRUG_NAME,PD.DOSAGE,    
   PD.DURATION_AMOUNT,PD.DURATION_UNIT,PD.DDID,PD.DRUG_NAME,    
   P.PRES_VOID,P.PRES_VOID_COMMENTS,P.pres_prescription_type,    
   PD.USE_GENERIC,PD.NUMB_REFILLS,PD.COMMENTS,    
   PD.PRN,PD.AS_DIRECTED,    
   PD.PRN_DESCRIPTION,PD.DISCHARGE_DR_ID,PD.COMPOUND,    
   PD.HISTORY_ENABLED,MED.NDC,     
   PS.delivery_method,PS.response_type,PS.response_text,PS.response_date,      
   DR.DR_FIRST_NAME,DR.DR_LAST_NAME,DR.DR_ID,DR.NPI,    
   PA.PA_ID,PA.PA_LAST,PA.PA_FIRST,PA.PA_SSN,PA.PA_ID,PA.PA_SEX,PA.PA_DOB,PA.PA_ZIP,    
   PA.PA_ADDRESS1,PA.PA_CITY,PA.PA_STATE,     
   CASE WHEN PAM.DRUG_ID IS NULL THEN 0 ELSE 1 END ACTIVE_MED,      
   P.PHARM_ID,PH.PHARM_COMPANY_NAME,PH.PHARM_ADDRESS1, PH.pharm_address2,
   PH.NCPDP_NUMB,PH.PHARM_CITY,PH.PHARM_STATE,PH.PHARM_ZIP,  
   PD.days_supply,ph.pharm_phone  
  FROM PRESCRIPTIONS P WITH(NOLOCK)     
  INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK) ON P.PRES_ID=PD.PRES_ID     
  LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK) ON PD.DDID = PAM.DRUG_ID AND PAM.PA_ID = P.PA_ID     
  LEFT OUTER JOIN PHARMACIES PH on P.PHARM_ID=PH.PHARM_ID     
  INNER JOIN PATIENTS PA WITH(NOLOCK) ON P.PA_ID=PA.PA_ID     
  INNER JOIN DOCTORS DR ON P.DR_ID=DR.DR_ID     
  LEFT OUTER JOIN PRESCRIPTION_STATUS PS ON PD.PD_ID=PS.PD_ID     
  LEFT OUTER JOIN (    
   SELECT RM.MEDID,MAX(ND.NDC)NDC from RMIID1 RM     
    INNER JOIN RMINDC1 ND ON RM.MEDID=ND.MEDID     
    INNER JOIN RNDC14 A on ND.NDC=A.NDC     
   WHERE     
   A.NDCFI in (1,2,3)     
   --AND (A.OBSDTEC is null OR A.OBSDTEC > getdate())     
   group by RM.MEDID    
  ) MED ON PD.DDID=MED.MEDID    
  INNER JOIN[dbo].[prescription_external_info] pei WITH(NOLOCK) ON p.pres_id = pei.pres_id     
  WHERE P.DG_ID IN (SELECT DG_ID FROM DOC_GROUPS WHERE DC_ID = @dc_id )    
   AND PRES_APPROVED_DATE >= GETDATE()-1    
   AND pei.dc_id = @dc_id    
   AND pei.batch_id = @batch_id    
  ORDER BY PD.PD_ID     
 END    
    
    
    
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
