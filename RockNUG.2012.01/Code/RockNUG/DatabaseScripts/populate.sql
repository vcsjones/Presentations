DELETE FROM [dbo].[Session]
DELETE FROM [dbo].[Speaker] 
DELETE FROM [dbo].[Release] 

INSERT INTO [dbo].[Speaker](FirstName,LastName,Bio,Website,Twitter)
SELECT N'Kevin', N'Jones', N'Kevin Jones is an Team Lead and Senior Consultant for LogicBoost, a leading software development company based in Washington DC.', 'http://vcsjones.com', 'vcsjones'
UNION
SELECT N'Scott', N'Lawrence', 'Scott Lawrence works for ARPC', null, null
UNION
SELECT N'Dean', N'Fiala', 'Dean is awesome. Period.', null, null
UNION
SELECT N'Kendall', N'Miller', 'Kendall Miller is one of the founding partners of Gibraltar Software, an Independent Software Vendor (ISV) that develops and markets commercial applications for .NET developers, including: Gibraltar -- an application logging and monitoring platform; and VistaDB -- a small-footprint, SQL Server-compatible embedded database engine. Both products are used by customers around the world ranging from individual consultants through Fortune 100 companies and governments.', null, null

GO

UPDATE [dbo].[Speaker]
SET
Mugshot = 0x

INSERT INTO [dbo].[Release]([Version], [Date])
VALUES ('5.8', '1/11/2012')

INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'LINQPad',
	'The coolest way to test your C# code and LINQ expressions.',
	'6:30 PM',
	'7:00 PM',
	0
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Scott' AND s.LastName = 'Lawrence' AND r.Version = '5.8'


INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Announcements / Pizza',
	null,
	'7:00 PM',
	'7:30 PM',
	1
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Dean' AND s.LastName = 'Fiala' AND r.Version = '5.8'
	
	
INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Mobile Development in MVC4',
	'The next version of MVC4 will include new functionality making it easy to display different content for different devices. We''ll learn about this functionality and extending it even further, allowing you to create rich MVC4 applications that look great no matter what you use to look at them on any device.',
	'7:30 PM',
	'9:00 PM',
	2
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Kevin' AND s.LastName = 'Jones' AND r.Version = '5.8'
	
	
----

INSERT INTO [dbo].[Release]([Version], [Date])
VALUES ('5.10', '4/11/2012')

INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'AppHarbor',
	'Continuous delivery done right.',
	'6:30 PM',
	'7:00 PM',
	0
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Kevin' AND s.LastName = 'Jones' AND r.Version = '5.10'


INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Announcements / Pizza',
	null,
	'7:00 PM',
	'7:30 PM',
	1
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Dean' AND s.LastName = 'Fiala' AND r.Version = '5.10'
	
	
INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Massive Scale for ASP.NET Through Ruthless Caching',
	'The fastest query is the one never run - Using Microsoft Server AppFabric Cache and Aspect Oriented Programming (AOP) you can dramatically improve the performance of your web / enterprise application without investing in big hardware or complicated programming. We''ll take a real-world application with performance issues, add AppFabric cache to it using code injection and demonstrate the difference even short term caching can make to your application.',
	'7:30 PM',
	'9:00 PM',
	2
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Kendall' AND s.LastName = 'Miller' AND r.Version = '5.10'
	
	
	
----

INSERT INTO [dbo].[Release]([Version], [Date])
VALUES ('5.11', '5/13/2012')


INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Announcements / Pizza',
	null,
	'7:00 PM',
	'7:30 PM',
	1
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Dean' AND s.LastName = 'Fiala' AND r.Version = '5.11'
	
	
INSERT INTO [dbo].[Session](SpeakerID, ReleaseID, Title, Abstract, [Begin], [End], [Type])
SELECT
	s.ID,
	r.ID,
	'Getting Async with C# 5',
	'The SOME REALLY AWESOME ABSTRACT',
	'7:30 PM',
	'9:00 PM',
	2
FROM
	[dbo].[Speaker] s
CROSS JOIN
	[dbo].[Release] r
WHERE
	s.FirstName = 'Kevin' AND s.LastName = 'Jones' AND r.Version = '5.11'