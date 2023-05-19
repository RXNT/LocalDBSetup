ALTER TABLE [support].[Patients_Copy_Data_Ref] WITH CHECK ADD CONSTRAINT [FK_Patients_Copy_Data_Ref_CopyRef_Id]
   FOREIGN KEY([CopyRef_Id]) REFERENCES [support].[Patients_Copy_Ref] ([CopyRef_Id])

GO
