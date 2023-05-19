CREATE TABLE [dbo].[InformationBlockingReason] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Reason] [varchar](255) NOT NULL

   ,CONSTRAINT [PkInformationBlockingReasonId] PRIMARY KEY CLUSTERED ([Id])
)


GO
