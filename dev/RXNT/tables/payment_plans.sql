CREATE TABLE [dbo].[payment_plans] (
   [payment_plan_id] [int] NOT NULL
      IDENTITY (1,1),
   [plan_name] [varchar](80) NOT NULL,
   [plan_desc] [varchar](255) NULL

   ,CONSTRAINT [PK_payment_plans] PRIMARY KEY CLUSTERED ([payment_plan_id])
)


GO
