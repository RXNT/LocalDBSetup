ALTER TABLE [dbo].[doctor_grouping_details] WITH CHECK ADD CONSTRAINT [FK_doctor_grouping_details_doctor_grouping]
   FOREIGN KEY([grp_id]) REFERENCES [dbo].[doctor_grouping] ([grp_id])
   ON UPDATE CASCADE
   ON DELETE CASCADE

GO
