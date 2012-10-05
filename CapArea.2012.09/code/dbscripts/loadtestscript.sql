
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'LoadTest2010')
BEGIN
    CREATE DATABASE [LoadTest2010] COLLATE SQL_Latin1_General_CP1_CI_AS
END
GO

use [LoadTest2010]
GO

IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestRun]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

SET QUOTED_IDENTIFIER OFF 

SET ANSI_NULLS ON 

ALTER DATABASE [LoadTest2010] SET AUTO_CLOSE OFF

ALTER DATABASE [LoadTest2010] SET PAGE_VERIFY TORN_PAGE_DETECTION

ALTER DATABASE [LoadTest2010] SET READ_WRITE

ALTER DATABASE [LoadTest2010] SET MULTI_USER

ALTER DATABASE [LoadTest2010] SET AUTO_SHRINK OFF

ALTER DATABASE [LoadTest2010] SET ANSI_NULL_DEFAULT OFF

ALTER DATABASE [LoadTest2010] SET RECURSIVE_TRIGGERS OFF

ALTER DATABASE [LoadTest2010] SET ANSI_NULLS OFF

ALTER DATABASE [LoadTest2010] SET CONCAT_NULL_YIELDS_NULL OFF

ALTER DATABASE [LoadTest2010] SET CURSOR_CLOSE_ON_COMMIT OFF

ALTER DATABASE [LoadTest2010] SET CURSOR_DEFAULT GLOBAL

ALTER DATABASE [LoadTest2010] SET QUOTED_IDENTIFIER OFF

ALTER DATABASE [LoadTest2010] SET ANSI_WARNINGS OFF

ALTER DATABASE [LoadTest2010] SET AUTO_CREATE_STATISTICS ON

ALTER DATABASE [LoadTest2010] SET AUTO_UPDATE_STATISTICS ON

CREATE TABLE [dbo].[LoadTestRun] (
	[LoadTestRunId] [int] IDENTITY (1, 1) NOT NULL ,
	[LoadTestName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RunId] [char] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartTime] [datetime] NULL ,
	[EndTime] [datetime] NULL ,
	[RunDuration] [int] NOT NULL ,
	[WarmupTime] [int] NOT NULL ,
	[RunSettingUsed] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[IsLocalRun] [bit] NOT NULL ,
	[ControllerName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Outcome] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LoadTest] [image] NULL ,
	[Comment] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LoadTestSchemaRev] [int] NULL,
	[CooldownTime] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestRun] TO PUBLIC


CREATE TABLE [dbo].[LoadTestSchemaRevision] (
	[LoadTestSchemaRev] [int] NOT NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestSchemaRevision] TO PUBLIC
	

INSERT INTO [dbo].[LoadTestSchemaRevision] ([LoadTestSchemaRev]) VALUES (3)


CREATE TABLE [dbo].[LoadTestCase] (
	[LoadTestRunId] [int] NOT NULL ,
	[ScenarioId] [int] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,
	[TestCaseName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TestElement] [image] NULL ,
	[TestType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL	
) ON [PRIMARY]

GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestCase] TO PUBLIC


CREATE TABLE [dbo].[LoadTestMessage] (
	[LoadTestRunId] [int] NOT NULL ,
	[AgentId] [int] NOT NULL ,
	[MessageId] [int] NOT NULL ,
	[MessageType] [tinyint] NOT NULL ,
	[MessageText] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StackTrace] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MessageTimeStamp] [datetime] NOT NULL ,
	[TestCaseId] [int] NULL ,
	[RequestId] [int] NULL ,
	[TestLogId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestMessage] TO PUBLIC

CREATE TABLE [dbo].[LoadTestThresholdMessage] (
	[LoadTestRunId] [int] NOT NULL ,
	[TestRunIntervalId] [int] NOT NULL,
	[CounterInstanceId] [int] NOT NULL,
	[MessageId] [int] NOT NULL ,
	[MessageText] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestThresholdMessage] TO PUBLIC

CREATE TABLE [dbo].[LoadTestMessageType] (
	[LoadTestRunId] [int] NOT NULL ,
	[MessageTypeId] [int] NOT NULL,
	[MessageType] [tinyint] NOT NULL ,
	[SubType] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestMessageType] TO PUBLIC

CREATE TABLE [dbo].[LoadTestPerformanceCounter] (
	[LoadTestRunId] [int] NOT NULL ,
	[CounterCategoryId] [int] NOT NULL ,
	[CounterId] [int] NOT NULL ,
	[CounterName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[HigherIsBetter] [bit] NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPerformanceCounter] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPerformanceCounterCategory] (
	[LoadTestRunId] [int] NOT NULL ,
	[CounterCategoryId] [int] NOT NULL ,
	[CategoryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[StartTimeStamp100nSec] [bigint] NOT NULL	
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPerformanceCounterCategory] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPerformanceCounterInstance] (
	[LoadTestRunId] [int] NOT NULL ,
	[CounterId] [int] NOT NULL ,
	[InstanceId] [int] NOT NULL ,
	[LoadTestItemId] [int] NULL ,
	[InstanceName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CumulativeValue] [real] NULL ,
	[OverallThresholdRuleResult] [tinyint] NULL 
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPerformanceCounterInstance] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPerformanceCounterSample] (
	[LoadTestRunId] [int] NOT NULL ,
	[TestRunIntervalId] [int] NOT NULL ,
	[InstanceId] [int] NOT NULL ,
	[ComputedValue] [real] NULL ,
	[RawValue] [bigint] NOT NULL ,
	[BaseValue] [bigint] NOT NULL ,
	[CounterFrequency] [bigint] NOT NULL ,
	[SystemFrequency] [bigint] NOT NULL ,
	[SampleTimeStamp] [bigint] NOT NULL ,
	[SampleTimeStamp100nSec] [bigint] NOT NULL ,
	[CounterType] [int] NOT NULL ,
	[ThresholdRuleResult] [tinyint] NOT NULL ,
	[ThresholdRuleMessageId] [int] NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPerformanceCounterSample] TO PUBLIC



CREATE TABLE [dbo].[LoadTestRunAgent] (
	[LoadTestRunId] [int] NOT NULL ,
	[AgentId] [int] NOT NULL ,
	[AgentName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestRunAgent] TO PUBLIC



CREATE TABLE [dbo].[LoadTestRunInterval] (
	[LoadTestRunId] [int] NOT NULL ,
	[TestRunIntervalId] [int] NOT NULL ,
	[IntervalStartTime] [datetime] NOT NULL ,
	[IntervalEndTime] [datetime] NOT NULL 
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestRunInterval] TO PUBLIC


CREATE TABLE [dbo].[LoadTestScenario] (
	[LoadTestRunId] [int] NOT NULL ,
	[ScenarioId] [int] NOT NULL ,
	[ScenarioName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]


GRANT INSERT, DELETE, SELECT ON [dbo].[LoadTestScenario] TO PUBLIC



CREATE TABLE [dbo].[WebLoadTestErrorDetail] (
	[LoadTestRunId] [int] NOT NULL ,
	[AgentId] [int] NOT NULL ,
	[MessageId] [int] NOT NULL ,
	[WebTestRequestResult] [image] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[WebLoadTestErrorDetail] TO PUBLIC



CREATE TABLE [dbo].[WebLoadTestRequestMap] (
	[LoadTestRunId] [int] NOT NULL ,
	[RequestId] [int] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,	
	[RequestUri] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [ResponseTimeGoal] [float] NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[WebLoadTestRequestMap] TO PUBLIC


CREATE TABLE [dbo].[WebLoadTestTransaction] (
	[LoadTestRunId] [int] NOT NULL ,
	[TransactionId] [int] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,
	[TransactionName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
    [Goal] [float] NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[WebLoadTestTransaction] TO PUBLIC


CREATE TABLE [dbo].[LoadTestSqlTrace] (
	[LoadTestRunId] [int] NOT NULL ,
	[TextData] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Duration] [bigint] NULL ,
	[StartTime] [datetime] NULL ,
	[EndTime] [datetime] NULL ,
	[Reads] [bigint] NULL ,
	[Writes] [bigint] NULL ,
	[CPU] [int] NULL ,
	[EventClass] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestSqlTrace] TO PUBLIC


-- Tables added for storing inner test results

CREATE TABLE [dbo].[LoadTestTestLog] (
	[LoadTestRunId] [int] NOT NULL ,
	[AgentId] [int] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,
	[TestLogId] [int] NOT NULL ,
	[TestLog] [image] NOT NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestTestLog] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestLogId],
		[AgentId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestTestLog] TO PUBLIC


-- Tables added for log sources from data collectors

CREATE TABLE [dbo].[LoadTestDataCollectorLog] (
	[LoadTestRunId] [int] NOT NULL ,
	[DataCollectorLogId] [int] NOT NULL ,
	[DataCollectorDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TimestampColumnName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DurationColumnName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,	
	[CreateTableFormatString] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL	
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestDataCollectorLog] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[DataCollectorLogId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestDataCollectorLog] TO PUBLIC


-- Tables added for timing details

CREATE TABLE [dbo].[LoadTestBrowsers] (
	[LoadTestRunId] [int] NOT NULL ,
	[BrowserId] [int] NOT NULL ,
	[BrowserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestBrowsers] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[BrowserId]
	)  ON [PRIMARY] 

	
GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestBrowsers] TO PUBLIC

	
CREATE TABLE [dbo].[LoadTestNetworks] (
	[LoadTestRunId] [int] NOT NULL ,
	[NetworkId] [int] NOT NULL ,
	[NetworkName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestNetworks] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[NetworkId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestNetworks] TO PUBLIC


CREATE TABLE [dbo].[LoadTestSystemUnderTest] (
	[LoadTestRunId] [int] NOT NULL ,
	[SystemUnderTestId] [int] NOT NULL ,
	[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[LoadTestSystemUnderTest] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[SystemUnderTestId]
	)  ON [PRIMARY] 

GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestSystemUnderTest] TO PUBLIC

CREATE TABLE [dbo].[LoadTestSystemUnderTestTag] (
	[LoadTestRunId] [int] NOT NULL ,
	[SystemUnderTestId] [int] NOT NULL ,
	[MachineTag] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestSystemUnderTestTag] TO PUBLIC

CREATE TABLE [dbo].[LoadTestTestDetail] (
	[LoadTestRunId] [int] NOT NULL ,
	[TestDetailId] [int] NOT NULL ,
	[TimeStamp] [datetime] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,
	[ElapsedTime] [float] NOT NULL,
    [AgentId] [int] NOT NULL,
    [BrowserId] [int],
    [NetworkId] [int],
    [Outcome] [tinyint],
    [TestLogId] [int] NULL,
    [UserId] [int] NULL,
    [EndTime] [datetime] NULL,
	[InMeasurementInterval] [bit] NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestTestDetail] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestDetailId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestTestDetail] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPageDetail] (
	[LoadTestRunId] [int] NOT NULL ,
	[PageDetailId] [int] NOT NULL ,
	[TestDetailId] [int] NOT NULL ,
	[TimeStamp] [datetime] NOT NULL ,
	[PageId] [int] NOT NULL ,
	[ResponseTime] [float] NOT NULL,
	[ResponseTimeGoal] [float] NOT NULL,
	[GoalExceeded] [bit] NOT NULL,
	[EndTime] [datetime] NULL,
	[Outcome] [tinyint] NULL,
	[InMeasurementInterval] [bit] NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestPageDetail] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[PageDetailId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPageDetail] TO PUBLIC


CREATE TABLE [dbo].[LoadTestTransactionDetail] (
	[LoadTestRunId] [int] NOT NULL ,
	[TransactionDetailId] [int] NOT NULL ,
	[TestDetailId] [int] NOT NULL ,
	[TimeStamp] [datetime] NOT NULL ,
	[TransactionId] [int] NOT NULL ,
	[ElapsedTime] [float] NOT NULL,
	[EndTime] [datetime] NULL,
	[InMeasurementInterval] [bit] NULL,
        [ResponseTime] [float] NULL	
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestTransactionDetail] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TransactionDetailId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestTransactionDetail] TO PUBLIC


CREATE TABLE [dbo].[LoadTestDetailMessage] (
	[LoadTestRunId] [int] NOT NULL ,
        [LoadTestDetailMessageId] [int] NOT NULL ,
	[TestDetailId] [int] NOT NULL ,
	[PageDetailId] [int] NULL ,
	[MessageTypeId] [int] NOT NULL	
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestDetailMessage] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[LoadTestDetailMessageId]
	)  ON [PRIMARY] 

GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestDetailMessage] TO PUBLIC


CREATE TABLE [dbo].[LoadTestTestSummaryData] (
	[LoadTestRunId] [int] NOT NULL ,
	[TestCaseId] [int] NOT NULL ,
	[TestsRun] [int] NOT NULL ,
	[Average] [float] NOT NULL ,
	[Minimum] [float] NOT NULL ,
	[Maximum] [float] NOT NULL ,
	[Percentile90] [float] NULL ,
	[Percentile95] [float] NULL,
	[Percentile99] [float] NULL,
	[Median] float NULL,
        [StandardDeviation] float NULL 
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestTestSummaryData] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestCaseId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestTestSummaryData] TO PUBLIC


CREATE TABLE [dbo].[LoadTestTransactionSummaryData] (
	[LoadTestRunId] [int] NOT NULL ,
	[TransactionId] [int] NOT NULL ,
	[TransactionCount] [int] NOT NULL ,
	[Average] [float] NOT NULL ,
	[Minimum] [float] NOT NULL ,
	[Maximum] [float] NOT NULL ,
	[Percentile90] [float] NULL ,
	[Percentile95] [float] NULL,
	[Percentile99] [float] NULL,
	[Median] float NULL,
        [StandardDeviation] float NULL,
	[AvgTransactionTime] float NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestTransactionSummaryData] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TransactionId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestTransactionSummaryData] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPageSummaryData] (
	[LoadTestRunId] [int] NOT NULL ,
	[PageId] [int] NOT NULL ,
	[PageCount] [int] NOT NULL ,
	[Average] [float] NOT NULL ,
	[Minimum] [float] NOT NULL ,
	[Maximum] [float] NOT NULL ,
	[Percentile90] [float] NULL ,
	[Percentile95] [float] NULL,
	[Percentile99] [float] NULL,
	[Median] float NULL,
        [StandardDeviation] float NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestPageSummaryData] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[PageId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPageSummaryData] TO PUBLIC


CREATE TABLE [dbo].[LoadTestPageSummaryByNetwork] (
	[LoadTestRunId] [int] NOT NULL,
	[PageId] [int] NOT NULL,
	[NetworkId] [int] NOT NULL,
	[PageCount] [int] NOT NULL,
	[Average] [float] NOT NULL,
	[Minimum] [float] NOT NULL,
	[Maximum] [float] NOT NULL,
	[Percentile90] [float] NULL,
	[Percentile95] [float] NULL,
	[Percentile99] [float] NULL,
	[Goal] [float] NULL,
	[PagesMeetingGoal] [int] NULL,
	[Median] float NULL,
        [StandardDeviation] float NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestPageSummaryByNetwork] TO PUBLIC


ALTER TABLE [dbo].[LoadTestPageSummaryByNetwork] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[PageId],
		[NetworkId]
	)  ON [PRIMARY]


CREATE TABLE [dbo].[LoadTestFileAttachment] (
	[LoadTestRunId] [int] NOT NULL ,
	[FileAttachmentId] [int] NOT NULL ,
	[MachineName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Filename] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileSize] [bigint] NOT NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestFileAttachment] TO PUBLIC


ALTER TABLE [dbo].[LoadTestFileAttachment] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[FileAttachmentId]
	)  ON [PRIMARY]


CREATE TABLE [dbo].[LoadTestFileAttachmentChunk] (
	[LoadTestRunId] [int] NOT NULL ,
	[FileAttachmentId] [int] NOT NULL ,
	[StartOffset] [bigint] NOT NULL ,
	[EndOffset] [bigint] NOT NULL ,
	[ChunkLength] [bigint] NOT NULL ,
	[ChunkBytes] [image] NOT NULL
) ON [PRIMARY]


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestFileAttachmentChunk] TO PUBLIC


ALTER TABLE [dbo].[LoadTestFileAttachmentChunk] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[FileAttachmentId],
		[StartOffset]
	)  ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestRun] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestCase] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestCaseId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestMessage] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[AgentId],
		[MessageId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestThresholdMessage] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[MessageId]
	)  ON [PRIMARY] 

ALTER TABLE [dbo].[LoadTestMessageType] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[MessageTypeId]
	)  ON [PRIMARY]

ALTER TABLE [dbo].[LoadTestPerformanceCounter] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[CounterId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestPerformanceCounterCategory] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[CounterCategoryId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestPerformanceCounterInstance] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[InstanceId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestPerformanceCounterSample] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestRunIntervalId],
		[InstanceId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestRunAgent] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[AgentId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestRunInterval] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TestRunIntervalId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[LoadTestScenario] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[ScenarioId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[WebLoadTestErrorDetail] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[AgentId],
		[MessageId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[WebLoadTestRequestMap] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[RequestId]
	)  ON [PRIMARY] 


ALTER TABLE [dbo].[WebLoadTestTransaction] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[LoadTestRunId],
		[TransactionId]
	)  ON [PRIMARY] 


 CREATE  INDEX [LoadTestCounterNameIndex] ON [dbo].[LoadTestPerformanceCounter]([CounterName]) ON [PRIMARY]


 CREATE  INDEX [LoadTestCategoryNameIndex] ON [dbo].[LoadTestPerformanceCounterCategory]([CategoryName]) ON [PRIMARY]


 CREATE  INDEX [LoadTestInstanceNameIndex] ON [dbo].[LoadTestPerformanceCounterInstance]([InstanceName]) ON [PRIMARY]


 CREATE  INDEX [LoadTestSampleInstanceIndex] ON [dbo].[LoadTestPerformanceCounterSample]([LoadTestRunId], [InstanceId]) ON [PRIMARY]


 CREATE INDEX [LoadTestSqlTraceIndex] ON [dbo].[LoadTestSqlTrace]([LoadTestRunId]) ON [PRIMARY]


-- Create indices on detail tables

CREATE NONCLUSTERED INDEX [LoadTestTestDetail4] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId] ASC, [TestCaseId] ASC,[InMeasurementInterval] ASC, [ElapsedTime] DESC)

CREATE NONCLUSTERED INDEX [LoadTestTestDetail5] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId] ASC, [TestCaseId] ASC) INCLUDE ([TestDetailId],[AgentId],[BrowserId],[NetworkId],[TestLogId],[UserId]) 

CREATE NONCLUSTERED INDEX [LoadTestTestDetail6] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId] ASC, [TestCaseId] ASC,	[EndTime] ASC,[Outcome] ASC,[TimeStamp] ASC,[TestDetailId] ASC,[AgentId] ASC,[NetworkId] ASC,[UserId] ASC) INCLUDE ( [ElapsedTime], [TestLogId])
CREATE NONCLUSTERED INDEX [LoadTestTestDetail7] ON [dbo].[LoadTestTestDetail] ([LoadTestRunId] ASC,[NetworkId] ASC) INCLUDE ([TestDetailId])

CREATE NONCLUSTERED INDEX [LoadTestTransactionDetail4] ON [dbo].[LoadTestTransactionDetail] ([LoadTestRunId] ASC, [TransactionId] ASC,[InMeasurementInterval] ASC,  [ResponseTime] DESC, [TestDetailId] ASC ) INCLUDE ( [TimeStamp],[EndTime])

CREATE NONCLUSTERED INDEX [LoadTestTransactionDetail5] ON [dbo].[LoadTestTransactionDetail] ([LoadTestRunId] ASC,[TransactionId] ASC,[EndTime] ASC,[TimeStamp] ASC,[TestDetailId] ASC, [TransactionDetailId] ASC) INCLUDE ( [ElapsedTime])

CREATE NONCLUSTERED INDEX [LoadTestPageDetail4] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId] ASC,  [PageId] ASC,[InMeasurementInterval] ASC,[ResponseTime] DESC ) INCLUDE ([TestDetailId],[ResponseTimeGoal]) 

CREATE NONCLUSTERED INDEX [LoadTestPageDetail5] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId] ASC, [PageId] ASC, [TestDetailId] ASC, [EndTime] ASC, [Outcome] ASC, [TimeStamp] ASC, [PageDetailId] ASC) INCLUDE ( [ResponseTime])
CREATE NONCLUSTERED INDEX [LoadTestPageDetail6] ON [dbo].[LoadTestPageDetail] ([LoadTestRunId] ASC, [PageId] ASC, [GoalExceeded] ASC, [InMeasurementInterval] ASC)

CREATE NONCLUSTERED INDEX ix_LoadTestDetailMessage_LoadTestRunId_TestDetailId_PageDetailId__MessageTypeId ON
        dbo.LoadTestDetailMessage
        (
            [LoadTestRunId] ASC,
	    [TestDetailId] ASC,
	    [PageDetailId] ASC,
	    [MessageTypeId] ASC
        )

CREATE NONCLUSTERED INDEX ix_WebLoadTestRequestMap_RequestId_LoadTestRunId_TestCaseId ON
        dbo.WebLoadTestRequestMap
        (
            [RequestId] ASC,
            [LoadTestRunId] ASC
        )
        INCLUDE ( [TestCaseId])




/* Statistics to support recommendations */
CREATE STATISTICS [hind_98099390_6A] ON [dbo].[loadtestpagedetail] ([responsetime])


CREATE STATISTICS [hind_98099390_1A_3A_5A_6D] ON [dbo].[loadtestpagedetail] ([loadtestrunid], [testdetailid], [pageid], [responsetime])


ALTER TABLE [dbo].[LoadTestCase] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestMessage] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestThresholdMessage] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestPerformanceCounter] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestPerformanceCounterCategory] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestPerformanceCounterInstance] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestPerformanceCounterSample] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestRunAgent] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestRunInterval] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestScenario] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[WebLoadTestErrorDetail] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[WebLoadTestRequestMap] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[WebLoadTestTransaction] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestSqlTrace] ADD 
	 FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestSystemUnderTest] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)

ALTER TABLE [dbo].[LoadTestSystemUnderTestTag] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)

ALTER TABLE [dbo].[LoadTestTestLog] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)

ALTER TABLE [dbo].[LoadTestDataCollectorLog] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestFileAttachment] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


ALTER TABLE [dbo].[LoadTestFileAttachmentChunk] 
	ADD FOREIGN KEY 
	(
		[LoadTestRunId]
	) REFERENCES [dbo].[LoadTestRun] (
		[LoadTestRunId]
	)


CREATE TABLE [dbo].[LoadTestReport](
	[ReportId] [INT] IDENTITY(1,1) NOT NULL,
	[Name] [NVARCHAR](255) NOT NULL,
	[Description] [NVARCHAR](MAX) NULL,
	[LoadTestName] [NVARCHAR](255) NOT NULL,
	[LastRunId] [INT] NOT NULL,
	[SelectNewRuns] [BIT] NOT NULL,
	[LastModified] DATETIME NOT NULL,
	[LastModifiedBy] [NVARCHAR](255) NOT NULL,
	[ReportType] [TINYINT] NOT NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestReport] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[ReportId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestReport] TO PUBLIC


CREATE TABLE [dbo].[LoadTestReportRuns](
	[ReportId] [INT] NOT NULL,
	[LoadTestRunId] [INT] NOT NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestReportRuns] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[ReportId],
		[LoadTestRunId]
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestReportRuns] TO PUBLIC


CREATE TABLE [dbo].[LoadTestReportPage](	
	[PageId] [INT] IDENTITY(1,1) NOT NULL,
	[ReportId] [INT] NOT NULL,	
	[CategoryName] [nvarchar](255) NOT NULL,
	[CounterName] [nvarchar](255) NOT NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[LoadTestReportPage] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(		
		[PageId]		
	)  ON [PRIMARY] 


GRANT SELECT, INSERT, UPDATE ON [dbo].[LoadTestReportPage] TO PUBLIC
END
GO


-- Drop add re add the stored procedures and views

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByRequest]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByRequest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByAgent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByAgent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByTest]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByTest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesAll]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetErrorDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetErrorDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetTestCases]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetTestCases]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_DeleteLoadTestRun]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_DeleteLoadTestRun]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetAgents]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetAgents]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetCategories]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetCategories]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetInstanceSummaries]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetInstanceSummaries]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesTypeSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesTypeSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetRequestMap]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetRequestMap]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetRequestMap2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetRequestMap2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetSamplesForInstance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetSamplesForInstance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetFirstSampleForInstance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetFirstSampleForInstance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetLastSampleForInstance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetLastSampleForInstance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetTransactionMap]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetTransactionMap]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertSample]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertSqlTraceRow]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertSqlTraceRow]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateInstanceSummaryData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateInstanceSummaryData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetCompletedLoadTestRuns]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetCompletedLoadTestRuns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTestDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTestDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTestDetai2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTestDetai2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTransactionDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTransactionDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTransactionDetail2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTransactionDetail2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertPageDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertPageDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertPageDetail2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertPageDetail2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertLoadTestMessageType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertLoadTestMessageType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertLoadTestDetailMessage]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertLoadTestDetailMessage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetAvailableDetailTypes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetAvailableDetailTypes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTestPercentiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTestPercentiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTestSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTestSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTestSummary3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTestSummary3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTransactionPercentiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTransactionPercentiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTransactionSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTransactionSummary]

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateTransactionSummary3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateTransactionSummary3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePagePercentiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePagePercentiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePageSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePageSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePageSummary3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePageSummary3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePageByNetworkPercentiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePageByNetworkPercentiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePageSummaryByNetwork]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePageSummaryByNetwork]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdatePageSummaryByNetwork3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdatePageSummaryByNetwork3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateSummaryData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateSummaryData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateSummaryData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateSummaryData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateSummaryData2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateSummaryData2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_UpdateSummaryData3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_UpdateSummaryData3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_GrantDBAccess]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_GrantDBAccess]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByRequest2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByRequest2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByAgent2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByAgent2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByTest2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByTest2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesByType2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesByType2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_DeleteDataCollectorLogs]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_DeleteDataCollectorLogs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetMessagesAll2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetMessagesAll2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetTestLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetTestLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTestDetail2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTestDetail2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertTestLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertTestLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_InsertFileAttachmentChunk]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_InsertFileAttachmentChunk]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_CreateLoadTestReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_CreateLoadTestReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_UpdateLoadTestReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_UpdateLoadTestReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_FindLoadTestReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_FindLoadTestReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_QueryLoadTestReports]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_QueryLoadTestReports]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_QueryForInstanceCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_QueryForInstanceCount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_QueryLoadTestRuns]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_QueryLoadTestRuns]
GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_QueryLoadTestRunsById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_QueryLoadTestRunsById]
GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prc_QueryPossibleCountersForReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[prc_QueryPossibleCountersForReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetUniqueDetailIds]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetUniqueDetailIds]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetUserTestDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetUserTestDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetUserPageDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetUserPageDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetUserTransactionDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetUserTransactionDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_GetInitialDetailRange]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_GetInitialDetailRange]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryComputedCounterSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryComputedCounterSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryLoadTestPageSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryLoadTestPageSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryLoadTestTestCaseSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryLoadTestTestCaseSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryLoadTestTransactionSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryLoadTestTransactionSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryLoadTestRequestSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryLoadTestRequestSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Prc_QueryLoadTestScenarioSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Prc_QueryLoadTestScenarioSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestComputedCounterSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestComputedCounterSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestMessageView]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestMessageView]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestMessageSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestMessageSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestWebRequestCounterSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestWebRequestCounterSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestPageSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestPageSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestWebPageAndUserLoadCounterSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestWebPageAndUserLoadCounterSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTransactionSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestTransactionSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTransactionSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestTransactionSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestWebRequestCounterSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestWebRequestCounterSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestPageSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestPageSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTestCaseSample]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestTestCaseSample]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTestCaseSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestTestCaseSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestComputedCounterSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[LoadTestComputedCounterSummary]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTestResults]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestTestResults
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestTransactionResults]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestTransactionResults
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestPageResults]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestPageResults
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestPageResultsByNetwork]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestPageResultsByNetwork
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestMessageView2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestMessageView2
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestRequestSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestRequestSummary
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LoadTestScenarioSummary]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view LoadTestScenarioSummary
GO


-- Create views

CREATE VIEW [dbo].[LoadTestComputedCounterSample] AS
SELECT category.LoadTestRunId, category.MachineName, category.CategoryName, counter.CounterName, 
    instance.InstanceName, interval.IntervalStartTime, interval.IntervalEndTime, 
    countersample.CounterType, countersample.ComputedValue, countersample.RawValue, countersample.ThresholdRuleResult
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
WHERE countersample.ComputedValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestComputedCounterSample] TO PUBLIC
GO


CREATE VIEW [dbo].[LoadTestMessageView] AS
SELECT 
message.LoadTestRunId,
agent.AgentName,
scenario.ScenarioName,
testcase.TestCaseName,
requestmap.RequestUri,
message.MessageId,
message.MessageTimeStamp,
message.MessageType,
message.SubType,
message.MessageText,
message.StackTrace,
message.RequestId,
HasWebTestErrorDetail = 
    CASE ISNULL(detail.MessageId,-1)
	WHEN -1 THEN 'false'
	ELSE 'true'
    END
FROM LoadTestMessage as message
LEFT OUTER JOIN LoadTestCase AS testcase
    ON message.LoadTestRunId = testcase.LoadTestRunId
    AND message.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestScenario AS scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON message.LoadTestRunId = agent.LoadTestRunId
    AND message.AgentId = agent.AgentId
LEFT OUTER JOIN WebLoadTestRequestMap AS requestmap
    ON message.LoadTestRunId = requestmap.LoadTestRunId
    AND message.RequestId = requestmap.RequestId        
LEFT OUTER JOIN WebLoadTestErrorDetail AS detail
    ON message.LoadTestRunId = detail.LoadTestRunId
    AND message.MessageId = detail.MessageId
    AND message.AgentId = detail.AgentId        
GO

GRANT SELECT ON [dbo].[LoadTestMessageView] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestMessageView2] AS
SELECT 
message.LoadTestRunId,
agent.AgentName,
scenario.ScenarioName,
testcase.TestCaseName,
requestmap.RequestUri,
message.MessageId,
message.MessageTimeStamp,
message.MessageType,
message.SubType,
message.MessageText,
message.StackTrace,
message.RequestId,
HasWebTestErrorDetail = 
    CASE ISNULL(detail.MessageId,-1)
	WHEN -1 THEN 'false'
	ELSE 'true'
    END,
testLog.TestLogId
FROM LoadTestMessage as message
LEFT OUTER JOIN LoadTestCase AS testcase
    ON message.LoadTestRunId = testcase.LoadTestRunId
    AND message.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestScenario AS scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON message.LoadTestRunId = agent.LoadTestRunId
    AND message.AgentId = agent.AgentId
LEFT OUTER JOIN WebLoadTestRequestMap AS requestmap
    ON message.LoadTestRunId = requestmap.LoadTestRunId
    AND message.RequestId = requestmap.RequestId        
LEFT OUTER JOIN WebLoadTestErrorDetail AS detail
    ON message.LoadTestRunId = detail.LoadTestRunId
    AND message.MessageId = detail.MessageId
    AND message.AgentId = detail.AgentId        
LEFT OUTER JOIN LoadTestTestLog AS testLog
    ON message.LoadTestRunId = testLog.LoadTestRunId
    AND message.AgentId = testLog.AgentId     
    AND message.TestLogId = testLog.TestLogId

GO

GRANT SELECT ON [dbo].[LoadTestMessageView2] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestMessageSummary] AS
SELECT 
message.LoadTestRunId,
agent.AgentName,
scenario.ScenarioName,
testcase.TestCaseName,
requestmap.RequestUri,
message.MessageId,
message.MessageTimeStamp,
MessageType = 
    CASE message.MessageType
        WHEN 0 THEN 'TestError'
        WHEN 1 THEN 'Exception'
        WHEN 2 THEN 'HttpError'
        WHEN 3 THEN 'ValidationRuleError'
        WHEN 4 THEN 'ExtractionRuleError'
        WHEN 5 THEN 'Timeout'
        WHEN 6 THEN 'DataCollectionError'
        WHEN 7 THEN 'DataCollectionWarning'
        ELSE 'Unknown'
    END,
message.SubType,
message.MessageText,
message.StackTrace,
message.RequestId,
HasWebTestErrorDetail = 
    CASE ISNULL(detail.MessageId,-1)
      WHEN -1 THEN 'false'
      ELSE 'true'
    END
FROM LoadTestMessage as message
LEFT OUTER JOIN LoadTestCase AS testcase
    ON message.LoadTestRunId = testcase.LoadTestRunId
    AND message.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestScenario AS scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON message.LoadTestRunId = agent.LoadTestRunId
    AND message.AgentId = agent.AgentId
LEFT OUTER JOIN WebLoadTestRequestMap AS requestmap
    ON message.LoadTestRunId = requestmap.LoadTestRunId
    AND message.RequestId = requestmap.RequestId        
LEFT OUTER JOIN WebLoadTestErrorDetail AS detail
    ON message.LoadTestRunId = detail.LoadTestRunId
    AND message.MessageId = detail.MessageId
    AND message.AgentId = detail.AgentId 
GO

GRANT SELECT ON [dbo].[LoadTestMessageSummary] TO PUBLIC
GO


CREATE  VIEW [dbo].[LoadTestWebRequestCounterSample] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName, request.RequestUri, 
    interval.IntervalStartTime, interval.IntervalEndTime,
    countersample.CounterType, countersample.ComputedValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
INNER JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Request' and countersample.ComputedValue IS NOT NULL

GO

GRANT SELECT ON [dbo].[LoadTestWebRequestCounterSample] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestPageSample] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName, request.RequestUri, 
    interval.IntervalStartTime, interval.IntervalEndTime,
    countersample.ComputedValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
INNER JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Page' and countersample.ComputedValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestPageSample] TO PUBLIC
GO
 
CREATE VIEW [dbo].[LoadTestWebPageAndUserLoadCounterSample] AS

Select
	counter.loadtestrunid,
	instance.instanceName,
	request.RequestUri,
	interval.IntervalStartTime,
	(Select ComputedValue from LoadTestComputedCounterSample
		where (CounterName = 'User Load' and instanceName = '_total') 
		AND intervalstartTime = interval.IntervalStartTime) As UserLoad,
	countersample.ComputedValue As ResponseTime,
	(Select ComputedValue from LoadTestComputedCounterSample 
		where (countername = 'Requests / sec' and instanceName = instance.instancename)
		AND intervalstartTime = interval.IntervalStartTime) as RPS
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
INNER JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE counter.countername = 'Page Response Time' and 
countersample.ComputedValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestWebPageAndUserLoadCounterSample] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestTransactionSample] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName, transactions.TransactionName, 
    interval.IntervalStartTime, interval.IntervalEndTime,
    countersample.ComputedValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
INNER JOIN WebLoadTestTransaction AS transactions
    ON transactions.LoadTestRunId = instance.LoadTestRunId
    AND transactions.TransactionId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON transactions.LoadTestRunId = testcase.LoadTestRunId
    AND transactions.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Transaction' and countersample.ComputedValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestTransactionSample] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestTransactionSummary] AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       ISNULL(transactions.TransactionName,'_Total') as TransactionName,       
       instance.CumulativeValue
FROM  LoadTestRun as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN WebLoadTestTransaction AS transactions
    ON transactions.LoadTestRunId = instance.LoadTestRunId
    AND transactions.TransactionId = instance.LoadTestItemId
LEFT JOIN LoadTestCase As testcase
    ON transactions.LoadTestRunId = testcase.LoadTestRunId
    AND transactions.TestCaseId = testcase.TestCaseId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Transaction' and instance.CumulativeValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestTransactionSummary] TO PUBLIC
GO

CREATE  VIEW [dbo].[LoadTestWebRequestCounterSummary] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName, request.RequestUri, 
    instance.CumulativeValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
INNER JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Request' and instance.CumulativeValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestWebRequestCounterSummary] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestPageSummary] AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       ISNULL(request.RequestUri,'_Total') as RequestUri, 
       instance.CumulativeValue,
	   ISNULL(request.ResponseTimeGoal,0) AS ResponseTimeGoal
FROM       LoadTestRun AS run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
LEFT JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Page' and instance.CumulativeValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestPageSummary] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestComputedCounterSummary] AS
SELECT run.LoadTestName, category.LoadTestRunId, category.MachineName, category.CategoryName, counter.CounterName, 
    counter.HigherIsBetter,instance.InstanceName, instance.CumulativeValue, instance.OverallThresholdRuleResult
FROM LoadTestRun as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE instance.cumulativeValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestComputedCounterSummary] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestTestCaseSample] AS
SELECT category.LoadTestRunId, counter.CounterName,
    scenario.ScenarioName, testcase.TestCaseName,  
    interval.IntervalStartTime, interval.IntervalEndTime,
    countersample.ComputedValue
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestPerformanceCounterSample AS countersample 
    ON countersample.InstanceId = instance.InstanceId
    AND countersample.LoadTestRunId = instance.LoadTestRunId
INNER JOIN LoadTestRunInterval AS interval 
    ON interval.LoadTestRunId = countersample.LoadTestRunId
    AND interval.TestRunIntervalId = countersample.TestRunIntervalId
INNER JOIN LoadTestCase As testcase
    ON testcase.LoadTestRunId = instance.LoadTestRunId
    AND testcase.TestCaseId = instance.LoadTestItemId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Test' and countersample.ComputedValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestTestCaseSample] TO PUBLIC
GO

CREATE VIEW LoadTestTestCaseSummary AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       instance.CumulativeValue
FROM   LoadTestRun AS run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN LoadTestCase As testcase
    ON counter.LoadTestRunId = testcase.LoadTestRunId
    AND testcase.TestCaseId = instance.LoadTestItemId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Test' and instance.CumulativeValue IS NOT NULL
GO

GRANT SELECT ON [dbo].[LoadTestTestCaseSummary] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestRequestSummary] AS
SELECT run.LoadTestName, 
       category.LoadTestRunId, 
       counter.CounterName,
       ISNULL(scenario.ScenarioName,'_Total') as ScenarioName,
       ISNULL(testcase.TestCaseName,'_Total') as TestCaseName, 
       ISNULL(request.RequestUri,'_Total') as RequestUri, 
    instance.CumulativeValue
FROM       LoadTestRun AS run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
LEFT JOIN WebLoadTestRequestMap AS request
    ON request.LoadTestRunId = instance.LoadTestRunId
    AND request.RequestId = instance.LoadTestItemId
LEFT JOIN LoadTestCase As testcase
    ON request.LoadTestRunId = testcase.LoadTestRunId
    AND request.TestCaseId = testcase.TestCaseId
LEFT JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE category.CategoryName = 'LoadTest:Request' and instance.CumulativeValue IS NOT NULL

GO
GRANT SELECT ON [dbo].[LoadTestRequestSummary] TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestScenarioSummary] AS
SELECT run.LoadTestName AS LoadTestName, 
       category.LoadTestRunId AS LoadTestRunId, 
       counter.CounterName AS CounterName,
       CASE instance.InstanceName WHEN '_Total' THEN '_Total' ELSE scenario.ScenarioName END AS ScenarioName,         
       instance.CumulativeValue AS CumulativeValue
FROM       LoadTestRun AS run
INNER JOIN LoadTestScenario As scenario
    ON run.LoadTestRunId = scenario.LoadTestRunId    
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON scenario.LoadTestRunId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
    AND (instance.InstanceName = scenario.ScenarioName OR instance.InstanceName = '_Total')
WHERE category.CategoryName = 'LoadTest:Scenario' 
      AND instance.CumulativeValue IS NOT NULL
GROUP BY LoadTestName, category.LoadTestRunId, CounterName,CASE instance.InstanceName WHEN '_Total' THEN '_Total' ELSE scenario.ScenarioName END,CumulativeValue
      
GO
GRANT SELECT ON [dbo].[LoadTestScenarioSummary] TO PUBLIC
GO


-- New views

CREATE VIEW LoadTestTestResults AS 
SELECT
    testSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName,  
    testSummary.TestsRun, 
    testSummary.Minimum, 
    testSummary.Average,
    testSummary.Percentile90, 
    testSummary.Percentile95, 
    testSummary.Maximum
FROM LoadTestTestSummaryData AS testSummary 
INNER JOIN LoadTestCase as testCase
    ON testSummary.LoadTestRunId = testCase.LoadTestRunId
    AND testSummary.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO

GRANT SELECT ON [dbo].LoadTestTestResults TO PUBLIC
GO

CREATE VIEW LoadTestTransactionResults AS 
SELECT
    transactionSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName, 
    transactions.TransactionName,
    transactionSummary.TransactionCount, 
    transactionSummary.Minimum, 
    transactionSummary.Average,
    transactionSummary.Percentile90, 
    transactionSummary.Percentile95, 
    transactionSummary.Maximum
FROM LoadTestTransactionSummaryData AS transactionSummary 
INNER JOIN WebLoadTestTransaction AS transactions 
    ON transactionSummary.LoadTestRunId = transactions.LoadTestRunId
    AND transactionSummary.TransactionId = transactions.TransactionId
INNER JOIN LoadTestCase as testCase
    ON transactions.LoadTestRunId = testCase.LoadTestRunId
    AND transactions.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO

GRANT SELECT ON [dbo].LoadTestTransactionResults TO PUBLIC
GO

CREATE VIEW [dbo].[LoadTestTransactionResults2] AS 
SELECT
    transactionSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName, 
    transactions.TransactionName,
    transactionSummary.TransactionCount, 
    transactionSummary.Minimum, 
    transactionSummary.Average,    
    transactionSummary.Percentile90, 
    transactionSummary.Percentile95, 
    transactionSummary.Maximum,
    transactionSummary.Median,
    transactionSummary.Percentile99,
    transactionSummary.StandardDeviation,
    transactionSummary.AvgTransactionTime
FROM LoadTestTransactionSummaryData AS transactionSummary 
INNER JOIN WebLoadTestTransaction AS transactions 
    ON transactionSummary.LoadTestRunId = transactions.LoadTestRunId
    AND transactionSummary.TransactionId = transactions.TransactionId
INNER JOIN LoadTestCase as testCase
    ON transactions.LoadTestRunId = testCase.LoadTestRunId
    AND transactions.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO

GRANT SELECT ON [dbo].LoadTestTransactionResults2 TO PUBLIC
GO

CREATE VIEW LoadTestPageResults AS 
SELECT
    pageSummary.LoadTestRunId, 
    scenario.ScenarioName,
    testCase.TestCaseName, 
    requestMap.RequestUri, 
    pageSummary.PageCount, 
    pageSummary.Minimum, 
    pageSummary.Average,
    pageSummary.Percentile90, 
    pageSummary.Percentile95, 
    pageSummary.Maximum
FROM LoadTestPageSummaryData AS pageSummary 
INNER JOIN WebLoadTestRequestMap AS requestMap 
    ON pageSummary.LoadTestRunId = requestMap.LoadTestRunId
    AND pageSummary.PageId = requestMap.requestId
INNER JOIN LoadTestCase as testCase
    ON requestMap.LoadTestRunId = testCase.LoadTestRunId
    AND requestMap.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
GO

GRANT SELECT ON [dbo].LoadTestPageResults TO PUBLIC
GO

CREATE VIEW LoadTestPageResultsByNetwork AS 
SELECT
    pageSummary.LoadTestRunId,
    scenario.ScenarioName,
    testCase.TestCaseName, 
    requestMap.RequestUri,
    networks.NetworkName,
    pageSummary.PageCount,
    pageSummary.Minimum,
    pageSummary.Average,
    pageSummary.Percentile90,
    pageSummary.Percentile95,
    pageSummary.Maximum,
    pageSummary.Goal,
    pageSummary.PagesMeetingGoal
FROM LoadTestPageSummaryByNetwork AS pageSummary
INNER JOIN WebLoadTestRequestMap AS requestMap 
    ON pageSummary.LoadTestRunId = requestMap.LoadTestRunId
    AND pageSummary.PageId = requestMap.requestId
INNER JOIN LoadTestCase as testCase
    ON requestMap.LoadTestRunId = testCase.LoadTestRunId
    AND requestMap.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
INNER JOIN LoadTestNetworks as networks
    ON pageSummary.LoadTestRunId = networks.LoadTestRunId
    AND pageSummary.NetworkId = networks.NetworkId
GO

GRANT SELECT ON [dbo].LoadTestPageResultsByNetwork TO PUBLIC
GO

CREATE VIEW LoadTestPageResultsByNetwork2 AS 
SELECT
    pageSummary.LoadTestRunId,
    scenario.ScenarioName,
    testCase.TestCaseName, 
    requestMap.RequestUri,
    networks.NetworkName,
    pageSummary.PageCount,
    pageSummary.Minimum,
    pageSummary.Average,
    pageSummary.Median,
    pageSummary.Percentile90,
    pageSummary.Percentile95,
    pageSummary.Percentile99,
    pageSummary.Maximum,
    pageSummary.StandardDeviation,
    pageSummary.Goal,
    pageSummary.PagesMeetingGoal
FROM LoadTestPageSummaryByNetwork AS pageSummary
INNER JOIN WebLoadTestRequestMap AS requestMap 
    ON pageSummary.LoadTestRunId = requestMap.LoadTestRunId
    AND pageSummary.PageId = requestMap.requestId
INNER JOIN LoadTestCase as testCase
    ON requestMap.LoadTestRunId = testCase.LoadTestRunId
    AND requestMap.TestCaseId = testCase.TestCaseId
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
INNER JOIN LoadTestNetworks as networks
    ON pageSummary.LoadTestRunId = networks.LoadTestRunId
    AND pageSummary.NetworkId = networks.NetworkId
GO

GRANT SELECT ON [dbo].LoadTestPageResultsByNetwork2 TO PUBLIC
GO

CREATE PROCEDURE Prc_GetCompletedLoadTestRuns
AS
SELECT LoadTestRunId, 
	RunId,
	LoadTestName,
	Description,
	StartTime,
	EndTime,
	IsLocalRun,
	ControllerName
FROM LoadTestRun
WHERE 
LoadTestName IS NOT NULL AND 
StartTime IS NOT NULL AND
EndTime IS NOT NULL
ORDER BY LoadTestRunId

GRANT EXECUTE ON Prc_GetCompletedLoadTestRuns TO PUBLIC
GO

CREATE PROCEDURE Prc_DeleteDataCollectorLogs @LoadTestRunId int
AS
BEGIN
	DECLARE @DataCollectorLogId int
	
	DECLARE LogCursor CURSOR FOR
		SELECT DataCollectorLogId FROM LoadTestDataCollectorLog WHERE LoadTestRunId = @LoadTestRunId

	OPEN LogCursor
	FETCH NEXT FROM LogCursor INTO @DataCollectorLogId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   DECLARE @DropStmt nvarchar(255)
	   Set @DropStmt = N'DROP TABLE LoadTestLogData_Run' + RTRIM(CONVERT(nvarchar, @LoadTestRunId)) + N'_Log' + RTRIM(CONVERT(nvarchar, @DataCollectorLogId));
	   EXEC (@DropStmt);
	   FETCH NEXT FROM LogCursor INTO @DataCollectorLogId
	END
	
	CLOSE LogCursor
	DEALLOCATE LogCursor
END

GRANT EXECUTE ON Prc_DeleteDataCollectorLogs TO PUBLIC
GO

CREATE PROCEDURE Prc_DeleteLoadTestRun @LoadTestRunId int
AS
BEGIN

    -- First delete the data collector log tables
    EXEC Prc_DeleteDataCollectorLogs @LoadTestRunId

    ----------------------------------------------------------------
    -- TempTable to handle the tables to use for delete.
    -- rownum will insure we retrieve in the right order
    -- so foreign key constraints don't bite us
    DECLARE @Temp TABLE
          (rownum int
           , tableToUse nvarchar(50))

    -- Build out temp table, 
    INSERT INTO @temp VALUES(1, 'LoadTestFileAttachmentChunk')
    INSERT INTO @temp VALUES(2, 'LoadTestFileAttachment')
    INSERT INTO @temp VALUES(3, 'LoadTestDataCollectorLog')
    INSERT INTO @temp VALUES(4, 'LoadTestTestLog')
    INSERT INTO @temp VALUES(5, 'LoadTestBrowsers')
    INSERT INTO @temp VALUES(6, 'LoadTestNetworks')
    INSERT INTO @temp VALUES(7, 'LoadTestDetailMessage')
    INSERT INTO @temp VALUES(8, 'LoadTestTestDetail')
    INSERT INTO @temp VALUES(9, 'LoadTestPageDetail')
    INSERT INTO @temp VALUES(10, 'LoadTestTransactionDetail')
    INSERT INTO @temp VALUES(11, 'LoadTestTestSummaryData')
    INSERT INTO @temp VALUES(12, 'LoadTestTransactionSummaryData')
    INSERT INTO @temp VALUES(13, 'LoadTestPageSummaryData')
    INSERT INTO @temp VALUES(14, 'LoadTestPageSummaryByNetwork')
    INSERT INTO @temp VALUES(15, 'LoadTestCase')
    INSERT INTO @temp VALUES(16, 'LoadTestMessage')
    INSERT INTO @temp VALUES(17, 'LoadTestMessageType')
    INSERT INTO @temp VALUES(18, 'LoadTestThresholdMessage')
    INSERT INTO @temp VALUES(19, 'LoadTestPerformanceCounter')
    INSERT INTO @temp VALUES(20, 'LoadTestPerformanceCounterCategory')
    INSERT INTO @temp VALUES(21, 'LoadTestPerformanceCounterInstance')
    INSERT INTO @temp VALUES(22, 'LoadTestPerformanceCounterSample')
    INSERT INTO @temp VALUES(23, 'LoadTestRunAgent')
    INSERT INTO @temp VALUES(24, 'LoadTestRunInterval')
    INSERT INTO @temp VALUES(25, 'LoadTestScenario')
    INSERT INTO @temp VALUES(26, 'LoadTestSqlTrace')
    INSERT INTO @temp VALUES(27, 'WebLoadTestErrorDetail')
    INSERT INTO @temp VALUES(28, 'WebLoadTestTransaction')
    INSERT INTO @temp VALUES(29, 'WebLoadTestRequestMap')
    INSERT INTO @temp VALUES(30, 'LoadTestSystemUnderTestTag')
    INSERT INTO @temp VALUES(31, 'LoadTestSystemUnderTest')
    INSERT INTO @temp VALUES(32, 'LoadTestRun')

    ----------------------------------------------------------------
    -- Variables to control the behavior of the query
    DECLARE @iEndOfTable int
    DECLARE @iRowsToDelete int
    DECLARE @iRownum int
    DECLARE @tableName nvarchar(50)
    DECLARE @QueryToUse nvarchar(500)

    set @iEndOfTable = 0
    SET @iRowsToDelete = 10000
    SET @iRownum = 1


    WHILE @iRownum < 33
    BEGIN
          SELECT @tableName = tableToUse FROM @TEMP WHERE rownum = @iRownum
          WHILE @iEndOfTable = 0
          BEGIN
                SET @QueryToUse = 'DELETE TOP(' + CAST(@iRowsToDelete AS nvarchar(10)) + ') FROM ' +
                            @tableName + ' WHERE LoadTestRunId = ' +  CAST(@LoadTestRunId AS nvarchar(10))
                EXECUTE sp_executesql @QueryToUse
                IF (@@rowcount < @iRowsToDelete)
                      SET @iEndOfTable = 1
          END
          SET @iRownum = @iRownum + 1
          SET @iEndOfTable = 0
    END
END
GO

GRANT EXECUTE ON Prc_DeleteLoadTestRun TO PUBLIC
GO

CREATE PROCEDURE Prc_GetAgents @LoadTestRunId int
AS
SELECT AgentId, AgentName 
FROM LoadTestRunAgent
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY AgentId
GO

GRANT EXECUTE ON Prc_GetAgents TO PUBLIC
GO

CREATE PROCEDURE Prc_GetCategories @LoadTestRunId int
AS
SELECT CounterCategoryId, CategoryName, MachineName, StartTimeStamp100nSec
FROM LoadTestPerformanceCounterCategory
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY CounterCategoryId
GO

GRANT EXECUTE ON Prc_GetCategories TO PUBLIC
GO

CREATE PROCEDURE Prc_GetInstanceSummaries @LoadTestRunId int
AS
SELECT 
instance.InstanceId, 
category.MachineName, 
category.CategoryName, 
counter.CounterName, 
instance.InstanceName,
instance.CumulativeValue,
instance.OverallThresholdRuleResult
FROM LoadTestPerformanceCounterCategory AS category 
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE category.LoadTestRunId = @LoadTestRunId
ORDER BY category.MachineName, category.CategoryName, counter.CounterName, instance.InstanceName
GO

GRANT EXECUTE ON Prc_GetInstanceSummaries TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesTypeSummary
	@LoadTestRunId int
AS
SELECT DISTINCT MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @LoadTestRunId
GROUP BY MessageType, SubType
ORDER BY Count DESC

GO
GRANT EXECUTE ON Prc_GetMessagesTypeSummary TO PUBLIC
GO
CREATE PROCEDURE Prc_GetRequestMap @LoadTestRunId int
AS
SELECT 
RequestId,
TestCaseId,
RequestUri
FROM WebLoadTestRequestMap
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY RequestId
GO

GRANT EXECUTE ON Prc_GetRequestMap TO PUBLIC
GO

CREATE PROCEDURE Prc_GetRequestMap2 @LoadTestRunId int
AS
SELECT 
RequestId,
TestCaseId,
RequestUri,
ResponseTimeGoal
FROM WebLoadTestRequestMap
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY RequestId
GO

GRANT EXECUTE ON Prc_GetRequestMap2 TO PUBLIC
GO


CREATE PROCEDURE Prc_GetSamplesForInstance @LoadTestRunId int, @InstanceId int
AS
SELECT
interval.IntervalEndTime,
samples.RawValue, 
samples.BaseValue, 
samples.CounterFrequency, 
samples.SystemFrequency,
samples.SampleTimeStamp,
samples.SampleTimeStamp100nSec,
samples.CounterType,
samples.ThresholdRuleResult
FROM LoadTestPerformanceCounterSample as samples
LEFT OUTER JOIN LoadTestRunInterval AS interval
    ON samples.LoadTestRunId = interval.LoadTestRunId
    AND samples.TestRunIntervalId = interval.TestRunIntervalId
WHERE samples.LoadTestRunId = @LoadTestRunId
AND samples.InstanceId = @InstanceId
ORDER BY samples.TestRunIntervalId
GO

GRANT EXECUTE ON Prc_GetSamplesForInstance TO PUBLIC
GO

CREATE PROCEDURE Prc_GetFirstSampleForInstance @LoadTestRunId int, @InstanceId int
AS
SELECT TOP 1
interval.IntervalEndTime,
samples.RawValue, 
samples.BaseValue, 
samples.CounterFrequency, 
samples.SystemFrequency,
samples.SampleTimeStamp,
samples.SampleTimeStamp100nSec,
samples.CounterType,
samples.ThresholdRuleResult
FROM LoadTestPerformanceCounterSample as samples
LEFT OUTER JOIN LoadTestRunInterval AS interval
    ON samples.LoadTestRunId = interval.LoadTestRunId
    AND samples.TestRunIntervalId = interval.TestRunIntervalId
WHERE samples.LoadTestRunId = @LoadTestRunId
AND samples.InstanceId = @InstanceId
ORDER BY samples.TestRunIntervalId
GO

GRANT EXECUTE ON Prc_GetFirstSampleForInstance TO PUBLIC
GO


CREATE PROCEDURE Prc_GetLastSampleForInstance @LoadTestRunId int, @InstanceId int
AS
SELECT TOP 1
interval.IntervalEndTime,
samples.RawValue, 
samples.BaseValue, 
samples.CounterFrequency, 
samples.SystemFrequency,
samples.SampleTimeStamp,
samples.SampleTimeStamp100nSec,
samples.CounterType,
samples.ThresholdRuleResult
FROM LoadTestPerformanceCounterSample as samples
LEFT OUTER JOIN LoadTestRunInterval AS interval
    ON samples.LoadTestRunId = interval.LoadTestRunId
    AND samples.TestRunIntervalId = interval.TestRunIntervalId
WHERE samples.LoadTestRunId = @LoadTestRunId
AND samples.InstanceId = @InstanceId
ORDER BY samples.TestRunIntervalId DESC
GO

GRANT EXECUTE ON Prc_GetLastSampleForInstance TO PUBLIC
GO


CREATE  PROCEDURE Prc_GetTransactionMap @LoadTestRunId int
AS
SELECT 
TransactionId,
TestCaseId,
TransactionName
FROM WebLoadTestTransaction
WHERE LoadTestRunId = @LoadTestRunId
ORDER BY TransactionId
GO

GRANT EXECUTE ON Prc_GetTransactionMap TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertSample
	@LoadTestRunId int,
	@TestRunIntervalId int,
	@InstanceId int,
	@ComputedValue real,
	@RawValue bigint,
	@BaseValue bigint,
	@CounterFrequency bigint,
	@SystemFrequency bigint,
	@SampleTimeStamp bigint,
	@SampleTimeStamp100nSec bigint,
	@CounterType int,
	@ThresholdRuleResult tinyint,
	@ThresholdRuleMessageId int
AS
INSERT INTO LoadTestPerformanceCounterSample
(
	LoadTestRunId,
	TestRunIntervalId,
	InstanceId,
	ComputedValue,
	RawValue,
	BaseValue,
	CounterFrequency,
	SystemFrequency,
	SampleTimeStamp,
	SampleTimeStamp100nSec,
	CounterType,
	ThresholdRuleResult,
	ThresholdRuleMessageId
)
VALUES(
	@LoadTestRunId,
	@TestRunIntervalId,
	@InstanceId,
	@ComputedValue,
	@RawValue,
	@BaseValue,
	@CounterFrequency,
	@SystemFrequency,
	@SampleTimeStamp,
	@SampleTimeStamp100nSec,
	@CounterType,
	@ThresholdRuleResult,
	@ThresholdRuleMessageId
)
GO

GRANT EXECUTE ON Prc_InsertSample TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertSqlTraceRow 
	@LoadTestRunId int,
	@TextData ntext,
	@Duration bigint,
	@StartTime datetime,
	@EndTime datetime,
	@Reads bigint,
	@Writes bigint,
	@CPU int,
	@EventClass int
AS
INSERT INTO LoadTestSqlTrace
(
	LoadTestRunId,
	TextData,
	Duration,
	StartTime,
	EndTime,
	Reads,
	Writes,
	CPU,
	EventClass
)
VALUES(
	@LoadTestRunId,
	@TextData,
	@Duration,
	@StartTime,
	@EndTime,
	@Reads,
	@Writes,
	@CPU,
	@EventClass
)
GO

GRANT EXECUTE ON Prc_InsertSqlTraceRow TO PUBLIC
GO
    
CREATE PROCEDURE Prc_UpdateInstanceSummaryData
	@LoadTestRunId int,
	@InstanceId int,
	@CumulativeValue float,
	@OverallThresholdRuleResult tinyint
AS
UPDATE LoadTestPerformanceCounterInstance
	SET CumulativeValue = @CumulativeValue,
	OverallThresholdRuleResult = @OverallThresholdRuleResult
	WHERE LoadTestRunId = @LoadTestRunId AND InstanceId = @InstanceId
GO

GRANT EXECUTE ON Prc_UpdateInstanceSummaryData TO PUBLIC
GO


CREATE PROCEDURE Prc_GetMessagesByRequest
	@LoadTestRunId int, @RequestId int
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId AND
RequestId = @RequestId
ORDER BY AgentName, MessageId
GO

GRANT EXECUTE ON Prc_GetMessagesByRequest TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByRequest2
	@LoadTestRunId int, @RequestId int
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId AND
RequestId = @RequestId
ORDER BY AgentName, MessageId
GO

GRANT EXECUTE ON Prc_GetMessagesByRequest2 TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByAgent
	@LoadTestRunId int, @AgentName nvarchar(255)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName
ORDER BY AgentName, MessageId
GO

GRANT EXECUTE ON Prc_GetMessagesByAgent TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByAgent2
	@LoadTestRunId int, @AgentName nvarchar(255)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName
ORDER BY AgentName, MessageId
GO

GRANT EXECUTE ON Prc_GetMessagesByAgent2 TO PUBLIC
GO


CREATE PROCEDURE Prc_GetMessagesByTest
	@LoadTestRunId int, @ScenarioName nvarchar(64), @TestCaseName nvarchar(64)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId AND
ScenarioName = @ScenarioName AND
TestCaseName = @TestCaseName
ORDER BY AgentName, ScenarioName, TestCaseName
GO

GRANT EXECUTE ON Prc_GetMessagesByTest TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByTest2
	@LoadTestRunId int, @ScenarioName nvarchar(64), @TestCaseName nvarchar(64)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId AND
ScenarioName = @ScenarioName AND
TestCaseName = @TestCaseName
ORDER BY AgentName, ScenarioName, TestCaseName
GO

GRANT EXECUTE ON Prc_GetMessagesByTest2 TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByType
	@LoadTestRunId int, @MessageType tinyint, @SubType nvarchar(64)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId AND
MessageType = @MessageType AND
SubType = @SubType
ORDER BY AgentName, MessageType, SubType
GO

GRANT EXECUTE ON Prc_GetMessagesByType TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesByType2
	@LoadTestRunId int, @MessageType tinyint, @SubType nvarchar(64)
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId AND
MessageType = @MessageType AND
SubType = @SubType
ORDER BY AgentName, MessageType, SubType
GO

GRANT EXECUTE ON Prc_GetMessagesByType2 TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesAll
	@LoadTestRunId int
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail
FROM LoadTestMessageView
WHERE
LoadTestRunId = @LoadTestRunId
ORDER BY AgentName, MessageType, SubType
GO

GRANT EXECUTE ON Prc_GetMessagesAll TO PUBLIC
GO

CREATE PROCEDURE Prc_GetMessagesAll2
	@LoadTestRunId int
AS
SELECT 
AgentName,
ScenarioName,
TestCaseName,
RequestUri,
MessageId,
MessageTimeStamp,
MessageType,
SubType,
MessageText,
StackTrace,
HasWebTestErrorDetail,
TestLogId
FROM LoadTestMessageView2
WHERE
LoadTestRunId = @LoadTestRunId
ORDER BY AgentName, MessageType, SubType
GO

GRANT EXECUTE ON Prc_GetMessagesAll2 TO PUBLIC
GO

CREATE PROCEDURE Prc_GetErrorDetail
	@LoadTestRunId int, @AgentName nvarchar(255), @MessageId int
AS
SELECT
WebTestRequestResult
FROM WebLoadTestErrorDetail as detail
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON detail.LoadTestRunId = agent.LoadTestRunId
    AND detail.AgentId = agent.AgentId
WHERE
detail.LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName AND
MessageId = @MessageId
GO

GRANT EXECUTE ON Prc_GetErrorDetail TO PUBLIC
GO

CREATE PROCEDURE Prc_GetTestLog
	@LoadTestRunId int, @AgentName nvarchar(255), @TestLogId int
AS
SELECT
testLog.TestLog,
testcase.TestElement
FROM LoadTestTestLog as testLog
LEFT OUTER JOIN LoadTestCase AS testcase
    ON testLog.LoadTestRunId = testcase.LoadTestRunId
    AND testLog.TestCaseId = testcase.TestCaseId
LEFT OUTER JOIN LoadTestRunAgent AS agent
    ON testLog.LoadTestRunId = agent.LoadTestRunId
    AND testLog.AgentId = agent.AgentId
WHERE
testLog.LoadTestRunId = @LoadTestRunId AND
AgentName = @AgentName AND
TestLogId = @TestLogId
GO

GRANT EXECUTE ON Prc_GetTestLog TO PUBLIC
GO


CREATE PROCEDURE Prc_GetTestCases @LoadTestRunId int
AS
SELECT 
testcase.TestCaseId, 
scenario.ScenarioName,
testcase.TestCaseName
FROM LoadTestCase AS testcase 
INNER JOIN LoadTestScenario As scenario
    ON testcase.LoadTestRunId = scenario.LoadTestRunId
    AND testcase.ScenarioId = scenario.ScenarioId
WHERE testcase.LoadTestRunId = @LoadTestRunId
ORDER BY testcase.TestCaseId
GO

GRANT EXECUTE ON Prc_GetTestCases TO PUBLIC
GO

-- New stored procedures

CREATE PROCEDURE Prc_InsertTestDetail
	@LoadTestRunId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TestCaseId int,
	@ElapsedTime float,
        @AgentId int,
        @BrowserId int,
        @NetworkId int
AS
INSERT INTO LoadTestTestDetail
(
	LoadTestRunId,
	TestDetailId,
	TimeStamp,
	TestCaseId,
	ElapsedTime,
        AgentId,
        BrowserId,
        NetworkId
)
VALUES(
	@LoadTestRunId,
	@TestDetailId,
	@TimeStamp,
	@TestCaseId,
	@ElapsedTime,
        @AgentId,
        @BrowserId,
        @NetworkId
)
GO
GRANT EXECUTE ON Prc_InsertTestDetail TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertTestDetail2
	@LoadTestRunId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TestCaseId int,
	@ElapsedTime float,
    @AgentId int,
    @BrowserId int,
    @NetworkId int,
    @Outcome tinyint,
    @TestLogId int,
    @UserId int,
    @EndTime datetime,
	@InMeasurementInterval bit     
AS
INSERT INTO LoadTestTestDetail
(
	LoadTestRunId,
	TestDetailId,
	TimeStamp,
	TestCaseId,
	ElapsedTime,
    AgentId,
    BrowserId,
    NetworkId,
    Outcome,
    TestLogId,
    UserId,
    EndTime,
	InMeasurementInterval
)
VALUES(
	@LoadTestRunId,
	@TestDetailId,
	@TimeStamp,
	@TestCaseId,
	@ElapsedTime,
    @AgentId,
    @BrowserId,
    @NetworkId,
    @Outcome,
    @TestLogId,
    @UserId,
    @EndTime,
	@InMeasurementInterval
)
GO
GRANT EXECUTE ON Prc_InsertTestDetail2 TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertTransactionDetail
	@LoadTestRunId int,
	@TransactionDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@TransactionId int,
	@ElapsedTime float
AS
INSERT INTO LoadTestTransactionDetail
(
	LoadTestRunId,
	TransactionDetailId,
	TestDetailId,
	TimeStamp,
	TransactionId,
	ElapsedTime
)
VALUES(
	@LoadTestRunId,
	@TransactionDetailId,
	@TestDetailId,
	@TimeStamp,
	@TransactionId,
	@ElapsedTime
)
GO
GRANT EXECUTE ON Prc_InsertTransactionDetail TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertPageDetail
	@LoadTestRunId int,
	@PageDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
	@PageId int,
	@ResponseTime float,
	@ResponseTimeGoal float,
	@GoalExceeded bit
AS
INSERT INTO LoadTestPageDetail
(
	LoadTestRunId,
	PageDetailId,
	TestDetailId,
	TimeStamp,
	PageId,
	ResponseTime,
	ResponseTimeGoal,
	GoalExceeded
)
VALUES(
	@LoadTestRunId,
	@PageDetailId,
	@TestDetailId,
	@TimeStamp,
	@PageId,
	@ResponseTime,
	@ResponseTimeGoal,
	@GoalExceeded
)
GO
GRANT EXECUTE ON Prc_InsertPageDetail TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_InsertTransactionDetail2]
	@LoadTestRunId int,
	@TransactionDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
        @EndTime datetime,
	@TransactionId int,
	@ElapsedTime float,
	@InMeasurementInterval bit,
        @ResponseTime float    
AS
INSERT INTO LoadTestTransactionDetail
(
	LoadTestRunId,
	TransactionDetailId,
	TestDetailId,
	TimeStamp,
        EndTime,
	TransactionId,
	ElapsedTime,
	InMeasurementInterval,
        ResponseTime  
)
VALUES(
	@LoadTestRunId,
	@TransactionDetailId,
	@TestDetailId,
	@TimeStamp,
        @EndTime,
	@TransactionId,
	@ElapsedTime,
	@InMeasurementInterval,
	@ResponseTime
    
)
GO
GRANT EXECUTE ON Prc_InsertTransactionDetail2 TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_InsertPageDetail2]
	@LoadTestRunId int,
	@PageDetailId int,
	@TestDetailId int,
	@TimeStamp datetime,
    @EndTime datetime,
	@PageId int,
	@ResponseTime float,
	@ResponseTimeGoal float,
	@GoalExceeded bit,
    @Outcome tinyint,
	@InMeasurementInterval bit
AS
INSERT INTO LoadTestPageDetail
(
	LoadTestRunId,
	PageDetailId,
	TestDetailId,
	TimeStamp,
    EndTime,
	PageId,
	ResponseTime,
	ResponseTimeGoal,
	GoalExceeded,
    Outcome,
	InMeasurementInterval
)
VALUES(
	@LoadTestRunId,
	@PageDetailId,
	@TestDetailId,
	@TimeStamp,
    @EndTime,
	@PageId,
	@ResponseTime,
	@ResponseTimeGoal,
	@GoalExceeded,
    @Outcome,
	@InMeasurementInterval
)
GO
GRANT EXECUTE ON Prc_InsertPageDetail2 TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_InsertLoadTestMessageType]
	@LoadTestRunId int,
        @MessageTypeId int, 
        @MessageType tinyint, 
        @SubType nvarchar(64)
AS
INSERT INTO LoadTestMessageType
(
	LoadTestRunId,
	MessageTypeId,
	MessageType,
        SubType 
)
VALUES(
	@LoadTestRunId,
	@MessageTypeId,
	@MessageType,
        @SubType    
)
GO
GRANT EXECUTE ON Prc_InsertLoadTestMessageType TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_InsertLoadTestDetailMessage]
	@LoadTestRunId int,
        @LoadTestDetailMessageId int,
        @TestDetailId int, 
        @PageDetailId int,
        @MessageTypeId int
AS
INSERT INTO LoadTestDetailMessage
(
	LoadTestRunId,
        LoadTestDetailMessageId,
	TestDetailId,
	PageDetailId,
	MessageTypeId 
)
VALUES(
	@LoadTestRunId,
        @LoadTestDetailMessageId,
	@TestDetailId,
	@PageDetailId,
	@MessageTypeId
)
GO
GRANT EXECUTE ON Prc_InsertLoadTestDetailMessage TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertTestLog
    @LoadTestRunId int,
    @AgentId int,
    @TestCaseId int,
    @TestLogId int,
    @TestLog image      
AS
INSERT INTO LoadTestTestLog
(
    LoadTestRunId,
    AgentId,
    TestCaseId,
    TestLogId,
    TestLog
)
VALUES(
    @LoadTestRunId,
    @AgentId,
    @TestCaseId,
    @TestLogId,
    @TestLog
)
GO

GRANT EXECUTE ON Prc_InsertTestLog TO PUBLIC
GO

CREATE PROCEDURE Prc_InsertFileAttachmentChunk
    @LoadTestRunId int,
    @FileAttachmentId int,
    @StartOffset bigint,
    @EndOffset bigint,
    @ChunkLength bigint,
    @ChunkBytes image      
AS
INSERT INTO LoadTestFileAttachmentChunk
(
    LoadTestRunId,
    FileAttachmentId,
    StartOffset,
    EndOffset,
    ChunkLength,
    ChunkBytes
)
VALUES(
    @LoadTestRunId,
    @FileAttachmentId,
    @StartOffset,
    @EndOffset,
    @ChunkLength,
    @ChunkBytes
)
GO

GRANT EXECUTE ON Prc_InsertFileAttachmentChunk TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateTestPercentiles @LoadTestRunId int, @TestCaseId int
AS
update LoadTestTestSummaryData set 
    Percentile90 =
    (select min(ElapsedTime) from 
    (select top 10 percent ElapsedTime from LoadTestTestDetail 
        where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
        order by ElapsedTime desc) as TopElapsedTimes),
    Percentile95 =
    (select min(ElapsedTime) from 
    (select top 5 percent ElapsedTime from LoadTestTestDetail 
        where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
        order by ElapsedTime desc) as TopElapsedTimes)
where LoadTestRunId = @LoadTestRunId and TestCaseId=@TestCaseId
GO
GRANT EXECUTE ON Prc_UpdateTestPercentiles TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateTestSummary @LoadTestRunId int, @TestCaseId int
AS
UPDATE LoadTestTestSummaryData set 

    Percentile90 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 10 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
              AND TestCaseId=@TestCaseId
              AND InMeasurementInterval = 1
         ORDER BY ElapsedTime desc) AS TopElapsedTimes),

    Percentile95 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 5 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes),

    Percentile99 =
        (SELECT MIN(ElapsedTime) 
         FROM 
        (SELECT TOP 1 percent ElapsedTime FROM LoadTestTestDetail 
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes),

    Median =
        (SELECT MIN(ElapsedTime)
         FROM
        (SELECT TOP 50 PERCENT ElapsedTime FROM LoadTestTestDetail
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND TestCaseId=@TestCaseId
                  AND InMeasurementInterval = 1
         ORDER BY ElapsedTime DESC) AS TopElapsedTimes)

    WHERE LoadTestRunId = @LoadTestRunId 
      AND TestCaseId=@TestCaseId
GO

GRANT EXECUTE ON Prc_UpdateTestSummary TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTestSummary3] @LoadTestRunId int
AS

If IsNull(object_id('tempdb..#numberedTestDetails'),0) <> 0 DROP TABLE #numberedTestDetails

  SELECT * INTO #numberedTestDetails FROM 
  (
      SELECT ElapsedTime, LoadTestRunId, TestCaseId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, TestCaseId 
                 ORDER BY ElapsedTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, TestCaseId) AS rCount
      FROM LoadTestTestDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 
 
  UPDATE LoadTestTestSummaryData  
  SET Percentile90 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/10)

  UPDATE LoadTestTestSummaryData  
  SET Percentile95 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/20)

  UPDATE LoadTestTestSummaryData  
  SET Percentile99 = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/100)

  UPDATE LoadTestTestSummaryData  
  SET Median = ElapsedTime
  FROM  LoadTestTestSummaryData  JOIN #numberedTestDetails ON
        LoadTestTestSummaryData.LoadTestRunId = #numberedTestDetails.LoadTestRunId AND
        LoadTestTestSummaryData.TestCaseId = #numberedTestDetails.TestCaseId
  WHERE #numberedTestDetails.rowNumber = ceiling(CAST(#numberedTestDetails.rCount AS Float)/2)

  DROP TABLE #numberedTestDetails

GO

GRANT EXECUTE ON [dbo].[Prc_UpdateTestSummary3] TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateTransactionPercentiles @LoadTestRunId int, @TransactionId int
AS
update LoadTestTransactionSummaryData set 
    Percentile90 =
    (select min(ElapsedTime) from 
    (select top 10 percent ElapsedTime from LoadTestTransactionDetail 
        where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
        order by ElapsedTime desc) as TopElapsedTimes),
    Percentile95 =
    (select min(ElapsedTime) from 
    (select top 5 percent ElapsedTime from LoadTestTransactionDetail 
        where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
        order by ElapsedTime desc) as TopElapsedTimes)
where LoadTestRunId = @LoadTestRunId and TransactionId=@TransactionId
GO
GRANT EXECUTE ON Prc_UpdateTransactionPercentiles TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateTransactionSummary @LoadTestRunId int, @TransactionId int
AS
UPDATE LoadTestTransactionSummaryData 
SET 
    Percentile90 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 10 percent ResponseTime 
          FROM LoadTestTransactionDetail 
          WHERE LoadTestRunId = @LoadTestRunId 
                AND TransactionId=@TransactionId
                AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) as TopResponseTimes),

    Percentile95 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 5 percent ResponseTime 
          FROM   LoadTestTransactionDetail 
          WHERE  LoadTestRunId = @LoadTestRunId 
                 AND TransactionId=@TransactionId
                 AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) AS TopResponseTimes),

    Percentile99 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 1 percent ResponseTime 
          FROM   LoadTestTransactionDetail 
          WHERE  LoadTestRunId = @LoadTestRunId 
                 AND TransactionId=@TransactionId
                 AND InMeasurementInterval = 1
          ORDER BY ResponseTime desc) AS TopResponseTimes),

    Median =
        (SELECT MIN(ResponseTime)
         FROM
             (SELECT TOP 50 PERCENT ResponseTime 
              FROM LoadTestTransactionDetail
              WHERE LoadTestRunId = @LoadTestRunId 
                  AND TransactionId=@TransactionId
                  AND InMeasurementInterval = 1
              ORDER BY ResponseTime DESC) AS TopResponseTimes)

WHERE LoadTestRunId = @LoadTestRunId 
      AND TransactionId=@TransactionId
GO
GRANT EXECUTE ON Prc_UpdateTransactionSummary TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_UpdateTransactionSummary3] @LoadTestRunId int
AS
If IsNull(object_id('tempdb..#numberedTransactionDetails'),0) <> 0 DROP TABLE #numberedTransactionDetails

  SELECT * INTO #numberedTransactionDetails FROM 
  (
      SELECT ResponseTime, LoadTestRunId, TransactionId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, TransactionId 
                 ORDER BY ResponseTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, TransactionId) AS rCount
      FROM LoadTestTransactionDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile90 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/10)


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile95 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/20)


  UPDATE LoadTestTransactionSummaryData  
  SET Percentile99 = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/100)



  UPDATE LoadTestTransactionSummaryData  
  SET Median = ResponseTime
  FROM  LoadTestTransactionSummaryData  JOIN #numberedTransactionDetails ON
        LoadTestTransactionSummaryData.LoadTestRunId = #numberedTransactionDetails.LoadTestRunId AND
        LoadTestTransactionSummaryData.TransactionId = #numberedTransactionDetails.TransactionId
  WHERE #numberedTransactionDetails.rowNumber = ceiling(CAST(#numberedTransactionDetails.rCount AS Float)/2)

  DROP TABLE #numberedTransactionDetails
GO
GRANT EXECUTE ON [dbo].[Prc_UpdateTransactionSummary3] TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdatePagePercentiles @LoadTestRunId int, @PageId int
AS
update LoadTestPageSummaryData set 
    Percentile90 =
        (select min(ResponseTime) from 
        (select top 10 percent ResponseTime from LoadTestPageDetail 
        where LoadTestRunId = @LoadTestRunId and PageId=@PageId
        order by ResponseTime desc) as TopResponseTimes),
    Percentile95 =
        (select min(ResponseTime) from 
        (select top 5 percent ResponseTime from LoadTestPageDetail 
        where LoadTestRunId = @LoadTestRunId and PageId=@PageId
        order by ResponseTime desc) as TopResponseTimes)
where LoadTestRunId = @LoadTestRunId and PageId=@PageId
GO
GRANT EXECUTE ON Prc_UpdatePagePercentiles TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdatePageSummary @LoadTestRunId int, @PageId int
AS
UPDATE LoadTestPageSummaryData 
SET 
    Percentile90 =
      (SELECT MIN(ResponseTime) 
       FROM 
           (SELECT TOP 10 PERCENT ResponseTime 
            FROM LoadTestPageDetail 
            WHERE LoadTestRunId = @LoadTestRunId 
                  AND PageId=@PageId
                  AND InMeasurementInterval = 1
            ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Percentile95 =
       (SELECT MIN(ResponseTime) 
        FROM 
            (SELECT TOP 5 percent ResponseTime 
             FROM LoadTestPageDetail 
             WHERE LoadTestRunId = @LoadTestRunId 
                   AND PageId=@PageId
                   AND InMeasurementInterval = 1
             ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Percentile99 =
       (SELECT MIN(ResponseTime) 
        FROM 
            (SELECT TOP 1 percent ResponseTime 
             FROM LoadTestPageDetail 
             WHERE LoadTestRunId = @LoadTestRunId 
                   AND PageId=@PageId
                   AND InMeasurementInterval = 1
             ORDER BY ResponseTime DESC) AS TopResponseTimes),

    Median =
        (SELECT MIN(ResponseTime) FROM 
        (SELECT TOP 50 PERCENT ResponseTime FROM LoadTestPageDetail
         WHERE LoadTestRunId = @LoadTestRunId 
                  AND PageId=@PageId
                  AND InMeasurementInterval = 1
         ORDER BY ResponseTime DESC) AS TopResponseTimes)

WHERE LoadTestRunId = @LoadTestRunId 
      AND PageId=@PageId
GO
GRANT EXECUTE ON Prc_UpdatePageSummary TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummary3] @LoadTestRunId int
AS
If IsNull(object_id('tempdb..#numberedPageDetails'),0) <> 0 DROP TABLE #numberedPageDetails

  SELECT * INTO #numberedPageDetails FROM 
  (
      SELECT ResponseTime, LoadTestRunId, PageId, 
	   rowNumber=ROW_NUMBER() 
	   OVER (PARTITION BY LoadTestRunId, PageId 
                 ORDER BY ResponseTime DESC),
	   COUNT(*) 
           OVER (PARTITION BY LoadTestRunId, PageId) AS rCount
      FROM LoadTestPageDetail
      WHERE LoadTestRunId = @LoadTestRunId AND
        InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestPageSummaryData 
  SET Percentile90 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/10)

  UPDATE LoadTestPageSummaryData 
  SET Percentile95 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/20)

  UPDATE LoadTestPageSummaryData 
  SET Percentile99 = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/100)

  UPDATE LoadTestPageSummaryData 
  SET Median = ResponseTime
  FROM  LoadTestPageSummaryData  JOIN #numberedPageDetails ON
        LoadTestPageSummaryData.LoadTestRunId = #numberedPageDetails.LoadTestRunId AND
        LoadTestPageSummaryData.PageId = #numberedPageDetails.PageId
  WHERE #numberedPageDetails.rowNumber = ceiling(CAST(#numberedPageDetails.rCount AS Float)/2)


  DROP TABLE #numberedPageDetails
GO
GRANT EXECUTE ON [dbo].[Prc_UpdatePageSummary3] TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdatePageByNetworkPercentiles @LoadTestRunId int, @PageId int, @NetworkId int
AS
update LoadTestPageSummaryByNetwork set 
    Percentile90 =
    (select min(ResponseTime) from 
    (select top 10 percent pageDetail.ResponseTime 
        from LoadTestPageDetail as pageDetail
        INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId
        order by pageDetail.ResponseTime desc) as TopResponseTimes),
    Percentile95 =
    (select min(ResponseTime) from 
    (select top 5 percent pageDetail.ResponseTime 
        from LoadTestPageDetail as pageDetail
        INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId
        order by pageDetail.ResponseTime desc) as TopResponseTimes),
    PagesMeetingGoal =
       (select count(*)
        from LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
        where pageDetail.LoadTestRunId = @LoadTestRunId and 
              pageDetail.PageId=@PageId and
              testDetail.NetworkId=@NetworkId and
              pageDetail.GoalExceeded = 0)
where LoadTestRunId=@LoadTestRunId and PageId=@PageId and NetworkId=@NetworkId           
GO
GRANT EXECUTE ON Prc_UpdatePageByNetworkPercentiles TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdatePageSummaryByNetwork @LoadTestRunId int, @PageId int, @NetworkId int
AS
UPDATE LoadTestPageSummaryByNetwork 
SET 
    Percentile90 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 10 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
          ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          where pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Percentile95 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 5 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Percentile99 =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 1 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    Median =
    (SELECT MIN(ResponseTime) 
     FROM 
         (SELECT TOP 50 percent pageDetail.ResponseTime 
          FROM LoadTestPageDetail AS pageDetail
          JOIN LoadTestTestDetail AS testDetail
               ON  pageDetail.LoadTestRunId = testDetail.LoadTestRunId
               AND pageDetail.TestDetailId = testDetail.TestDetailId
          WHERE pageDetail.LoadTestRunId = @LoadTestRunId 
                AND pageDetail.PageId=@PageId 
                AND testDetail.NetworkId=@NetworkId
                AND pageDetail.InMeasurementInterval = 1
          ORDER BY pageDetail.ResponseTime DESC) AS TopResponseTimes),

    PagesMeetingGoal =
       (SELECT count(*)
        FROM LoadTestPageDetail AS pageDetail
        JOIN LoadTestTestDetail AS testDetail
        ON   pageDetail.LoadTestRunId = testDetail.LoadTestRunId
             AND pageDetail.TestDetailId = testDetail.TestDetailId
        WHERE pageDetail.LoadTestRunId = @LoadTestRunId  
              AND pageDetail.PageId=@PageId 
              AND testDetail.NetworkId=@NetworkId 
              AND pageDetail.GoalExceeded = 0
              AND pageDetail.InMeasurementInterval = 1)

WHERE LoadTestRunId=@LoadTestRunId
      AND PageId=@PageId
      AND NetworkId=@NetworkId
GO
GRANT EXECUTE ON Prc_UpdatePageSummaryByNetwork TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_UpdatePageSummaryByNetwork3] @LoadTestRunId int
AS

If IsNull(object_id('tempdb..#numberedPageAndTestDetails'),0) <> 0 DROP TABLE #numberedPageAndTestDetails

SELECT * INTO #numberedPageAndTestDetails FROM
 (
     SELECT pageDetail.ResponseTime, pageDetail.LoadTestRunId, testDetail.TestCaseId, 
           pageDetail.PageId, testDetail.NetworkId,
	       rowNumber=ROW_NUMBER() 
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId , 
	         testDetail.NetworkId ORDER BY pageDetail.ResponseTime DESC),
	       COUNT(*) 
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId, 
		     testDetail.NetworkId) AS rCount,
	       SUM(CASE WHEN GoalExceeded=0 THEN 1 ELSE 0 END)
	       OVER (PARTITION BY pageDetail.LoadTestRunId, pageDetail.PageId, 
		   testDetail.NetworkId) AS pagesMeetingGoal
  FROM LoadTestPageDetail AS pageDetail JOIN LoadTestTestDetail AS testDetail
  ON  pageDetail.LoadTestRunId = testDetail.LoadTestRunId AND 
      pageDetail.TestDetailId = testDetail.TestDetailId
  WHERE pageDetail.LoadTestRunId = @LoadTestRunId AND
        pageDetail.InMeasurementInterval = 1) AS allRows
  WHERE allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 100) OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 20)  OR 
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 10)  OR
        allRows.rowNumber = ceiling(CAST(allRows.rCount AS Float) / 2) 


  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile90 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/10)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile95 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/20)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Percentile99 = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/100)

  UPDATE LoadTestPageSummaryByNetwork 
  SET Median = ResponseTime
  FROM  LoadTestPageSummaryByNetwork  JOIN #numberedPageAndTestDetails ON
        LoadTestPageSummaryByNetwork.LoadTestRunId = #numberedPageAndTestDetails.LoadTestRunId AND
        LoadTestPageSummaryByNetwork.PageId = #numberedPageAndTestDetails.PageId AND
        LoadTestPageSummaryByNetwork.NetworkId = #numberedPageAndTestDetails.NetworkId
  WHERE #numberedPageAndTestDetails.rowNumber = ceiling(CAST(#numberedPageAndTestDetails.rCount AS Float)/2)

 UPDATE LoadTestPageSummaryByNetwork 
  SET PagesMeetingGoal =  results.pagesMeetingGoal
  FROM
  (SELECT  LoadTestRunId, PageId, NetworkId,  pagesMeetingGoal FROM #numberedPageAndTestDetails 
   GROUP BY LoadTestRunId, PageId, NetworkId, pagesMeetingGoal) AS results
   JOIN  LoadTestPageSummaryByNetwork
  ON LoadTestPageSummaryByNetwork.LoadTestRunId = results.LoadTestRunId AND
     LoadTestPageSummaryByNetwork.PageId = results.PageId AND
     LoadTestPageSummaryByNetwork.NetworkId = results.NetworkId
  DROP TABLE #numberedPageAndTestDetails

GO
GRANT EXECUTE ON [dbo].[Prc_UpdatePageSummaryByNetwork3] TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateSummaryData @LoadTestRunId int, @DeleteDetailTables bit
AS
BEGIN
	INSERT INTO LoadTestTestSummaryData 
	    (LoadTestRunId, TestCaseId, TestsRun, Average, Minimum, Maximum)
	SELECT LoadTestRunId, TestCaseId,
	    count(*) as TestsRun,
	    avg(ElapsedTime) as Average, 
	    min(ElapsedTime) as Minimum,
	    max(ElapsedTime) as Maximum
	    FROM LoadTestTestDetail where LoadTestRunId=@LoadTestRunId
	    GROUP BY LoadTestRunId, TestCaseId

	DECLARE @TestCaseId int

	DECLARE TestCaseCursor CURSOR FOR
	SELECT DISTINCT(TestCaseId) FROM LoadTestTestDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TestCaseCursor
	FETCH NEXT FROM TestCaseCursor INTO @TestCaseId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTestPercentiles @LoadTestRunId, @TestCaseId
	   FETCH NEXT FROM TestCaseCursor INTO @TestCaseId
	END

	CLOSE TestCaseCursor
	DEALLOCATE TestCaseCursor

	INSERT INTO LoadTestTransactionSummaryData 
	    (LoadTestRunId, TransactionId, TransactionCount, Average, Minimum, Maximum)
	SELECT LoadTestRunId, TransactionId,
	    count(*) as TransactionCount,
	    avg(ElapsedTime) as Average, 
	    min(ElapsedTime) as Minimum,
	    max(ElapsedTime) as Maximum		
	    FROM LoadTestTransactionDetail where LoadTestRunId=@LoadTestRunId
	    GROUP BY LoadTestRunId, TransactionId

	DECLARE @TransactionId int

	DECLARE TransactionIdCursor CURSOR FOR
	SELECT DISTINCT(TransactionId) FROM LoadTestTransactionDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TransactionIdCursor
	FETCH NEXT FROM TransactionIdCursor INTO @TransactionId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTransactionPercentiles @LoadTestRunId, @TransactionId
	   FETCH NEXT FROM TransactionIdCursor INTO @TransactionId
	END

	CLOSE TransactionIdCursor
	DEALLOCATE TransactionIdCursor

	INSERT INTO LoadTestPageSummaryData 
	    (LoadTestRunId, PageId, PageCount, Average, Minimum, Maximum)
	SELECT LoadTestRunId, PageId,
	    count(*) as PageCount,
	    avg(ResponseTime) as Average, 
	    min(ResponseTime) as Minimum,
	    max(ResponseTime) as Maximum
	    FROM LoadTestPageDetail where LoadTestRunId=@LoadTestRunId
	    GROUP BY LoadTestRunId, PageId

	DECLARE @PageId int

	DECLARE PageIdCursor CURSOR FOR
	SELECT DISTINCT(PageId) FROM LoadTestPageDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageIdCursor
	FETCH NEXT FROM PageIdCursor INTO @PageId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePagePercentiles @LoadTestRunId, @PageId
	   FETCH NEXT FROM PageIdCursor INTO @PageId
	END

	CLOSE PageIdCursor
	DEALLOCATE PageIdCursor

	INSERT INTO LoadTestPageSummaryByNetwork
	    (LoadTestRunId, PageId, NetworkId, PageCount, Average, Minimum, Maximum, Goal)
	SELECT pageDetail.LoadTestRunId, pageDetail.PageId, testDetail.NetworkId,
	    count(*) as PageCount,
	    avg(ResponseTime) as Average, 
	    min(ResponseTime) as Minimum,
	    max(ResponseTime) as Maximum,
	    avg(ResponseTimeGoal) as Goal
	    FROM LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	    AND pageDetail.TestDetailId = testDetail.TestDetailId
	    WHERE pageDetail.LoadTestRunId = @LoadTestRunId
	    GROUP BY pageDetail.LoadTestRunId, PageId, testDetail.NetworkId

	DECLARE @NetworkId int

	DECLARE PageNetworkCursor CURSOR FOR
	SELECT PageId, NetworkId from LoadTestPageSummaryByNetwork WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageNetworkCursor
	FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePageByNetworkPercentiles @LoadTestRunId, @PageId, @NetworkId
	   FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId
	END

	CLOSE PageNetworkCursor
	DEALLOCATE PageNetworkCursor

	IF @DeleteDetailTables = 1
	BEGIN
		DELETE from LoadTestTestDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestTransactionDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestPageDetail where LoadTestRunId = @LoadTestRunId
	END
END
GO
GRANT EXECUTE ON Prc_UpdateSummaryData TO PUBLIC
GO

CREATE PROCEDURE Prc_UpdateSummaryData2 @LoadTestRunId int, @DeleteDetailTables bit
AS
BEGIN
	INSERT INTO LoadTestTestSummaryData 
	    (LoadTestRunId, TestCaseId, TestsRun, Average, Minimum, Maximum, StandardDeviation)
	   SELECT LoadTestRunId, TestCaseId,
	          count(*) as TestsRun,
	          avg(ElapsedTime) as Average, 
	          min(ElapsedTime) as Minimum,
	          max(ElapsedTime) as Maximum,
              ISNULL(STDEVP(ElapsedTime),0) AS StandardDeviation
	    FROM  LoadTestTestDetail 
		WHERE LoadTestRunId=@LoadTestRunId
		      AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TestCaseId

	DECLARE @TestCaseId int

	DECLARE TestCaseCursor CURSOR FOR
	SELECT DISTINCT(TestCaseId) FROM LoadTestTestDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TestCaseCursor
	FETCH NEXT FROM TestCaseCursor INTO @TestCaseId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTestSummary @LoadTestRunId, @TestCaseId
	   FETCH NEXT FROM TestCaseCursor INTO @TestCaseId
	END

	CLOSE TestCaseCursor
	DEALLOCATE TestCaseCursor

	INSERT INTO LoadTestTransactionSummaryData 
	    (LoadTestRunId, TransactionId, TransactionCount, Average, Minimum, Maximum,AvgTransactionTime, StandardDeviation)
	    SELECT LoadTestRunId, TransactionId,
	           count(*) as TransactionCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
                   max(ResponseTime) as Maximum,
                   avg(ElapsedTime) as AverageTransactionTime,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM LoadTestTransactionDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TransactionId

	DECLARE @TransactionId int

	DECLARE TransactionIdCursor CURSOR FOR
	SELECT DISTINCT(TransactionId) FROM LoadTestTransactionDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN TransactionIdCursor
	FETCH NEXT FROM TransactionIdCursor INTO @TransactionId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdateTransactionSummary @LoadTestRunId, @TransactionId
	   FETCH NEXT FROM TransactionIdCursor INTO @TransactionId
	END

	CLOSE TransactionIdCursor
	DEALLOCATE TransactionIdCursor

	INSERT INTO LoadTestPageSummaryData 
	    (LoadTestRunId, PageId, PageCount, Average, Minimum, Maximum, StandardDeviation)
	    SELECT LoadTestRunId, PageId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, PageId

	DECLARE @PageId int

	DECLARE PageIdCursor CURSOR FOR
	SELECT DISTINCT(PageId) FROM LoadTestPageDetail WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageIdCursor
	FETCH NEXT FROM PageIdCursor INTO @PageId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePageSummary @LoadTestRunId, @PageId
	   FETCH NEXT FROM PageIdCursor INTO @PageId
	END

	CLOSE PageIdCursor
	DEALLOCATE PageIdCursor

	INSERT INTO LoadTestPageSummaryByNetwork
	    (LoadTestRunId, PageId, NetworkId, PageCount, Average, Minimum, Maximum, Goal, StandardDeviation)
	    SELECT pageDetail.LoadTestRunId, pageDetail.PageId, testDetail.NetworkId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
	           avg(ResponseTimeGoal) as Goal,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	          AND pageDetail.TestDetailId = testDetail.TestDetailId
	    WHERE pageDetail.LoadTestRunId = @LoadTestRunId
		      AND pageDetail.InMeasurementInterval = 1
	    GROUP BY pageDetail.LoadTestRunId, PageId, testDetail.NetworkId

	DECLARE @NetworkId int

	DECLARE PageNetworkCursor CURSOR FOR
	SELECT PageId, NetworkId from LoadTestPageSummaryByNetwork WHERE LoadTestRunId = @LoadTestRunId

	OPEN PageNetworkCursor
	FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   EXEC Prc_UpdatePageSummaryByNetwork @LoadTestRunId, @PageId, @NetworkId
	   FETCH NEXT FROM PageNetworkCursor INTO @PageId, @NetworkId
	END

	CLOSE PageNetworkCursor
	DEALLOCATE PageNetworkCursor

	IF @DeleteDetailTables = 1
	BEGIN
		DELETE from LoadTestTestDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestTransactionDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestPageDetail where LoadTestRunId = @LoadTestRunId
	END
END
GO
GRANT EXECUTE ON Prc_UpdateSummaryData2 TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_UpdateSummaryData3] @LoadTestRunId int, @DeleteDetailTables bit
AS
BEGIN
	INSERT INTO LoadTestTestSummaryData 
	    (LoadTestRunId, TestCaseId, TestsRun, Average, Minimum, Maximum, StandardDeviation)
	   SELECT LoadTestRunId, TestCaseId,
	          count(*) as TestsRun,
	          avg(ElapsedTime) as Average, 
	          min(ElapsedTime) as Minimum,
	          max(ElapsedTime) as Maximum,
              ISNULL(STDEVP(ElapsedTime),0) AS StandardDeviation
	    FROM  LoadTestTestDetail 
		WHERE LoadTestRunId=@LoadTestRunId
		      AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TestCaseId

        EXEC Prc_UpdateTestSummary3 @LoadTestRunId


	INSERT INTO LoadTestTransactionSummaryData 
	    (LoadTestRunId, TransactionId, TransactionCount, Average, Minimum, Maximum,AvgTransactionTime, StandardDeviation)
	    SELECT LoadTestRunId, TransactionId,
	           count(*) as TransactionCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
                   max(ResponseTime) as Maximum,
                   avg(ElapsedTime) as AverageTransactionTime,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM LoadTestTransactionDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, TransactionId

        EXEC Prc_UpdateTransactionSummary3 @LoadTestRunId


	INSERT INTO LoadTestPageSummaryData 
	    (LoadTestRunId, PageId, PageCount, Average, Minimum, Maximum, StandardDeviation)
	    SELECT LoadTestRunId, PageId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail 
		WHERE  LoadTestRunId=@LoadTestRunId
		       AND InMeasurementInterval = 1
	    GROUP BY LoadTestRunId, PageId

        EXEC Prc_UpdatePageSummary3 @LoadTestRunId


	INSERT INTO LoadTestPageSummaryByNetwork
	    (LoadTestRunId, PageId, NetworkId, PageCount, Average, Minimum, Maximum, Goal, StandardDeviation)
	    SELECT pageDetail.LoadTestRunId, pageDetail.PageId, testDetail.NetworkId,
	           count(*) as PageCount,
	           avg(ResponseTime) as Average, 
	           min(ResponseTime) as Minimum,
	           max(ResponseTime) as Maximum,
	           avg(ResponseTimeGoal) as Goal,
                   ISNULL(STDEVP(ResponseTime),0) AS StandardDeviation
	    FROM   LoadTestPageDetail as pageDetail
	    INNER JOIN LoadTestTestDetail as testDetail
	    ON pageDetail.LoadTestRunId = testDetail.LoadTestRunId
	          AND pageDetail.TestDetailId = testDetail.TestDetailId
	    WHERE pageDetail.LoadTestRunId = @LoadTestRunId
		      AND pageDetail.InMeasurementInterval = 1
	    GROUP BY pageDetail.LoadTestRunId, PageId, testDetail.NetworkId
        
        EXEC Prc_UpdatePageSummaryByNetwork3 @LoadTestRunId

	IF @DeleteDetailTables = 1
	BEGIN
		DELETE from LoadTestTestDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestTransactionDetail where LoadTestRunId = @LoadTestRunId
		DELETE from LoadTestPageDetail where LoadTestRunId = @LoadTestRunId
	END
END
GO
GRANT EXECUTE ON [dbo].[Prc_UpdateSummaryData3] TO PUBLIC
GO

CREATE PROCEDURE prc_GrantDBAccess
@dbUser SYSNAME	
AS
-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

DECLARE @statement      NVARCHAR(4000)
DECLARE @status INT

-- Warning: if @dbUser is null, QUOTENAME will return null, @statement will be null and sp_executesql will return success!
IF (@dbUser IS NULL)
BEGIN
    RAISERROR (500001, 16, -1, @procedureName, 'username cannot be null')
    RETURN 500001
END

-- First grant the user the ability to login to SQL server if they don't already have it.
IF (SUSER_ID(@dbUser) IS NULL)
BEGIN
    SELECT @statement = 'CREATE LOGIN '+ QUOTENAME(@dbUser) +' FROM WINDOWS'
    
    EXEC @status = sp_executesql @statement
    IF (@status <> 0)
    BEGIN
        RAISERROR (500001, 16, -1, @procedureName, 'Unable to create login for user')
        RETURN @status
    END
END

-- Grant the user access to this database if not already enabled
-- either by an explicit grant or by being the database owner
IF NOT (
    EXISTS (
        SELECT  name 
        FROM    sysusers 
        WHERE   name = @dbUser)
    OR EXISTS (
        SELECT  sid
        FROM    master.dbo.sysdatabases
        WHERE   dbid = db_id()
                AND sid = SUSER_SID(@dbUser)))
BEGIN
    SELECT @statement = 'CREATE USER '+ QUOTENAME(@dbUser)

    EXEC @status = sp_executesql @statement
    IF (@status <> 0)
    BEGIN
        RAISERROR (500001, 16, -1, @procedureName, 'Unable to create database user')
        RETURN @status
    END
END
RETURN 
GO

CREATE PROCEDURE [dbo].[prc_CreateLoadTestReport]
    @name               NVARCHAR(255),
    @reportType         TINYINT,
    @description        NVARCHAR(MAX),
    @loadTestName       NVARCHAR(255), 
    @lastModifiedBy     NVARCHAR(255),
    @lastRunId          INT,
    @selectNewReports   BIT,
    @runsXml            NVARCHAR(MAX),
    @pageXml            NVARCHAR(MAX)

AS

SET NOCOUNT ON

DECLARE @status       INT
DECLARE @reportId     INT
DECLARE @docHandle    INT
DECLARE @lastModified DATETIME

SET @lastModified = GETUTCDATE()

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

DECLARE @pageInfo TABLE (
    categoryName  NVARCHAR(255) NOT NULL,
    counterName   NVARCHAR(255) NOT NULL  
)

-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

BEGIN TRAN

INSERT LoadTestReport
       (
            Name,
			ReportType,
            Description,
            LoadTestName,
            LastRunId,
            SelectNewRuns,
            LastModified,
            LastModifiedBy
        )
VALUES  (
            @name,
			@reportType,
            @description,
            @loadTestName,
            @lastRunId,
            @selectNewReports,
            @lastModified,
            @lastModifiedBy            
        ) 

SELECT  @status = @@ERROR,
        @reportId = SCOPE_IDENTITY()
        
IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'LoadTestReport')
    ROLLBACK TRAN
    RETURN 560500
END


-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsXml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@runs')
    ROLLBACK TRAN
    RETURN 560500    
END

INSERT LoadTestReportRuns
SELECT @reportId,
       runId
FROM   @runs

SELECT  @status = @@ERROR

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'LoadTestReportRuns')
    ROLLBACK TRAN
    RETURN 560500
END

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @pageXml

INSERT  @pageInfo        
SELECT  c,
        t
FROM OPENXML(@docHandle, N'/pages/p', 0)
    WITH (        
        c NVARCHAR(255),
        t NVARCHAR(255)
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@pageInfo')
    ROLLBACK TRAN
    RETURN 560500    
END

INSERT LoadTestReportPage
SELECT @reportId,
       categoryName,
       counterName
FROM   @pageInfo 
       

COMMIT TRAN

-- Return ID to caller
SELECT  @reportId AS ReportId,
        @lastModified as LastModified

-- Return Page Info
SELECT PageId, 
       ReportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
        
RETURN 0
GO


GRANT EXECUTE ON prc_CreateLoadTestReport TO PUBLIC
GO

CREATE PROCEDURE [dbo].[prc_UpdateLoadTestReport] 
    @reportId           INT,   	
    @description        NVARCHAR(255),
    @loadTestName       NVARCHAR(255), 
    @lastModifiedBy     NVARCHAR(255),   
    @lastRunId          INT,
    @selectNewReports   BIT,
    @runsXml            NVARCHAR(MAX),
    @pageXml            NVARCHAR(MAX)

AS

SET NOCOUNT ON

DECLARE @status       INT
DECLARE @docHandle    INT
DECLARE @lastModified  DATETIME

SET @lastModified = GETUTCDATE()

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

DECLARE @pageInfo TABLE (
    pageId        INT NOT NULL,
    categoryName  NVARCHAR(255) NOT NULL,
    counterName   NVARCHAR(255) NOT NULL  
)

-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

BEGIN TRAN

UPDATE LoadTestReport
SET    Description = @description,
       LoadTestName = @loadTestName,
       LastRunId = @lastRunId,
       SelectNewRuns = @selectNewReports,
       LastModifiedBy = @lastModifiedBy,
	   LastModified = @lastModified
WHERE  ReportId = @reportId
        
SELECT  @status = @@ERROR        
        
IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'UPDATE', N'LoadTestReport')
    ROLLBACK TRAN
    RETURN 560500
END


-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsXml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@runs')
    ROLLBACK TRAN
    RETURN 560500    
END

--first delete runs that no longer exist
DELETE LoadTestReportRuns
FROM   LoadTestReportRuns ltr
LEFT JOIN @runs r
ON     ltr.LoadTestRunId = r.runId
WHERE  ltr.ReportId = @reportId
       AND r.runId IS NULL
       

SELECT  @status = @@ERROR

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'DELETE', N'LoadTestReportRuns')
    ROLLBACK TRAN
    RETURN 560500
END

--Now insert new runs
INSERT    LoadTestReportRuns
SELECT    @reportId,
          runId
FROM      @runs r
LEFT JOIN LoadTestReportRuns ltr
ON        ltr.ReportId = @reportId
          AND r.runId = ltr.LoadTestRunId  
WHERE     ltr.LoadTestRunId IS NULL    

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @pageXml

INSERT  @pageInfo        
SELECT  i,
        c,
        t
FROM OPENXML(@docHandle, N'/pages/p', 0)
    WITH (
        i INT,        
        c NVARCHAR(255),
        t NVARCHAR(255)
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@pageInfo')
    ROLLBACK TRAN
    RETURN 560500    
END

--first delete reports that no longer exist
DELETE    LoadTestReportPage
FROM      LoadTestReportPage p
LEFT JOIN @pageInfo i
ON        p.PageId = i.PageId
WHERE     p.ReportId = @reportId
          AND i.PageId IS NULL

INSERT    LoadTestReportPage
SELECT    @reportId,
          i.categoryName,
          i.counterName
FROM      @pageInfo i
LEFT JOIN LoadTestReportPage p
ON        p.ReportId = @reportId
          AND p.PageId = i.PageId
WHERE     p.PageId IS NULL
       

COMMIT TRAN

SELECT @lastModified as LastModified

-- Return Page Info
SELECT PageId, 
       ReportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
        
        
RETURN 0
GO


GRANT EXECUTE ON prc_UpdateLoadTestReport TO PUBLIC
GO

CREATE PROCEDURE [dbo].[prc_FindLoadTestReport] 
    @reportId           INT,
    @name               NVARCHAR(255)               

AS

SET NOCOUNT ON

IF (@reportId = -1) 
BEGIN
    SELECT @reportId = ReportId
    FROM   LoadTestReport
    WHERE  Name = @name
END

-- Return Report Info
SELECT Name, 
       ReportType,
       Description,
       LoadTestName,
       LastRunId,
       SelectNewRuns,
       LastModified,
       LastModifiedBy
FROM   LoadTestReport
WHERE  ReportId = @reportId

--return runs
SELECT LoadTestRunId
FROM   LoadTestReportRuns
WHERE  ReportId = @reportId

--return pages
SELECT PageId,
       @reportId,
       CategoryName,
       CounterName
FROM   LoadTestReportPage
WHERE  ReportId = @reportId
GO



GRANT EXECUTE ON prc_FindLoadTestReport TO PUBLIC
GO

CREATE PROCEDURE [dbo].[prc_QueryForInstanceCount]   
    @categoryName  NVARCHAR(255),
    @counterName   NVARCHAR(255),  
    @runsxml       NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @docHandle    INT
DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsxml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

-- Return Runs Info
SELECT TOP 1 run.runId, count(*) as InstanceCount
FROM @runs as run
INNER JOIN LoadTestPerformanceCounterCategory AS category 
    ON run.runId = category.LoadTestRunId
INNER JOIN LoadTestPerformanceCounter AS counter 
    ON category.LoadTestRunId = counter.LoadTestRunId
    AND category.CounterCategoryId = counter.CounterCategoryId
INNER JOIN LoadTestPerformanceCounterInstance AS instance 
    ON counter.CounterId = instance.CounterId
    AND counter.LoadTestRunId = instance.LoadTestRunId
WHERE instance.cumulativeValue IS NOT NULL
AND  counter.CounterName = @counterName
AND  category.CategoryName = @categoryName
GROUP BY run.runId
ORDER BY InstanceCount DESC

GRANT EXECUTE ON prc_QueryForInstanceCount TO PUBLIC
GO


CREATE PROCEDURE [dbo].[prc_QueryLoadTestReports]    
AS
SET NOCOUNT ON

-- Return Report Info
SELECT ReportId,
       ReportType,
       Name,
       LoadTestName,
       Description,
       SelectNewRuns,
       LastModified,
       LastModifiedBy
FROM   LoadTestReport
WHERE  Name != 'LOADTEST_RUNCOMPARISON_REPORT_DEFAULT'
       AND Name != 'LOADTEST_TREND_REPORT_DEFAULT'
ORDER BY LastModified DESC
GO

GRANT EXECUTE ON prc_QueryLoadTestReports TO PUBLIC
GO

CREATE PROCEDURE [dbo].[prc_QueryLoadTestRunsById]    
    @runsXml            NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @status       INT
DECLARE @docHandle    INT

DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

-- Parse the XML input into a temporary table
-- Initialize the ProcedureName for error messages.
DECLARE @procedureName SYSNAME
SELECT  @procedureName = @@SERVERNAME + '.' + db_name() + '..' + object_name(@@PROCID)

EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsXml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

SELECT  @status = @@ERROR

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

IF (@status <> 0)
BEGIN
    RAISERROR (560500, 16, -1, @procedureName, @status, N'INSERT', N'@runs')
    ROLLBACK TRAN
    RETURN 560500    
END

-- Return Runs Info
SELECT LoadTestRunId, 
       ltr.RunId, 
       LoadTestName, 
       Description, 
       Comment, 
       IsLocalRun, 
       ControllerName, 
       StartTime, 
       EndTime, 
       WarmupTime, 
       RunDuration, 
       LoadTest, 
       Outcome,
       LoadTestSchemaRev
FROM   LoadTestRun ltr
JOIN   @runs r
ON     ltr.LoadTestRunId = r.runId
WHERE  StartTime IS NOT NULL 
       AND EndTime IS NOT NULL 
ORDER BY StartTime DESC
GO

GRANT EXECUTE ON prc_QueryLoadTestRunsById TO PUBLIC
GO


CREATE PROCEDURE [dbo].[prc_QueryLoadTestRuns]    
    @loadTestName        NVARCHAR(255)
AS
SET NOCOUNT ON

-- Return Runs Info
SELECT LoadTestRunId, 
       RunId, 
       LoadTestName, 
       Description, 
       Comment, 
       IsLocalRun, 
       ControllerName, 
       StartTime, 
       EndTime, 
       WarmupTime, 
       RunDuration, 
       LoadTest, 
       Outcome,
       LoadTestSchemaRev
FROM   LoadTestRun 
WHERE LoadTestName = @loadTestName 
      AND StartTime IS NOT NULL 
      AND EndTime IS NOT NULL 
ORDER BY StartTime DESC
GO

GRANT EXECUTE ON prc_QueryLoadTestRuns TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_GetAvailableDetailTypes]
    @LoadTestRunId INT	
AS

SET NOCOUNT ON

DECLARE @TestDetailExists  BIT
DECLARE @PageDetailExists  BIT
DECLARE @TransactionDetailExists  BIT

SET @TestDetailExists = 0
SET @PageDetailExists = 0
SET @TransactionDetailExists = 0

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestPageDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @PageDetailExists = 1
END

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestTransactionDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @TransactionDetailExists = 1
END

IF EXISTS 
(
    SELECT TOP 1 LoadTestRunId
    FROM   LoadTestTestDetail
    WHERE  LoadTestRunId = @LoadTestRunId
)
BEGIN
    SET @TestDetailExists = 1
END

SELECT @TestDetailExists AS TestDetailsExists,
       @PageDetailExists AS PageDetailExists, 
       @TransactionDetailExists AS TransactionDetailExists
GO
GRANT EXECUTE ON Prc_GetAvailableDetailTypes TO PUBLIC
GO

       
CREATE PROCEDURE [dbo].[Prc_GetUserPageDetail]
    @LoadTestRunId INT,
	@StartTime     DATETIME,
    @EndTime       DATETIME,
    @FilterNoLog   BIT,
    @FilterSuccessfulResults BIT,
    @ItemsXml      NVARCHAR(MAX),
    @ErrorsXml     NVARCHAR(MAX)
AS

SET NOCOUNT ON

DECLARE @docHandle    INT

--parse the items
DECLARE @items TABLE (
    Test           INT NOT NULL,
    Page           INT NOT NULL
)

--parse the errors
DECLARE @errors TABLE (
    ErrorId           INT NOT NULL    
)


-- Parse the XML input for items into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t,p
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT,
        p INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle


-- Parse the XML input for errors into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ErrorsXml

INSERT  @errors        
SELECT  t
FROM OPENXML(@docHandle, N'/errors/i', 0)
    WITH (                
        t INT        
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle


IF(@FilterSuccessfulResults=0)
BEGIN

--Select all pages active during that time span
SELECT    UserId,
          p.PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
JOIN      LoadTestDetailMessage dm
ON        p.LoadTestRunId = dm.LoadTestRunId
          AND p.TestDetailId = dm.TestDetailId
          AND p.PageDetailId = dm.PageDetailId
JOIN      @errors errors
ON        dm.MessageTypeId = errors.ErrorId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )

UNION

SELECT    UserId,
          PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )
          AND
          (
              p.Outcome = 0
          )        
ORDER BY  s.ScenarioId,AgentId,UserId, PageDetailId
END

ELSE
BEGIN

SELECT    UserId,
          p.PageDetailId,
          TestCaseName,
          p.TimeStamp as StartTime,
          p.EndTime,
          ScenarioName,
          p.Outcome,
          detail.AgentId,
          s.ScenarioId,
          ResponseTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          PageId,
          RequestUri,
          BrowserName,
          agent.AgentName
FROM      LoadTestPageDetail p     
JOIN      LoadTestTestDetail detail
ON        p.LoadTestRunId = detail.LoadTestRunId
          AND p.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId              
JOIN      WebLoadTestRequestMap map
ON        p.loadtestrunid = map.loadtestrunid
          AND p.PageId = map.RequestId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.Page = map.RequestId
JOIN      LoadTestDetailMessage dm
ON        p.LoadTestRunId = dm.LoadTestRunId
          AND p.TestDetailId = dm.TestDetailId
          AND p.PageDetailId = dm.PageDetailId
JOIN      @errors errors
ON        dm.MessageTypeId = errors.ErrorId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND p.EndTime > @StartTime
          AND
          ( 
             (
               p.TimeStamp >=@StartTime 
               AND p.TimeStamp <@EndTime            
             )
             OR
             (
               p.TimeStamp < @StartTime                         
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )      
ORDER BY  s.ScenarioId,AgentId,UserId, PageDetailId
END
GO


GRANT EXECUTE ON Prc_GetUserPageDetail TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_GetUserTransactionDetail]
    @LoadTestRunId INT,
	@StartTime     DATETIME,
    @EndTime       DATETIME,
    @FilterNoLog   BIT,
    @ItemsXml      NVARCHAR(MAX)
AS

SET NOCOUNT ON

DECLARE @docHandle    INT

--parse the items
DECLARE @items TABLE (
    Test            INT NOT NULL,
    TransactionId   INT NOT NULL
)

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t,tt
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT,
        tt INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

--Select all transactions active during that time span
SELECT    UserId,
          TransactionDetailId,
          TestCaseName,          
          t.TimeStamp as StartTime,
          t.EndTime,
          ScenarioName,          
          detail.AgentId,
          s.ScenarioId,
          t.ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1),
          t.TransactionId,
          wt.TransactionName,
          agent.AgentName
FROM      LoadTestTransactionDetail t     
JOIN      LoadTestTestDetail detail
ON        t.LoadTestRunId = detail.LoadTestRunId
          AND t.TestDetailId= detail.TestDetailId
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId     
JOIN      WebLoadTestTransaction wt
ON        t.LoadTestRunId = wt.LoadTestRunId
          AND t.TransactionId = wt.TransactionId
JOIN      @items i
ON        i.Test = tc.TestCaseId          
          AND i.TransactionId = wt.TransactionId
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
LEFT JOIN LoadTestBrowsers b
ON        detail.LoadTestRunId = b.LoadTestRunId
          AND detail.BrowserId = b.BrowserId 
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND t.EndTime > @StartTime
          AND
          ( 
             (
               t.TimeStamp >=@StartTime 
               AND t.TimeStamp <@EndTime            
             )
             OR
             (
               t.TimeStamp < @StartTime                      
             )
          )
          AND ( 
                (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
                OR
                (@FilterNoLog = 0)
              )
ORDER BY  s.ScenarioId,AgentId,UserId, TransactionDetailId

GO

GRANT EXECUTE ON Prc_GetUserTransactionDetail TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_GetInitialDetailRange]
   @LoadTestRunId int,
   @StartTime     DATETIME,
   @EndTime       DATETIME
AS

SET NOCOUNT ON

DECLARE @MinStartTime  DATETIME
DECLARE @MaxEndTime  DATETIME

--First figure out the boundaries
SELECT    @MinStartTime = @StartTime,
          @MaxEndTime = @EndTime


SELECT    @MinStartTime = MIN(TimeStamp),
          @MaxEndTime = MAX(EndTime)
FROM      LoadTestTestDetail
WHERE     LoadTestRunId = @LoadTestRunId
          AND EndTime > @MinStartTime
          AND
          ( 
             (
               TimeStamp >=@MinStartTime 
               AND TimeStamp <@MaxEndTime            
             )
             OR
             (
               TimeStamp < @MinStartTime                           
             )
          )


SELECT @MinStartTime AS MinStartTime,
       @MaxEndTime   AS MaxEndTime
GO

GRANT EXECUTE ON Prc_GetInitialDetailRange TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_GetUniqueDetailIds]
   @LoadTestRunId  INT,
   @DetailType     TINYINT
   
AS

SET NOCOUNT ON


IF (@DetailType = 0) -- Test
BEGIN
    SELECT DISTINCT TestCaseId
    FROM      LoadTestTestDetail detail    
    WHERE     detail.LoadTestRunId = @LoadTestRunId    
END
ELSE IF (@DetailType = 1) --Transaction
BEGIN
    SELECT DISTINCT TestCaseId,t.TransactionId
    FROM      LoadTestTransactionDetail t     	
	JOIN      WebLoadTestTransaction wt
	ON        t.LoadTestRunId = wt.LoadTestRunId
          AND t.TransactionId = wt.TransactionId
    WHERE     t.LoadTestRunId = @LoadTestRunId    
END
ELSE IF (@DetailType = 2) -- Page 
BEGIN
    SELECT DISTINCT TestCaseId,PageId
    FROM      LoadTestPageDetail p         
    JOIN      WebLoadTestRequestMap map
    ON        p.loadtestrunid = map.loadtestrunid
              AND p.PageId = map.RequestId
    WHERE     p.LoadTestRunId = @LoadTestRunId    
END
GO

GRANT EXECUTE ON Prc_GetUniqueDetailIds TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_GetUserTestDetail]
   @LoadTestRunId int,
   @StartTime     DATETIME,
   @EndTime       DATETIME,
   @FilterNoLog   BIT,
   @FilterSuccessfulResults BIT,
   @ItemsXml      NVARCHAR(MAX),
   @ErrorsXml     NVARCHAR(MAX)
AS

SET NOCOUNT ON

DECLARE @docHandle    INT

--parse the items
DECLARE @items TABLE (    
    Test           INT NOT NULL
)

--parse the errors
DECLARE @errors TABLE (
    ErrorId           INT NOT NULL    
)

-- Parse the XML input for items into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ItemsXml

INSERT  @items        
SELECT  t
FROM OPENXML(@docHandle, N'/items/i', 0)
    WITH (                
        t INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

-- Parse the XML input for errors into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @ErrorsXml

INSERT  @errors        
SELECT  t
FROM OPENXML(@docHandle, N'/errors/i', 0)
    WITH (                
        t INT        
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle


IF (@FilterSuccessfulResults=0)
BEGIN

--Select all tests active during that time span
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId 
JOIN      LoadTestDetailMessage dm
ON        detail.LoadTestRunId = dm.LoadTestRunId
          AND detail.TestDetailId = dm.TestDetailId
JOIN      LoadTestMessageType mt
ON        mt.LoadTestRunId = dm.LoadTestRunId
          AND  mt.MessageTypeId = dm.MessageTypeId
JOIN      @errors errors
ON        mt.MessageTypeId = errors.ErrorId      
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )

UNION

-- Add the rows for successful outcomes
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId     
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )
          AND
          (
              Outcome = 10
          )
ORDER BY  s.ScenarioId,AgentId,UserId,TestDetailId
END

ELSE

BEGIN
--Select all tests active during that time span
SELECT    UserId,
          detail.TestDetailId,
          TestCaseName,
          TimeStamp as StartTime,
          EndTime,
          ScenarioName,
          Outcome,
          detail.AgentId,          
          s.ScenarioId,
          ElapsedTime,
          TestType,
          NetworkName,
          ISNULL(TestLogId,-1) AS TestLogId,
          agent.AgentName
FROM      LoadTestTestDetail detail
JOIN      LoadTestCase tc
ON        detail.LoadTestRunId = tc.LoadTestRunId
          AND detail.TestCaseId = tc.TestCaseId
JOIN      LoadTestScenario s
ON        tc.LoadTestRunId = s.LoadTestRunId
          AND tc.ScenarioId = s.ScenarioId
JOIN      @items i
ON        i.Test = tc.TestCaseId   
JOIN      LoadTestRunAgent AS agent
ON        detail.LoadTestRunId = agent.LoadTestRunId
          AND detail.AgentId = agent.AgentId 
JOIN      LoadTestDetailMessage dm
ON        detail.LoadTestRunId = dm.LoadTestRunId
          AND detail.TestDetailId = dm.TestDetailId
JOIN      LoadTestMessageType mt
ON        mt.LoadTestRunId = dm.LoadTestRunId
          AND  mt.MessageTypeId = dm.MessageTypeId
JOIN      @errors errors
ON        mt.MessageTypeId = errors.ErrorId      
LEFT JOIN LoadTestNetworks n
ON        detail.LoadTestRunId = n.LoadTestRunId
          AND detail.NetworkId = n.NetworkId
WHERE     detail.LoadTestRunId = @LoadTestRunId
          AND EndTime > @StartTime
          AND
          ( 
             (
               TimeStamp >=@StartTime 
               AND TimeStamp <@EndTime            
             )
             OR
             (
               TimeStamp < @StartTime                           
             )
          )
          AND 
          ( 
             (@FilterNoLog = 1 AND TestLogId IS NOT NULL)
             OR
             (@FilterNoLog = 0)
          )
ORDER BY  s.ScenarioId,AgentId,UserId,TestDetailId
END
GO
       
GRANT EXECUTE ON Prc_GetUserTestDetail TO PUBLIC
GO


CREATE PROCEDURE [dbo].[prc_QueryPossibleCountersForReport]    
    @runsxml        NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @docHandle    INT
DECLARE @runs TABLE (
    runId     INT NOT NULL    
)

-- Parse the XML input into a temporary table
EXEC sp_xml_preparedocument @docHandle OUTPUT, @runsxml

INSERT  @runs        
SELECT  i
FROM OPENXML(@docHandle, N'/runs/r', 0)
    WITH (        
        i INT
    )

-- Done with the document now    
EXEC sp_xml_removedocument @docHandle

-- Return Runs Info
SELECT DISTINCT CategoryName, 
       CounterName
FROM   @runs r
JOIN   LoadTestComputedCounterSummary cat
ON     r.runId = cat.LoadTestRunId
ORDER BY CategoryName,CounterName
GO

GRANT EXECUTE ON prc_QueryPossibleCountersForReport TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryComputedCounterSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255),
    @CategoryName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       MachineName,
       CategoryName,
       CounterName,       
       InstanceName,             
       CumulativeValue
FROM  LoadTestComputedCounterSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CategoryName = @CategoryName
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryComputedCounterSummary TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryLoadTestPageSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName, 
       RequestUri,      
       Cumulativevalue
FROM  LoadTestPageSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryLoadTestPageSummary TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryLoadTestTestCaseSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName,       
       Cumulativevalue
FROM  LoadTestTestCaseSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryLoadTestTestCaseSummary TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryLoadTestTransactionSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName,
       TransactionName,
       Cumulativevalue
FROM  LoadTestTransactionSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryLoadTestTransactionSummary TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryLoadTestRequestSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId as LoadTestRunId,
       CounterName,
       ScenarioName,
       TestCaseName,
       RequestUri,
       Cumulativevalue
FROM  LoadTestRequestSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryLoadTestRequestSummary TO PUBLIC
GO

CREATE PROCEDURE Prc_QueryLoadTestScenarioSummary
	@ReportId     INT,
	@CounterName  NVARCHAR(255)	
AS
SELECT LoadTestName,
       a.LoadTestRunId,
       CounterName,
       ScenarioName,
       CumulativeValue
FROM  LoadTestScenarioSummary a
JOIN  LoadTestReportRuns b
ON    a.LoadTestRunId = B.LoadTestRunId
WHERE b.ReportId = @ReportId
      AND CounterName = @CounterName      
ORDER BY a.LoadTestRunId
GO

GRANT EXECUTE ON Prc_QueryLoadTestScenarioSummary TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestPageComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,
       run1.RequestUri,
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun,
       run2.ResponseTimeGoal
FROM   LoadTestPageSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestPageSummary 
             WHERE LoadTestRunId =@ComparisonRun )run2     
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName
       AND  run1.RequestUri = run2.RequestUri
       AND  run1.CounterName = run2.CounterName 
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Page Time'   
       AND run1.TestCaseName != '_Total'      
GO

GRANT EXECUTE ON Prc_QueryLoadTestPageComparison TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestTestComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,       
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun
FROM   LoadTestTestCaseSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestTestCaseSummary 
             WHERE LoadTestRunId = @ComparisonRun) run2
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName  
       AND  run1.CounterName = run2.CounterName     
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Test Time'   
       AND run1.TestCaseName != '_Total'   
       
GO

GRANT EXECUTE ON Prc_QueryLoadTestTestComparison TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestTransactionComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

SELECT run1.ScenarioName,
       run1.TestCaseName,  
       run1.TransactionName,     
       run1.CumulativeValue AS Baseline,
       run2.CumulativeValue AS ComparisonRun
FROM   LoadTestTransactionSummary run1
LEFT JOIN   (SELECT * 
             FROM LoadTestTransactionSummary 
             WHERE LoadTestRunId = @ComparisonRun) run2 
ON     run1.ScenarioName = run2.ScenarioName
       AND  run1.TestCaseName = run2.TestCaseName 
       AND  run1.TransactionName = run2.TransactionName 
       AND  run1.CounterName = run2.CounterName     
WHERE  run1.LoadTestRunId = @Baseline       
       AND run1.CounterName = 'Avg. Response Time'  
       AND run1.TransactionName != '_Total'      
       

GO

GRANT EXECUTE ON Prc_QueryLoadTestTransactionComparison TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_QueryComputedCounterComparison]
    @ReportId      INT,
    @Baseline      INT,
    @ComparisonRun INT
AS


SELECT run.LoadTestRunId AS LoadTestRunId,
       run.MachineName AS MachineName,       
       run.CategoryName AS CategoryName,
       run.CounterName AS CounterName,
       run.HigherIsBetter AS HigherIsBetter,
       run.InstanceName AS InstanceName,
       run.CumulativeValue AS CumulativeValue              
FROM   LoadTestReportPage report
JOIN   LoadTestComputedCounterSummary run
ON     report.CategoryName = run.CategoryName
       AND report.CounterName = run.CounterName     
WHERE  report.ReportId = @ReportId
       AND run.LoadTestRunId in( @Baseline,@ComparisonRun)
       AND (run.CategoryName NOT LIKE 'LoadTest:%'
            OR (run.CategoryName LIKE 'LoadTest:%' AND run.InstanceName = '_Total'))
ORDER BY LoadTestRunId, MachineName, CategoryName, CounterName, InstanceName
GO

GRANT EXECUTE ON Prc_QueryComputedCounterComparison TO PUBLIC
GO

CREATE PROCEDURE [dbo].[prc_QueryForMachinesInRun]    
    @Baseline      INT,
    @ComparisonRun INT
AS
SET NOCOUNT ON


SELECT LoadTestRunId   AS LoadTestRunId,
       ControllerName  AS Machine,
       'Controller'    AS MachineRole
FROM   LoadTestRun
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT LoadTestRunId   AS LoadTestRunId,
       AgentName       AS Machine,
       'Agent'         AS MachineRole
FROM   LoadTestRunAgent       
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT SUT.LoadTestRunId AS LoadTestRunId,
       MachineName       AS Machine,
       MachineTag        AS MachineRole
FROM   LoadTestSystemUnderTest AS SUT
LEFT JOIN   LoadTestSystemUnderTestTag AS Tags
ON     SUT.LoadTestRunId = Tags.LoadTestRunId
       AND SUT.SystemUnderTestId = Tags.SystemUnderTestId 
WHERE  SUT.LoadTestRunId in (@Baseline,@ComparisonRun)
UNION  
SELECT DISTINCT LoadTestRunId   AS LoadTestRunId,
       MachineName              AS Machine,
       NULL                     AS MachineRole
FROM   LoadTestPerformanceCounterCategory    
WHERE  LoadTestRunId in (@Baseline,@ComparisonRun) 
ORDER BY LoadTestRunId, Machine,MachineRole
GO

GRANT EXECUTE ON [prc_QueryForMachinesInRun] TO PUBLIC
GO

CREATE PROCEDURE [dbo].[Prc_QueryLoadTestErrorComparison]
    @Baseline      INT,
    @ComparisonRun INT
AS

DECLARE @errors TABLE (
    LoadTestRunId  INT NOT NULL,
    ErrorType      TINYINT NOT NULL,
    SubType        NVARCHAR(64),
    ErrorCount     INT NOT NULL      
)

--get baseline errors
INSERT INTO @errors
SELECT DISTINCT @Baseline, MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @Baseline
GROUP BY MessageType, SubType

--get comparison errors
INSERT INTO @errors
SELECT DISTINCT @ComparisonRun, MessageType, SubType, COUNT(*) as Count
FROM LoadTestMessage
WHERE LoadTestRunId = @ComparisonRun
GROUP BY MessageType, SubType

--top select gets errors that both runs have and ones that only run1 have
--bottom select gets errors that are only in the comparison run
SELECT run1.ErrorType,
       run1.SubType,       
       run1.ErrorCount AS Baseline,
       run2.ErrorCount AS ComparisonRun       
FROM   @errors run1
LEFT JOIN   (SELECT * FROM @errors WHERE LoadTestRunId = @ComparisonRun) run2
ON     run1.ErrorType = run2.ErrorType
       AND  run1.SubType = run2.SubType       
WHERE  run1.LoadTestRunId = @Baseline  
UNION   
SELECT run2.ErrorType,
       run2.SubType,       
       run1.ErrorCount AS Baseline,
       run2.ErrorCount AS ComparisonRun       
FROM   @errors run2
LEFT JOIN   (SELECT * FROM @errors WHERE LoadTestRunId = @Baseline) run1
ON     run1.ErrorType = run2.ErrorType
       AND  run1.SubType = run2.SubType       
WHERE  run2.LoadTestRunId = @ComparisonRun  
       AND  run1.ErrorType IS NULL
ORDER BY ErrorType, SubType
GO

GRANT EXECUTE ON Prc_QueryLoadTestErrorComparison TO PUBLIC
GO


-- Install each of the error messages into the system message table.
EXEC sp_addmessage 560500, 16, '%s: Generic error - %%error="%d";%% executing %s statement for %s', @lang = 'us_english', @replace = replace       
GO

--Create default Load Test Reports
INSERT INTO LoadTestReport
SELECT 'LOADTEST_RUNCOMPARISON_REPORT_DEFAULT', -- Report Name
       NULL,                                    -- Description
       'LOADTEST_RUNCOMPARISON_REPORT_DEFAULT', -- LoadTest
       -1,                                      -- LastRunId
       1,                                       -- SelectNewRuns
       GetUtcDate(),                            -- LastModified
       '',                                      -- User
       2                                        -- ReportType
       
DECLARE @ReportId INT
SELECT @ReportId = MAX(ReportId) FROM  LoadTestReport

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Memory',
       'Available MBytes'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Network Interface',
       'Bytes Total/sec'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'PhysicalDisk',
       '% Idle Time'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Processor',
       '% Processor Time'  
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Process',
       '% Processor Time'    
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Page',
       'Avg. Page Time' 
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Request',
       'Requests/Sec' 

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Scenario',
       'User Load'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Test',
       'Avg. Test Time'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Test',
       'Total Tests'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Transaction',
       'Avg. Response Time'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Transaction',
       'Total Transactions'

GO

INSERT INTO LoadTestReport
SELECT 'LOADTEST_TREND_REPORT_DEFAULT',         -- Report Name
       NULL,                                    -- Description
       'LOADTEST_TREND_REPORT_DEFAULT',         -- LoadTest
       -1,                                      -- LastRunId
       1,                                       -- SelectNewRuns
       GetUtcDate(),                            -- LastModified
       '',                                      -- User
       1                                        -- ReportType
       
DECLARE @ReportId INT
SELECT @ReportId = MAX(ReportId) FROM  LoadTestReport

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Memory',
       'Available MBytes'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Network Interface',
       'Bytes Total/sec'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'PhysicalDisk',
       '% Idle Time'
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Processor',
       '% Processor Time'  
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'Process',
       '% Processor Time'    
   
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Page',
       'Pages/Sec' 
    
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Page',
       'Avg. Page Time' 
       
INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Request',
       'Requests/Sec' 

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Scenario',
       'User Load'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Test',
       'Avg. Test Time'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Test',
       'Total Tests'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Transaction',
       'Avg. Response Time'

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Transaction',
       'Transactions/Sec' 

INSERT INTO LoadTestReportPage
SELECT @ReportId,
       'LoadTest:Transaction',
       'Total Transactions'

GO

-- Sets DB recovery mode to simple
ALTER DATABASE [LoadTest2010] SET RECOVERY Simple
GO

GRANT CONTROL TO PUBLIC
GO



