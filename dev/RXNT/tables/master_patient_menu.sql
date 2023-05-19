CREATE TABLE [dbo].[master_patient_menu] (
   [master_patient_menu_id] [int] NOT NULL
      IDENTITY (1,1),
   [code] [varchar](5) NOT NULL,
   [description] [varchar](max) NOT NULL,
   [sort_order] [int] NOT NULL,
   [is_ehr] [bit] NULL,
   [is_erx] [bit] NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL,
   [active] [bit] NULL

   ,CONSTRAINT [AK_master_patient_menu_Column] UNIQUE NONCLUSTERED ([code])
   ,CONSTRAINT [PK_master_patient_menu] PRIMARY KEY CLUSTERED ([master_patient_menu_id])
)


GO
