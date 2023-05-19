ALTER TABLE [dbo].[FreeSample_Breeze2_ids] WITH CHECK ADD CONSTRAINT [FK_FreeSample_Breeze2_ids_FreeSample]
   FOREIGN KEY([SampleIdXref]) REFERENCES [dbo].[FreeSample] ([SampleId])

GO
