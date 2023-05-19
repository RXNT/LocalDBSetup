CREATE TABLE [dbo].[webinar_customers] (
   [customer_id] [int] NOT NULL
      IDENTITY (1,1),
   [webinar_event_id] [int] NOT NULL,
   [fname] [varchar](50) NOT NULL,
   [lname] [varchar](50) NOT NULL,
   [phone] [varchar](50) NOT NULL,
   [state] [varchar](25) NOT NULL,
   [email] [varchar](100) NOT NULL,
   [grpname] [varchar](50) NOT NULL,
   [has_viewed] [bit] NOT NULL,
   [address1] [varchar](50) NOT NULL,
   [address2] [varchar](50) NOT NULL,
   [city] [varchar](50) NOT NULL,
   [zip] [varchar](20) NOT NULL,
   [sales_rep_id] [int] NOT NULL,
   [eventtype_id] [int] NOT NULL

   ,CONSTRAINT [PK_webinar_customers] PRIMARY KEY CLUSTERED ([customer_id])
)

CREATE NONCLUSTERED INDEX [IX_webinar_customers] ON [dbo].[webinar_customers] ([webinar_event_id])

GO
