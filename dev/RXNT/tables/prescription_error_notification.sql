CREATE TABLE [dbo].[prescription_error_notification] (
   [pres_error_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [ps_id] [int] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [active] [bit] NOT NULL,
   [comments] [varchar](2096) NULL

   ,CONSTRAINT [PK_prescription_error_notification] PRIMARY KEY CLUSTERED ([pres_error_id])
)


GO
