CREATE TABLE [dbo].[rxnt_sg_promotions_count] (
   [ad_count_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ad_id] [int] NOT NULL,
   [dtstart] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [total] [int] NOT NULL

   ,CONSTRAINT [PK_rxnt_sg_promotions_count] PRIMARY KEY CLUSTERED ([ad_count_id])
)


GO
