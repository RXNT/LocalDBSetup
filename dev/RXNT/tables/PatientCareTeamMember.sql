CREATE TABLE [dbo].[PatientCareTeamMember] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [FirstName] [varchar](100) NOT NULL,
   [License] [varchar](30) NULL,
   [RoleDescription] [varchar](150) NULL,
   [PhoneNumber] [varchar](20) NULL,
   [Email] [varchar](100) NULL,
   [AddressId] [bigint] NULL,
   [StatusId] [int] NULL,
   [RoleCode] [varchar](20) NULL,
   [LastName] [varchar](100) NOT NULL,
   [Name] [varchar](100) NULL,
   [CreatedDate] [datetime] NOT NULL,
   [CreatedBy] [int] NOT NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [int] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientCareTeamMember_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
