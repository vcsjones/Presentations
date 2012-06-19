IF EXISTS(SELECT * FROM sys.tables where name = 'Session')
BEGIN
	DROP TABLE [dbo].[Session]
END

IF EXISTS(SELECT * FROM sys.tables where name = 'Speaker')
BEGIN
	DROP TABLE [dbo].[Speaker]
END

IF EXISTS(SELECT * FROM sys.tables where name = 'Release')
BEGIN
	DROP TABLE [dbo].[Release]
END

CREATE TABLE [dbo].[Release](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[Version] VARCHAR(20) NOT NULL,
	[Date] DATE NOT NULL
)


CREATE TABLE [dbo].[Speaker](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[FirstName] NVARCHAR(200),
	[LastName] NVARCHAR(200),
	[Bio] NVARCHAR(MAX),
	[Mugshot] VARBINARY(MAX),
	[Website] VARCHAR(1000),
	[Twitter] VARCHAR(15)
	)

CREATE TABLE [dbo].[Session](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[SpeakerID] [int] NOT NULL CONSTRAINT [FK_Session_SpeakerID__Speaker_ID] FOREIGN KEY REFERENCES [Speaker]([Id]),
	[ReleaseID] [int] NOT NULL CONSTRAINT [FK_Session_ReleaseID__Release_ID] FOREIGN KEY REFERENCES [Release]([Id]),
	[Title] NVARCHAR(2000) NOT NULL,
	[Abstract] NVARCHAR(MAX),
	[Begin] TIME NOT NULL,
	[End] TIME NOT NULL,
	[Type] INT NOT NULL
	)

GO


