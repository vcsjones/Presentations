USE RockNUG

GO

DELETE FROM [dbo].[Session]
DELETE FROM [dbo].[Speaker] 
DELETE FROM [dbo].[Release] 

INSERT INTO [dbo].[Speaker](FirstName,LastName,Bio,Website,Twitter)
SELECT N'Kevin', N'Jones', N'Kevin Jones is an Team Lead and Senior Consultant for LogicBoost, a leading software development company based in Washington DC.', 'http://vcsjones.com', 'vcsjones'
UNION
SELECT N'Scott', N'Lawrence', 'Scott Lawrence works for ARPC', null, null
UNION
SELECT N'Dean', N'Fiala', 'Dean is awesome. Period.', null, null

GO

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
	