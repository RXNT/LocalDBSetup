CREATE TABLE [dbo].[patient_menu_doctor_level] (
   [patient_menu_doctor_level_id] [int] NOT NULL
      IDENTITY (1,1),
   [master_patient_menu_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [is_show] [bit] NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL,
   [sort_order] [int] NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_patient_menu_doctor_level] PRIMARY KEY CLUSTERED ([patient_menu_doctor_level_id])
)


GO
