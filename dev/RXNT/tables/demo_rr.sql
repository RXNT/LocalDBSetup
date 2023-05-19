CREATE TABLE [dbo].[demo_rr] (
   [demo_rr_id] [int] NOT NULL
      IDENTITY (1,1),
   [sales_rep_id] [int] NOT NULL,
   [enroll_sales_rep_id] [int] NULL

   ,CONSTRAINT [PK_demo_rr] PRIMARY KEY CLUSTERED ([demo_rr_id])
)


GO
