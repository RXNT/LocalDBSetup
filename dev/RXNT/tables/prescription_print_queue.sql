CREATE TABLE [dbo].[prescription_print_queue] (
   [pres_print_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [record_entry_date] [datetime] NOT NULL,
   [record_entry_dr_id] [int] NOT NULL,
   [print_complete_date] [datetime] NULL,
   [print_complete_dr_id] [int] NULL,
   [print_IP_Address] [nvarchar](50) NULL

   ,CONSTRAINT [PK_prescription_print_queue] PRIMARY KEY CLUSTERED ([pres_print_id])
)


GO
