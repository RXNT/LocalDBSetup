CREATE TABLE [dbo].[patient_profile_items] (
   [item_id] [int] NOT NULL
      IDENTITY (1,1),
   [header_id] [int] NOT NULL,
   [item_label] [varchar](225) NOT NULL,
   [item_type] [tinyint] NOT NULL,
   [order_id] [tinyint] NOT NULL

   ,CONSTRAINT [PK_patient_profile_items] PRIMARY KEY CLUSTERED ([item_id])
)


GO
