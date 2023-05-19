CREATE TABLE [dbo].[patients_member_info] (
   [pmi_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pbm_member_id] [varchar](80) NULL,
   [add_date] [smalldatetime] NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_patients_member_info] PRIMARY KEY CLUSTERED ([pmi_id])
)


GO
