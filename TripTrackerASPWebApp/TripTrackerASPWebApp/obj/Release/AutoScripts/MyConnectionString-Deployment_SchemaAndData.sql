SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trips](
	[Rp] [uniqueidentifier] NULL,
	[TripType] [int] NOT NULL,
	[EntryType] [int] NOT NULL,
	[EntryDate] [datetime] NULL,
	[Trips] [decimal](25, 13) NULL,
	[ID] [int] NULL,
	[Distance] [decimal](25, 13) NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Rp] [uniqueidentifier] NULL,
	[ID] [int] NOT NULL,
	[FirstName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Teacher] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[School] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Distance] [decimal](25, 13) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vTripSum]
AS
/*
5 trips = 1 dollar
12 miles = 1 dollar
*/
SELECT t.ID, MONTH(EntryDate) AS Month, YEAR(EntryDate) AS Year, SUM(Trips) AS TotalTrips
	, CASE WHEN t.TripType = 1 THEN 'WALK' -- 1 Walk, 2 Bike, 3 Skate\Scoot, 4 School Bus, 5 RTD, 6 Carpool, 7 Car + Walk
			WHEN t.TripType = 2 THEN 'BIKE'
			WHEN t.TripType = 4 THEN 'BUS'
			WHEN t.TripType = 6 THEN 'CARPOOL'
			WHEN t.TripType = 7 THEN 'CAR + WALK' END AS TripType
	, SUM(t.Trips) / 5 + SUM(COALESCE(t.Distance,0)) / 12 AS Dollars
	, MAX(FirstName + LastName) AS FullName
	FROM trips t
	JOIN students s ON s.ID = t.ID
GROUP BY t.ID, MONTH(EntryDate), YEAR(EntryDate),t.TripType


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Periods](
	[Period] [int] NOT NULL,
	[MaxTrips] [int] NULL,
	[Year] [int] NULL,
	[Month] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MonthNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationImport](
	[StudentID_T] [float] NULL,
	[First] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Last] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[School] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Grade] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Registered] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[student#homeroomTeacher] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[distsch___] [float] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[Rp] [uniqueidentifier] NOT NULL,
	[FullName] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[School] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Rp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TripImport](
	[Grade] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Teacher] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Last Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[First Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Student ID(T)] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Student ID] [float] NULL,
	[Walk] [float] NULL,
	[Bike] [float] NULL,
	[Bus] [float] NULL,
	[Carpool] [float] NULL,
	[Car+Walk] [float] NULL,
	[C+W Dist] [float] NULL,
	[F13] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F14] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F15] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F16] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F17] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F18] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F19] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F20] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F21] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F22] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F23] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F24] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F25] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F26] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F27] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F28] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F29] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[F30] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (1, 42, 2016, N'September', 9)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (2, 40, 2016, N'October', 10)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (3, 32, 2016, N'November', 11)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (4, 28, 2017, N'January', 1)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (5, 36, 2017, N'February', 2)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (6, 36, 2017, N'March', 3)
GO
INSERT [dbo].[Periods] ([Period], [MaxTrips], [Year], [Month], [MonthNo]) VALUES (7, 36, 2017, N'April', 4)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167058.6, N'Leidy', N'Abrego-Portillo', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171724.2, N'Michelle', N'Acosta Martinez', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171995.3, N'Genesis', N'Acosta Martinez', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173563.2, N'Denisse', N'Acosta Martinez', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173953.3, N'Jade', N'Acosta Martinez', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172260.3, N'Abilene', N'Adelman', N'Test', N'4', N'R', N'Jette, Elizabeth', 16.45)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171792.6, N'Gustavo', N'Aguijosa Castillo', N'Test', N'3', N'R', N'Johnson, Alexandra D', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167044.9, N'Ivan', N'Aguijosa-Castillo', N'Test', N'1', N'R', N'Diaz, Dulce', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171671.5, N'Christian', N'Aguilar', N'Test', N'3', N'R', N'Johnson, Alexandra D', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172756.8, N'Jonathan', N'Aguilar', N'Test', N'2', N'R', N'Martinez, Enriqueta', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173173.9, N'Camila', N'Aguilar Barron', N'Test', N'1', N'R', N'Smith, Natalia', 2.28)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173522.3, N'Victor', N'Aguilar Barron', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.28)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172343.3, N'Alan', N'Aguilar Monreal', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.56)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166948.1, N'Angel', N'Aguilar Murillo', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.62)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171743.6, N'Javier', N'Aguilar Ramirez', N'Test', N'1', N'R', N'Smith, Natalia', 3.14)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171951.3, N'Adriana', N'Aguirre', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 4.02)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167107.9, N'Veronica', N'Alaniz Cardona', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.36)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167108, N'Victoria', N'Alaniz Cardona', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.36)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172803.5, N'Vanesa', N'Alaniz Cardona', N'Test', N'1', N'R', N'Gilreath, Mary', 2.36)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (165512.8, N'Elmer', N'Alaniz-Muro', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.05)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167012.5, N'Joseline', N'Aldaba Torres', N'Test', N'1', N'R', N'Smith, Natalia', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172504.4, N'Raudel', N'Aldaba Torres', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173767.7, N'Santiago', N'Alegria Lastiri', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 10.94)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167069.2, N'Diego', N'Almeda Solis', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171725.2, N'Steven', N'Almeda Solis', N'Test', N'4', N'R', N'Figueroa, Ignacio', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172449.5, N'Estrella', N'Alpizar', N'Test', N'4', N'R', N'Meyers, Julie', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173741.7, N'Anabella', N'Amaral', N'Test', N'KG', N'R', N'Magee, Jenny', 0.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173789.2, N'Manuel', N'Anica Perez', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173347.6, N'Brysa', N'Aparicio Hernandez', N'Test', N'KG', N'R', N'Potter, Emily', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173069.3, N'Mateo', N'Arden', N'Test', N'2', N'R', N'Martinez, Enriqueta', 3.74)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166070.6, N'Paola', N'Arellano', N'Test', N'1', N'R', N'Smith, Natalia', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172122.1, N'Dustin', N'Arellano Devora', N'Test', N'3', N'R', N'Johnson, Alexandra D', 1.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172535.8, N'Christopher', N'Arellano Devora', N'Test', N'2', N'R', N'Kotnour, Kathy', 1.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171250.9, N'Juanita', N'Arellano Gamboa', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172942.1, N'Diego', N'Arellano Martinez', N'Test', N'1', N'R', N'Diaz, Dulce', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172166.3, N'Alex', N'Arellano Ordaz', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173130.2, N'Alvaro', N'Arellano-Torres', N'Test', N'1', N'R', N'Gilreath, Mary', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173527.4, N'Allison', N'Arias Aguilar', N'Test', N'1', N'R', N'Urroz, Hector', 2.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171272, N'Jason', N'Arias Hernandez', N'Test', N'5', N'R', N'Myers, Laura', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172775.6, N'Dulce', N'Arias Hernandez', N'Test', N'3', N'R', N'Tobin, Melissa', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171917.8, N'Maria', N'Arias-Aguilar', N'Test', N'5', N'R', N'Myers, Laura', 2.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171690, N'Kevin', N'Arredondo', N'Test', N'4', N'R', N'Figueroa, Ignacio', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172539.9, N'Christian', N'Arredondo Fraire', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173038.1, N'Angel', N'Arredondo Monreal', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166751.2, N'Anthony', N'Arredondo-Fraire', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171981, N'Della', N'Baker-Rosenthal', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171263.7, N'Daniel', N'Balderas-Lujan', N'Test', N'5', N'R', N'Myers, Laura', 3.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172522.8, N'Roberto', N'Barcenas Guerrero', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.02)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172392.6, N'Tristan', N'Barrett', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.29)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172281, N'Ariel', N'Bartell', N'Test', N'4', N'R', N'Figueroa, Ignacio', 5.96)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171927.5, N'Mekdes', N'Bass', N'Test', N'3', N'O', N'', 3.12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172498.7, N'Eric', N'Becerra', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173613.2, N'Leonardo', N'Becerra-Zavala', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173976, N'Sofia', N'Becerra-Zavala', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173138.8, N'Sarah', N'Beck', N'Test', N'1', N'R', N'Diaz, Dulce', 2.86)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173144.6, N'Christopher', N'Bellinger', N'Test', N'2', N'R', N'Martinez, Enriqueta', 1.62)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174189.3, N'Brisa', N'Benetiz Torres', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 2.54)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172513.1, N'Qiunn', N'Bernthal', N'Test', N'', N'R', N'Figueroa, Ignacio', 3.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173570.9, N'Gabriela', N'Bickford', N'Test', N'1', N'R', N'Diaz, Dulce', 2.84)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173970.5, N'Raquel', N'Bickford', N'Test', N'KG', N'R', N'Potter, Emily', 2.74)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171545.6, N'Carson', N'Bolgatz', N'Test', N'4', N'R', N'Jette, Elizabeth', 1.19)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171399.1, N'Haley', N'Bonewitz', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.37)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167196.8, N'Tristan', N'Bonta', N'Test', N'1', N'R', N'Urroz, Hector', 2.33)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173813.7, N'Adrian', N'Bonta', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 2.33)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166952, N'Noah', N'Bookman Urroz', N'Test', N'4', N'R', N'Meyers, Julie', 5.37)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172796.8, N'Felice', N'Borden', N'Test', N'3', N'R', N'Johnson, Alexandra D', 3.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173211.5, N'Abigail', N'Borden', N'Test', N'1', N'R', N'Smith, Natalia', 3.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173137.8, N'Aileen', N'Borjon Rodriguez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172031, N'Anna', N'Boromisza-Habashi', N'Test', N'5', N'O', N'Kowalchuk, Sarah .NMN', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173540.2, N'Mira', N'Boromisza-Habashi', N'Test', N'1', N'O', N'Urroz, Hector', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166951.2, N'River', N'Breed-Carithers', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.21)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172296.6, N'Stella', N'Breed-Carithers', N'Test', N'4', N'R', N'Figueroa, Ignacio', 4.21)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172801.3, N'Maria Guadalupe', N'Bretado Ordaz', N'Test', N'1', N'R', N'Diaz, Dulce', 3.13)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173213.2, N'Celina', N'Bretado Ordaz', N'Test', N'KG', N'R', N'Potter, Emily', 3.13)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173953.4, N'Maria', N'Bretado Ordaz', N'Test', N'PK', N'R', N'Davis, Leslie (AM)', 3.13)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172651.4, N'Liam', N'Brod', N'Test', N'3', N'R', N'Johnson, Alexandra D', 2.12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173541.6, N'Clara', N'Buell', N'Test', N'1', N'R', N'Urroz, Hector', 1.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173620.3, N'Abigail', N'Buell', N'Test', N'4', N'R', N'Jette, Elizabeth', 1.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166248.6, N'Alexander', N'Bustos', N'Test', N'1', N'R', N'Diaz, Dulce', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172704.1, N'Bryant', N'Callahan', N'Test', N'2', N'O', N'Pesquera, Sonia .NMN', 4.87)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173153.3, N'Cash', N'Callahan', N'Test', N'KG', N'O', N'Arrieta, Cindy', 4.87)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174172.9, N'Gabriela', N'Camacho-Sager', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 2.19)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172945.6, N'Juan', N'Canales Hernandez', N'Test', N'1', N'R', N'Urroz, Hector', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172945.5, N'Luis', N'Canales-Hernandez', N'Test', N'1', N'R', N'Gilreath, Mary', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167083.9, N'Aidan', N'Cardona Ramirez', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 3.14)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167031.7, N'Simon', N'Cardona-Nunez', N'Test', N'2', N'O', N'Nelson, Sara .NMN', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174002.6, N'Mercedes', N'Carr', N'Test', N'KG', N'R', N'Magee, Jenny', 2.32)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173323.4, N'Gustavo', N'Castro Calderon', N'Test', N'KG', N'R', N'Mares morales, Maria', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171840.1, N'Adolfo', N'Castro-Cital', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 2.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166551.6, N'Genaro', N'Cercas-Munoz', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172793.2, N'Alan', N'Cerceda-Barron', N'Test', N'3', N'R', N'Johnson, Alexandra D', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173145.5, N'Ellen', N'Ceres', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 6.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167016.1, N'Edgar', N'Chagala Macedonio', N'Test', N'1', N'R', N'Smith, Natalia', 1.44)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173522, N'Ingrid', N'Chagala Macedonio', N'Test', N'PK', N'R', N'Davis, Leslie (AM)', 1.44)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171759.5, N'Vanessa', N'Chairez Gamboa', N'Test', N'3', N'R', N'Johnson, Alexandra D', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172909.1, N'Julissa', N'Chairez Gamboa', N'Test', N'KG', N'O', N'Potter, Emily', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167067.5, N'Bryan', N'Chairez Martinez', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.56)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167002.5, N'Concepcion', N'Chigo Cagal', N'Test', N'1', N'R', N'Urroz, Hector', 3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171118.4, N'Maria', N'Chigo Cagal', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171720, N'Marisol', N'Chihuahua Montes', N'Test', N'4', N'R', N'Figueroa, Ignacio', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174154.8, N'Elias', N'Christol', N'Test', N'', N'R', N'Arrieta, Cindy', 1.49)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172113.9, N'Hannah', N'Cohen', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 1.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171076.1, N'Bryan', N'Colis', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172509.1, N'Sabrina', N'Colis', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171555.2, N'Samuel', N'Colis Delgado', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172292.4, N'Vivian', N'Congedo', N'Test', N'3', N'R', N'Tobin, Melissa', 2.46)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171901.8, N'Samuel', N'Cook', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.29)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173294.5, N'Charlene', N'Cortez Vargas', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166551.4, N'Javier', N'Cortez-Vargas', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172274.2, N'Sova', N'Coyle', N'Test', N'2', N'O', N'', 3.43)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172743.9, N'Charles', N'Coyle', N'Test', N'1', N'O', N'', 3.43)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173021.5, N'Caio', N'Cullison-Assuncao', N'Test', N'2', N'R', N'Kotnour, Kathy', 1.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173227.6, N'Toray', N'Davis', N'Test', N'2', N'O', N'Pesquera, Sonia .NMN', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173912.1, N'Karina', N'Day', N'Test', N'KG', N'R', N'Mares morales, Maria', 16.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167072.4, N'Coulter', N'Dayton', N'Test', N'KG', N'R', N'Potter, Emily', 1.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172721.8, N'Pierce', N'Dayton', N'Test', N'2', N'R', N'Kotnour, Kathy', 1.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166948.6, N'Guadalupe', N'De La Cruz Arellano', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174037.9, N'Ezequiel', N'De La Hoya Garcia', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 2.85)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172785.8, N'Lucia', N'De La Lama', N'Test', N'3', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172909.2, N'Gabriel', N'De La Lama', N'Test', N'1', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167129.9, N'Dylan', N'Delgado-Salas', N'Test', N'KG', N'R', N'Mares morales, Maria', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173736.5, N'Kassandra', N'Devora Gonzalez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 2.05)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173820, N'Roberto', N'Devora Padilla', N'Test', N'KG', N'R', N'Magee, Jenny', 2.05)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172974.6, N'Kadin', N'Doles', N'Test', N'2', N'R', N'Martinez, Enriqueta', 1.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173131.6, N'Violet', N'D''Onofrio', N'Test', N'1', N'R', N'Gilreath, Mary', 1.37)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173164.7, N'Benjamin', N'Duke', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.96)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171973.7, N'Oren Atticus Binx', N'Dutton', N'Test', N'05H', N'O', N'Myers, Laura', 14.63)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172762.7, N'Quinlan', N'Eberle-Taylor', N'Test', N'3', N'O', N'Tobin, Melissa', 14.12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173536.5, N'William', N'Eberle-Taylor', N'Test', N'1', N'O', N'Gilreath, Mary', 14.12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172128.6, N'Lizette', N'Elizalde Zamora', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172274.8, N'Eugene', N'Ellsworth Bowers', N'Test', N'3', N'R', N'', 3.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167086.2, N'James', N'Embry', N'Test', N'1', N'R', N'Smith, Natalia', 3.94)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173499.5, N'Evan', N'Embry', N'Test', N'KG', N'R', N'Potter, Emily', 3.94)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172424.4, N'Levi', N'Epstein', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 20)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173527.3, N'Aiden', N'Erickson', N'Test', N'1', N'O', N'Smith, Natalia', 10.59)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167011, N'Fatima', N'Escobar', N'Test', N'3', N'R', N'Johnson, Alexandra D', 0.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166955.8, N'Ayleen', N'Esparza Arellano', N'Test', N'4', N'R', N'Figueroa, Ignacio', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172106.1, N'Christian', N'Esparza Arellano', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171981.9, N'Paloma', N'Espinosa', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.4)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171982.8, N'Azul', N'Espinosa', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 2.4)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173999.8, N'Arya', N'Featherstone', N'Test', N'KG', N'R', N'Magee, Jenny', 12.42)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167171, N'Martin', N'Fernandez Jaquez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167172.8, N'Jayson', N'Fernandez Zavala', N'Test', N'KG', N'R', N'Potter, Emily', 3.85)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172374.6, N'Lola', N'Ferrell', N'Test', N'4', N'R', N'Jette, Elizabeth', 8.06)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173144.5, N'Kian', N'Feurtado-Morgan', N'Test', N'2', N'R', N'', 1.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167053.4, N'Mason', N'Fischer', N'Test', N'1', N'R', N'Smith, Natalia', 12.56)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166886.5, N'Tessa', N'Fox', N'Test', N'5', N'R', N'Myers, Laura', 6.23)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171874.2, N'Sylvie', N'Fox', N'Test', N'3', N'R', N'Tobin, Melissa', 11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172368.5, N'Alvaro', N'Fraire Monrreal', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173181.5, N'Allison', N'Fraire Monrreal', N'Test', N'KG', N'R', N'Arrieta, Cindy', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172146.3, N'Jaimie', N'Fuentes Leiva', N'Test', N'4', N'R', N'Meyers, Julie', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172146.4, N'Santiago', N'Fuentes Leiva', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172519.1, N'Angel', N'Galvan Badillo', N'Test', N'4', N'R', N'Meyers, Julie', 2.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173486.9, N'Emiliano', N'Galvan-Reyes', N'Test', N'1', N'R', N'Diaz, Dulce', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172996.1, N'Jorge', N'Garcia', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173916.8, N'Jose', N'Garcia', N'Test', N'KG', N'R', N'Potter, Emily', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171999.6, N'Alma', N'Garcia Aguilar', N'Test', N'3', N'R', N'Tobin, Melissa', 2.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172797.6, N'Camila', N'Garcia Aguilar', N'Test', N'1', N'R', N'Gilreath, Mary', 2.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167010, N'Marely', N'Garcia Estrada', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173150.9, N'Heidy', N'Garcia Estrada', N'Test', N'KG', N'R', N'Potter, Emily', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173986.9, N'Yamileth', N'Garcia Nunez', N'Test', N'KG', N'R', N'Magee, Jenny', 7.75)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173982.6, N'Allyson', N'Garcia Sanchez', N'Test', N'KG', N'O', N'Magee, Jenny', 2.04)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171751.9, N'Ruby', N'Garcia-Martinez', N'Test', N'1', N'R', N'Urroz, Hector', 2.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166313.5, N'Diego', N'Garcia-Zapatero', N'Test', N'2', N'R', N'Martinez, Enriqueta', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172222.3, N'Wallace', N'Gilreath', N'Test', N'4', N'R', N'Meyers, Julie', 18)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173057, N'Clarence', N'Gilreath', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172361.8, N'Charles', N'Goetz', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 3.75)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174038.6, N'Neo', N'Gonzalez Flores', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 1.65)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173121.8, N'Daniel', N'Gonzalino', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.14)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171955.8, N'Diego', N'Goodwin', N'Test', N'5', N'O', N'Myers, Laura', 3.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173031.7, N'Isabella', N'Goodwin', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167012.7, N'Allison', N'Gordillo Perez', N'Test', N'3', N'R', N'Johnson, Alexandra D', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171293.4, N'Emily', N'Gordillo Perez', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166432.9, N'Sebastian', N'Griebel', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173489.3, N'Seneca', N'Griebel', N'Test', N'KG', N'R', N'Potter, Emily', 3.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173872.5, N'Silas', N'Groves', N'Test', N'1', N'R', N'Diaz, Dulce', 1.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173872.8, N'Isadora', N'Groves', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 1.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172384.3, N'Fernanda', N'Guerrero', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173788.3, N'Jessica', N'Guerrero Devora', N'Test', N'KG', N'R', N'Mares morales, Maria', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173425, N'Andres', N'Guerrero Lopez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173521.7, N'Miguel', N'Guerrero Ordaz', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172443.1, N'Selena', N'Guevara', N'Test', N'3', N'O', N'Gonzalez figueroa, Lourdes .NM', 10.92)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172745.5, N'Jacob', N'Gurrola', N'Test', N'4', N'R', N'Figueroa, Ignacio', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171694.5, N'Julissa', N'Gutierrez Navarro', N'Test', N'4', N'R', N'Meyers, Julie', 2.91)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171951.4, N'Jade', N'Haag-Toney', N'Test', N'5', N'O', N'Myers, Laura', 2.13)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166968.5, N'Dylan', N'Haney', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 3.26)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171448.3, N'Rhys', N'Haney', N'Test', N'4', N'R', N'Figueroa, Ignacio', 3.26)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174010.2, N'Bailey', N'Hayes', N'Test', N'KG', N'R', N'Arrieta, Cindy', 2.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166893, N'Jaden', N'Henkel', N'Test', N'4', N'R', N'Meyers, Julie', 2.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166451.4, N'Victoria', N'Hernandez', N'Test', N'KG', N'R', N'Mares morales, Maria', 4.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171262, N'Leslie', N'Hernandez', N'Test', N'5', N'R', N'Myers, Laura', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171674, N'Jose', N'Hernandez', N'Test', N'5', N'R', N'Myers, Laura', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172380.5, N'Jonathan', N'Hernandez', N'Test', N'4', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173890.7, N'Anthony', N'Hernandez', N'Test', N'KG', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172178.9, N'Yasmin', N'Hernandez Altamira', N'Test', N'4', N'O', N'Jette, Elizabeth', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167072.8, N'Oliver', N'Hernandez Cornelio', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 1.8)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171582.7, N'Eric', N'Hernandez-Garcia', N'Test', N'4', N'R', N'Meyers, Julie', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172118.3, N'Andrea', N'Herrera Rincon', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.64)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173132.2, N'Maite', N'Herrera Rincon', N'Test', N'KG', N'R', N'Mares morales, Maria', 2.64)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166983.2, N'Andres', N'Herrera-Murillo', N'Test', N'1', N'R', N'Diaz, Dulce', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173805.9, N'August', N'Hildreth', N'Test', N'2', N'R', N'Kotnour, Kathy', 1.71)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173909.3, N'Aidan', N'Hite', N'Test', N'KG', N'R', N'Mares morales, Maria', 3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171666.1, N'Jonathan', N'Ibarra', N'Test', N'4', N'R', N'Meyers, Julie', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171991.3, N'Jorge', N'Ibarra', N'Test', N'3', N'R', N'Johnson, Alexandra D', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173496.6, N'Danicka', N'Iturbe', N'Test', N'KG', N'R', N'Magee, Jenny', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166994.9, N'Jonathan', N'Jaimes Mena', N'Test', N'KG', N'R', N'Magee, Jenny', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173890.4, N'Lucas', N'Jaramillo Ortman', N'Test', N'KG', N'R', N'Potter, Emily', 3.46)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171543.7, N'McKenzie', N'Jones', N'Test', N'5', N'R', N'Myers, Laura', 0.96)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172357.6, N'Ashley', N'Juarez-Portillo', N'Test', N'4', N'R', N'Meyers, Julie', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173218.8, N'Tomas', N'Juza', N'Test', N'4', N'O', N'Figueroa, Ignacio', 8.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173291.7, N'Matteus', N'Juza', N'Test', N'2', N'O', N'Kotnour, Kathy', 8.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173138.7, N'Lincoln', N'Kamundia', N'Test', N'KG', N'O', N'', 1.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173497.2, N'Andrew', N'Kelton', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 1.28)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173497.4, N'Benjamin', N'Kelton', N'Test', N'PK', N'R', N'', 1.28)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171690.4, N'Aurelia', N'Kembel', N'Test', N'4', N'O', N'Meyers, Julie', 7.15)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171894.2, N'Isabel', N'Kembel', N'Test', N'3', N'O', N'Gonzalez figueroa, Lourdes .NM', 7.15)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173563.4, N'Eva', N'Kembel', N'Test', N'PK', N'O', N'Garcia, Jennifer (AM)', 7.15)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173666.3, N'Savannah', N'Kieffer', N'Test', N'1', N'O', N'', 8.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173641.3, N'Annika', N'King', N'Test', N'1', N'R', N'Urroz, Hector', 1.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173742, N'Siri', N'King', N'Test', N'KG', N'R', N'Magee, Jenny', 1.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172240, N'Quinn', N'Kingsbury', N'Test', N'4', N'R', N'Jette, Elizabeth', 16.52)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171972.2, N'Jackson', N'Kirshner', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.04)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172218.6, N'Rebecca', N'Kless', N'Test', N'4', N'R', N'Jette, Elizabeth', 1.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173050.3, N'Sienna', N'Kless', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 1.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171922.8, N'Jaya', N'Kohm', N'Test', N'5', N'R', N'Myers, Laura', 8.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173143.3, N'Maddox', N'Koler Stage', N'Test', N'2', N'R', N'Kotnour, Kathy', 20)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171875.4, N'Taytem', N'Kowalchuk', N'Test', N'4', N'R', N'Figueroa, Ignacio', 10.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172707.3, N'Boone', N'Kowalchuk', N'Test', N'2', N'R', N'Martinez, Enriqueta', 10.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172671.4, N'Daelin', N'Krutsinger Swenson', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.38)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173131.5, N'Juno', N'Kuhns', N'Test', N'KG', N'O', N'Arrieta, Cindy', 1.39)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173569.5, N'Nyssa', N'Lane', N'Test', N'1', N'R', N'Smith, Natalia', 7.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173569.7, N'Annora', N'Lane', N'Test', N'1', N'R', N'Diaz, Dulce', 7.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174172.3, N'Gabriela', N'Lavasida Rascon', N'Test', N'PK', N'R', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173882.1, N'David', N'Lawson', N'Test', N'KG', N'R', N'Potter, Emily', 0.86)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171672.8, N'Mikayah', N'Levy Wright', N'Test', N'4', N'R', N'Meyers, Julie', 3.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172780.1, N'John', N'Linsenmeyer', N'Test', N'3', N'O', N'Gonzalez figueroa, Lourdes .NM', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171724.9, N'Stefan', N'Lippold Sustache', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 4.12)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172115.4, N'Giorgio', N'Loffredo', N'Test', N'5', N'R', N'Myers, Laura', 2.32)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171974.9, N'Denise', N'Longoria Portillo', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 3.09)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172367.3, N'Adamaris', N'Longoria Portillo', N'Test', N'4', N'R', N'Jette, Elizabeth', 3.09)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171720.2, N'Alejandro', N'Longoria-Rodriguez', N'Test', N'4', N'R', N'Jette, Elizabeth', 10.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172731.7, N'Andrea', N'Lopez', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 3.13)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171703.8, N'Reina', N'Lopez Argumedo', N'Test', N'5', N'O', N'Bovino, Gisela .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173383.4, N'Erick', N'Lopez Beltran', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172801.8, N'Hector', N'Lopez Gutierrez', N'Test', N'3', N'R', N'Johnson, Alexandra D', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174011.9, N'Jovanni', N'Lopez Gutierrez', N'Test', N'KG', N'R', N'Mares morales, Maria', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172130.6, N'Lesly', N'Lopez Ramirez', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173357.2, N'Yoeli', N'Lopez Ramirez', N'Test', N'1', N'R', N'Gilreath, Mary', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166718.9, N'Edith', N'Lopez Zepeda', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.01)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166940.1, N'Eduardo', N'Lopez Zepeda', N'Test', N'1', N'R', N'Smith, Natalia', 2.01)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166945, N'Christopher', N'Lopez-Avalos', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171900.3, N'Caesar', N'Lopez-Avalos', N'Test', N'3', N'R', N'Tobin, Melissa', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172555.7, N'Cristian', N'Lopez-Organista', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 9.65)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171759.7, N'Jesus', N'Lopez-Zepeda', N'Test', N'3', N'R', N'Tobin, Melissa', 2.01)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173698.4, N'Hayden', N'Loredo', N'Test', N'2', N'R', N'Kotnour, Kathy', 2.72)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174126.6, N'Cole', N'Loredo', N'Test', N'KG', N'O', N'Arrieta, Cindy', 13.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172380.6, N'Summit', N'Louth', N'Test', N'4', N'R', N'Jette, Elizabeth', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173238.9, N'Niamh', N'Lowrimore', N'Test', N'4', N'R', N'Jette, Elizabeth', 7.48)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173643.7, N'Kieran', N'Lowrimore', N'Test', N'1', N'R', N'Gilreath, Mary', 7.48)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (165920.6, N'Cristian', N'Luna-Zapatero', N'Test', N'3', N'R', N'Tobin, Melissa', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172005.3, N'Miguel', N'Macareno Carrillo', N'Test', N'5', N'R', N'', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173182.2, N'Alexis', N'Macareno Carrillo', N'Test', N'2', N'R', N'', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172540.4, N'Julyssa', N'Macias Ruiz', N'Test', N'3', N'R', N'Johnson, Alexandra D', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173670.8, N'Taj', N'Mandy', N'Test', N'1', N'R', N'Gilreath, Mary', 3.04)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173671.1, N'Ella', N'Mandy', N'Test', N'4', N'R', N'Meyers, Julie', 3.04)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172364.7, N'Colton', N'Mann', N'Test', N'4', N'R', N'', 3.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173183.5, N'Skyler', N'Martin', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 3.55)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173177.7, N'Angel', N'Martinez', N'Test', N'2', N'R', N'Kotnour, Kathy', 4.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173189.1, N'Samantha', N'Martinez', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 3.08)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166759.2, N'Valeria', N'Martinez Alvarado', N'Test', N'5', N'R', N'Myers, Laura', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167070.6, N'Evelyn', N'Martinez Alvarado', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167174.7, N'Alexis', N'Martinez Martinez', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171998.2, N'Jaqueline', N'Martinez Martinez', N'Test', N'3', N'R', N'Tobin, Melissa', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171292.1, N'Kevin', N'Martinez-Perez', N'Test', N'5', N'R', N'Myers, Laura', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174165.7, N'Gabriella', N'Mbagoyi', N'Test', N'4', N'R', N'Lizette', 20)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173694.7, N'Carter', N'McCoy', N'Test', N'2', N'O', N'Nelson, Sara .NMN', 10.77)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173694.8, N'Tyler', N'McCoy', N'Test', N'5', N'O', N'Bovino, Gisela .NMN', 10.77)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173141.1, N'Joaquin', N'McKee', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 4.71)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173348.8, N'Karla', N'Melara-Hernandez', N'Test', N'1', N'R', N'Diaz, Dulce', 0.52)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174073.8, N'Cartier', N'Meyer-Lesiuk', N'Test', N'', N'R', N'Magee, Jenny', 8.14)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173120.8, N'Amalia', N'Milstein', N'Test', N'3', N'R', N'Johnson, Alexandra D', 16.11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173133.5, N'Gabriel', N'Mitchell', N'Test', N'1', N'R', N'Diaz, Dulce', 8.62)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171900.2, N'Michael', N'Molina-Cardenas', N'Test', N'3', N'O', N'Johnson, Alexandra D', 1.41)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173178.1, N'Fatima', N'Monreal Arellano', N'Test', N'1', N'R', N'Natalia', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173596.1, N'Jazmin', N'Monreal Ordaz', N'Test', N'1', N'R', N'Urroz, Hector', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172004.9, N'Emily', N'Montes-Ramirez', N'Test', N'3', N'R', N'Johnson, Alexandra D', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172795.2, N'Lindsey', N'Montes-Ramirez', N'Test', N'1', N'R', N'Diaz, Dulce', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166724.6, N'Ivan', N'Montes-Zavala', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.01)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167017.5, N'Raul', N'Morales', N'Test', N'1', N'R', N'Urroz, Hector', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172800.8, N'April', N'Morales', N'Test', N'3', N'R', N'Johnson, Alexandra D', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171250.6, N'Andrea', N'Moreno Contreras', N'Test', N'5', N'R', N'Myers, Laura', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172510.8, N'Reilly', N'Moreno Fabela', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173321.6, N'Camila', N'Morquecho Castruita', N'Test', N'1', N'R', N'Smith, Natalia', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167066.9, N'Ivon', N'Morquecho Zavala', N'Test', N'1', N'R', N'Diaz, Dulce', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171291.3, N'Omar', N'Morquecho Zavala', N'Test', N'5', N'R', N'Myers, Laura', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173970.8, N'Pia', N'Mortimer', N'Test', N'KG', N'O', N'', 0.99)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173945.8, N'Milo', N'Mowen', N'Test', N'KG', N'O', N'Mares morales, Maria', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172337.4, N'Sebastian', N'Muir', N'Test', N'4', N'R', N'Figueroa, Ignacio', 1.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172655, N'Anna', N'Munro', N'Test', N'3', N'O', N'Tobin, Melissa', 1.98)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171999.5, N'Alexis', N'Murillo', N'Test', N'3', N'R', N'Tobin, Melissa', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172805.5, N'Kimberly', N'Murillo', N'Test', N'1', N'R', N'Smith, Natalia', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172942.8, N'Ximena', N'Murillo', N'Test', N'1', N'R', N'Diaz, Dulce', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167011.1, N'Cristian', N'Murillo Jaime', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173181.4, N'Valery', N'Murillo Jaime', N'Test', N'KG', N'R', N'Potter, Emily', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171562.2, N'Luis', N'Murillo Ramirez', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172508.5, N'Analis', N'Murillo-Rodriguez', N'Test', N'2', N'R', N'Martinez, Enriqueta', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173200.8, N'Sheamus', N'Murphy', N'Test', N'3', N'R', N'Tobin, Melissa', 2.77)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172719.7, N'Gael', N'Najera', N'Test', N'3', N'R', N'Tobin, Melissa', 9.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171979.6, N'Van', N'Nelson', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173313.6, N'Jacobi', N'Olivares', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.95)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174055.2, N'Julia', N'Olsen', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174055.3, N'Lars', N'Olsen', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171291.9, N'Jose', N'Ordaz Garcia', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173359.2, N'Katheryn', N'Ordaz Garcia', N'Test', N'KG', N'R', N'Arrieta, Cindy', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166036.7, N'Betsy', N'Ordaz Lopez', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 0.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166037.1, N'Maria Hannah', N'Ordaz Lopez', N'Test', N'4', N'R', N'Meyers, Julie', 0.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167144.8, N'Valeria', N'Ordaz-Garcia', N'Test', N'KG', N'R', N'Potter, Emily', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173170.9, N'Sydney', N'Oremus', N'Test', N'2', N'R', N'Martinez, Enriqueta', 1.84)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172509, N'Cesar', N'Ortiz', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173911.9, N'Anthony', N'Ortiz', N'Test', N'PK', N'O', N'', 2.59)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174065.2, N'Dahlia', N'Oviatt', N'Test', N'KG', N'O', N'Potter, Emily', 6.28)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173910.3, N'Luna', N'Pages', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 6.64)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171873.9, N'John', N'Paradiso', N'Test', N'4', N'O', N'Meyers, Julie', 1.87)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172116.9, N'Ashley', N'Perales', N'Test', N'5', N'R', N'Myers, Laura', 2.29)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167095.1, N'Jorge', N'Perales Salazar', N'Test', N'PK', N'O', N'', 2.29)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171699.3, N'Isabela', N'Perez', N'Test', N'4', N'R', N'Meyers, Julie', 2.27)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172516.5, N'Sylvana', N'Perez', N'Test', N'2', N'O', N'Pesquera, Sonia .NMN', 2.27)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166971.8, N'Itzel', N'Perez-Garcia', N'Test', N'1', N'r', N'Gilreath, Mary', 2.81)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167074, N'Maria', N'Perez-Ledezma', N'Test', N'KG', N'R', N'Magee, Jenny', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173974.7, N'Henry', N'Poe', N'Test', N'KG', N'R', N'Arrieta, Cindy', 2.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173287.9, N'Zaya', N'Pohl', N'Test', N'2', N'O', N'Pesquera, Sonia .NMN', 5.63)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171909.7, N'Diana', N'Ponce', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 0.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172535, N'Abigail', N'Ponce Prado', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 0.47)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167008.3, N'Beau', N'Pryor', N'Test', N'KG', N'O', N'Arrieta, Cindy', 0.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173134.6, N'Charlotte', N'Pryor', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 0.34)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167031.5, N'Antoni', N'Puente Vasquez', N'Test', N'KG', N'R', N'Magee, Jenny', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173962, N'Andrea', N'Quijada', N'Test', N'KG', N'R', N'Mares morales, Maria', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166965.2, N'Michael', N'Quijada Escobar', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172343.2, N'Viquel', N'Ramirez Aguilar', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.29)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166959, N'Lizbet', N'Ramirez Escalante', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171082.6, N'Alexa', N'Ramirez Escalante', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166949.7, N'Sebastian', N'Ramirez Medina', N'Test', N'2', N'R', N'Martinez, Enriqueta', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172745.3, N'Jocelyn', N'Ramirez Ordaz', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 2.53)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172122.4, N'Jorge', N'Ramirez Ramirez', N'Test', N'3', N'R', N'Tobin, Melissa', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171727.1, N'Flavio', N'Ramirez-Alaniz', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173344, N'Luis', N'Ramirez-Segura', N'Test', N'2', N'R', N'Martinez, Enriqueta', 2.85)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173538.1, N'Charles', N'Raveczky Orlando', N'Test', N'1', N'R', N'Urroz, Hector', 3.19)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167196.4, N'Gabriel', N'Reynolds Marti', N'Test', N'PK', N'R', N'Davis, Leslie (AM)', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173349.1, N'Alexander', N'Reynolds Marti', N'Test', N'KG', N'R', N'Magee, Jenny', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171196.5, N'Alan', N'Ricardo-Martinez', N'Test', N'4', N'R', N'Meyers, Julie', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167052.4, N'Edwin', N'Rincon Zavala', N'Test', N'1', N'R', N'Urroz, Hector', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172762.4, N'Shelsy', N'Rincon Zavala', N'Test', N'3', N'R', N'Tobin, Melissa', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171337.1, N'Emma', N'Rincon-Zavala', N'Test', N'4', N'R', N'Figueroa, Ignacio', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172793.4, N'Jack', N'Rissman', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 4.42)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173545.2, N'Skyler', N'Robertson', N'Test', N'1', N'R', N'Gilreath, Mary', 5.66)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173122.6, N'Allan', N'Robison', N'Test', N'2', N'R', N'Martinez, Enriqueta', 9.18)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173539.8, N'Alexander', N'Rodarte Badillo', N'Test', N'1', N'R', N'Gilreath, Mary', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166956, N'Aileen', N'Rodriguez', N'Test', N'4', N'R', N'Figueroa, Ignacio', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167010.9, N'Alessa', N'Rodriguez', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173098.6, N'Emmanuel', N'Rodriguez', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172383.5, N'Ian', N'Rodriguez Arellano', N'Test', N'2', N'O', N'Nelson, Sara .NMN', 3.11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166969.8, N'Allan', N'Rodriguez Gomez', N'Test', N'1', N'R', N'Gilreath, Mary', 3.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171461.1, N'Salomon', N'Rodriguez Gomez', N'Test', N'4', N'R', N'Meyers, Julie', 3.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172107.6, N'Bryan', N'Rodriguez Portillo', N'Test', N'4', N'R', N'Figueroa, Ignacio', 2.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173535.9, N'Zahira', N'Rodriguez Portillo', N'Test', N'KG', N'R', N'Magee, Jenny', 2.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171704.2, N'Jose', N'Rodriguez-Arellano', N'Test', N'4', N'R', N'Figueroa, Ignacio', 3.11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172399.5, N'Jeremy', N'Roe', N'Test', N'3', N'R', N'Johnson, Alexandra D', 16.66)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172757, N'Samantha', N'Roe', N'Test', N'1', N'R', N'Smith, Natalia', 16.66)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173949.8, N'Isaac', N'Roetto', N'Test', N'KG', N'O', N'Magee, Jenny', 0.43)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173867, N'Delia', N'Rojas', N'Test', N'KG', N'O', N'Potter, Emily', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173954, N'Albert', N'Rojas', N'Test', N'PK', N'O', N'Garcia, Jennifer (PM)', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167022.7, N'Angel', N'Romero Herrera', N'Test', N'KG', N'O', N'', 1.62)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173092.4, N'Miriam', N'Romero Robles', N'Test', N'2', N'R', N'Kotnour, Kathy', 3.69)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173563.1, N'Diana', N'Rosales Jimenez', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172327.3, N'Sebastian', N'Rothschild Balzan', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 2.39)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172069.3, N'Gabriel', N'Rothschild-Balzan', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 2.39)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173899.1, N'Lorelai', N'Royer', N'Test', N'PK', N'O', N'', 9.06)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174017.4, N'Noah', N'Rubin', N'Test', N'KG', N'R', N'Arrieta, Cindy', 3.67)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174047.6, N'Tobias', N'Rubin', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 5.97)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167127.3, N'Eksar', N'Ruiz', N'Test', N'KG', N'R', N'Potter, Emily', 1.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173425.6, N'Lilian', N'Ruskay', N'Test', N'1', N'O', N'Smith, Natalia', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172503.2, N'Skylar', N'Rutkowski', N'Test', N'4', N'R', N'Figueroa, Ignacio', 0.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173312.2, N'Jordan', N'Rutkowski', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 0.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173950.6, N'Noa', N'Saber', N'Test', N'KG', N'R', N'Arrieta, Cindy', 8.73)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173652.7, N'Jennyfer', N'Salvador Flores', N'Test', N'1', N'R', N'Urroz, Hector', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171998.8, N'Chayton', N'Sampson', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 3.77)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172706.2, N'Takoda', N'Sampson', N'Test', N'1', N'R', N'Gilreath, Mary', 3.77)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167145.5, N'Leonardo', N'Sanchez Arreola', N'Test', N'PK', N'R', N'Davis, Leslie (PM)', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172999.4, N'Ximena', N'Sanchez Devora', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 1.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173535.4, N'Vlaney', N'Sanchez Devora', N'Test', N'1', N'R', N'Urroz, Hector', 1.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167070.9, N'Lisette', N'Sanchez Escalante', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 1.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166972.4, N'Jayden', N'Sanchez Garcia', N'Test', N'KG', N'O', N'Magee, Jenny', 3.11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173781.5, N'Leonardo', N'Schlipf', N'Test', N'1', N'R', N'', 0.95)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173621.3, N'George', N'Schmid', N'Test', N'4', N'R', N'Jette, Elizabeth', 2.22)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173621.4, N'Juniper', N'Schmid', N'Test', N'1', N'R', N'Gilreath, Mary', 2.22)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173554.2, N'Kenneth', N'Schorr', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 9.14)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172185.4, N'Nelsy', N'Segovia Ibarra', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 3.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173795.6, N'Ariana', N'Segovia Ibarra', N'Test', N'PK', N'O', N'Davis, Leslie (AM)', 3.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173626, N'Amaya', N'Sepulveda Visbeck', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172790.7, N'Sebastian', N'Sermeno-Urroz', N'Test', N'3', N'R', N'Tobin, Melissa', 8.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172792.3, N'Nicholas', N'Sermeno-Urroz', N'Test', N'3', N'R', N'Johnson, Alexandra D', 8.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173910.4, N'Eleanor', N'Sheppard', N'Test', N'PK', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173916.1, N'Walter', N'Sheppard', N'Test', N'KG', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171316.3, N'Yasmeen', N'Silva', N'Test', N'1', N'R', N'Gilreath, Mary', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172909.4, N'Abel', N'Silva', N'Test', N'1', N'R', N'Urroz, Hector', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167024, N'Alisson', N'Silva Ordaz', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 2.31)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173866.8, N'Lydia', N'Simkin', N'Test', N'KG', N'R', N'Arrieta, Cindy', 0.17)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171844.3, N'Felix', N'Slade', N'Test', N'4', N'R', N'Figueroa, Ignacio', 4.02)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172697.2, N'Javier', N'Slade', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 4.02)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172709.3, N'Giselle', N'Sloan', N'Test', N'1', N'R', N'Urroz, Hector', 2.96)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173898.7, N'Cassidy', N'Sloan', N'Test', N'PK', N'O', N'Davis, Leslie (AM)', 2.96)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172422.9, N'Bryan', N'Soledad-Puebla', N'Test', N'4', N'R', N'Jette, Elizabeth', 1.62)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174121.2, N'Raquel', N'Solis', N'Test', N'4', N'R', N'Jette, Elizabeth', 0.49)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173347, N'Katie', N'Soria Sanchez', N'Test', N'KG', N'O', N'', 1.37)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173569.6, N'Alexa', N'Soto Gonzalez', N'Test', N'1', N'R', N'Gilreath, Mary', 1.4)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173484.5, N'Danni', N'Steig', N'Test', N'KG', N'O', N'Magee, Jenny', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166886.1, N'Shea', N'Stillman', N'Test', N'5', N'R', N'Kowalchuk, Sarah .NMN', 3.36)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171859.8, N'Noah', N'Stoddard', N'Test', N'4', N'R', N'Meyers, Julie', 1.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173126.8, N'Lia', N'Stoddard', N'Test', N'2', N'O', N'Nelson, Sara .NMN', 1.57)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173099.5, N'Bintang', N'Stone', N'Test', N'1', N'R', N'Gilreath, Mary', 2.85)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171882.1, N'Naomi', N'Sullivan', N'Test', N'5', N'O', N'Bovino, Gisela .NMN', 3.93)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171678.6, N'Daisy', N'Torres Lopez', N'Test', N'4', N'R', N'Figueroa, Ignacio', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172443.6, N'Susana', N'Torres Lopez', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174047.7, N'Feliz', N'Torres Lopez', N'Test', N'PK', N'R', N'Davis, Leslie (AM)', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174178.8, N'Angel', N'Torres-Rivas', N'Test', N'PK', N'R', N'Garcia, Jennifer (PM)', 2.51)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173910.7, N'Maxwell', N'Turman', N'Test', N'PK', N'r', N'Garcia, Jennifer (AM)', 7.92)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172903.6, N'Yailin', N'Urquiza Lopez', N'Test', N'2', N'r', N'Kotnour, Kathy', 3.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172757.3, N'Kenneth', N'Uvina Chavarria', N'Test', N'1', N'R', N'Smith, Natalia', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174088.1, N'Jacob', N'Valladares', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 10.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174088.5, N'Alana', N'Valladares', N'Test', N'3', N'R', N'Gonzalez figueroa, Lourdes .NM', 10.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174038.7, N'Bayron', N'Valle Caldera', N'Test', N'PK', N'O', N'Davis, Leslie (AM)', 3.85)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171720.6, N'Alexa', N'Valles Ramirez', N'Test', N'4', N'R', N'Meyers, Julie', 2.83)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167102.2, N'Luis', N'Valtierra Guerrero', N'Test', N'KG', N'R', N'Mares morales, Maria', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172557.3, N'Lucero', N'Valtierra Guerrero', N'Test', N'2', N'R', N'Pesquera, Sonia .NMN', 4.03)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173964.2, N'Mia', N'Vazquez Lopez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 4.07)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172709.5, N'Joshua Antonio', N'Velayo', N'Test', N'1', N'R', N'Diaz, Dulce', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173323.3, N'Kai', N'Vogt', N'Test', N'KG', N'O', N'', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173917.3, N'Leander', N'Wallace', N'Test', N'PK', N'R', N'Davis, Leslie (AM)', 2.98)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166978.4, N'Wesley', N'Walsh', N'Test', N'1', N'R', N'Urroz, Hector', 1.39)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173925.5, N'Taylor', N'Walsh', N'Test', N'KG', N'R', N'Mares morales, Maria', 2.37)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173533.9, N'Jadyn', N'Warshaw', N'Test', N'1', N'R', N'Diaz, Dulce', 0.94)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171877.6, N'Jack', N'Wendell', N'Test', N'3', N'R', N'Tobin, Melissa', 2.92)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173256.6, N'Somi', N'Whitaker', N'Test', N'2', N'O', N'Kotnour, Kathy', 15)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173036, N'Jackson', N'White', N'Test', N'2', N'R', N'Martinez, Enriqueta', 1.33)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173178.6, N'Isis', N'White-Henderson', N'Test', N'2', N'R', N'Martinez, Enriqueta', 4.41)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173487.3, N'Sofia', N'Wiland', N'Test', N'1', N'O', N'Smith, Natalia', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (166956.4, N'Batia', N'Wilson', N'Test', N'3', N'R', N'Tobin, Melissa', 3.95)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172798.9, N'Aden', N'Windholz', N'Test', N'3', N'R', N'Johnson, Alexandra D', 2.11)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172480.9, N'Lucie', N'Wlad Mengering', N'Test', N'4', N'R', N'Figueroa, Ignacio', 5.76)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173743.9, N'Josiah', N'Wood-Avendano', N'Test', N'KG', N'O', N'Mares morales, Maria', -1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172791.5, N'Neva', N'Woodson', N'Test', N'3', N'R', N'Tobin, Melissa', 2.95)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171566, N'Selma-Jane', N'Yavuz', N'Test', N'5', N'R', N'Bovino, Gisela .NMN', 0.52)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173374.8, N'Collins', N'Zado', N'Test', N'KG', N'O', N'Mares morales, Maria', 3.36)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173359.5, N'Francisca', N'Zambrano Ramos', N'Test', N'KG', N'R', N'Potter, Emily', 1.24)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167027.3, N'Emily', N'Zamudio-Ordaz', N'Test', N'PK', N'R', N'Garcia, Jennifer (AM)', 1.41)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173098.4, N'Reyna', N'Zavala Longoria', N'Test', N'2', N'R', N'Nelson, Sara .NMN', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173973.5, N'Camila', N'Zavala Longoria', N'Test', N'KG', N'R', N'Magee, Jenny', 3.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173916.6, N'Ximena', N'Zavala Velazquez', N'Test', N'KG', N'R', N'Arrieta, Cindy', 3.09)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172626.5, N'Sawyer', N'Zeldner', N'Test', N'3', N'R', N'Johnson, Alexandra D', 1.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173993.3, N'Samuel', N'Zeldner', N'Test', N'KG', N'R', N'Potter, Emily', 1.88)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173740.3, N'Katherine', N'Ordaz_Zavala', N'Test', N'KG', N'R', N'', 4.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174196.5, N'Greily', N'Abrego-Portillo', N'Test', N'PK', N'R', N'', 3.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174244.4, N'Agusta', N'Carney', N'Test', N'Pre-K', N'R', N'', 8)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174244.4, N'Augusta', N'Carney', N'Test', N'PK', N'R', N'Leslie', 8.6)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174157.2, N'Eve', N'Coyne', N'Test', N'KG', N'R', N'', 4)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167060.2, N'Giovanii', N'Dominguez Garcia', N'Test', N'Pre-K', N'R', N'', 4.1)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (172225.2, N'Coco', N'Howser', N'Test', N'4', N'R', N'', 3.7)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (167200.2, N'Eduardo', N'Iglesias-Ruiz', N'Test', N'PK', N'R', N'', 4.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174223.6, N'Mauricio', N'Koo', N'Test', N'KG', N'R', N'Reyna', 1.3)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174172.6, N'Abigail', N'Lavastida-Rascon', N'Test', N'PK', N'R', N'', 15)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174176.8, N'Duniya', N'M''bagoyi', N'Test', N'KG', N'R', N'', 17)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (171250.8, N'Angel', N'Ortiz-Ramirez', N'Test', N'5', N'R', N'Kowalchuk, Sarah', 3.8)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (173523.4, N'Luis', N'Portillo_Chavez', N'Test', N'KG', N'R', N'', 4.2)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174126.8, N'Marianne', N'Russo Ruiz', N'Test', N'KG', N'R', N'Cavanaugh (AM)', 1.94)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174126.8, N'Marianne', N'Russo Ruiz', N'Test', N'KG', N'R', N'Jenny Magee', 3.9)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174211.4, N'Kingston', N'Ryan', N'Test', N'PK', N'R', N'', 18)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174230.1, N'Jillian', N'Tabak', N'Test', N'3', N'R', N'', 2.5)
GO
INSERT [dbo].[RegistrationImport] ([StudentID_T], [First], [Last], [School], [Grade], [Registered], [student#homeroomTeacher], [distsch___]) VALUES (174241.5, N'Robert', N'Wiegand', N'Test', N'PK', N'R', N'Jennifer', 1.3)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'51d82f41-e4d9-4330-846e-21659733e300', 165513, N'Elmer', N'Alaniz-Muro', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4f33c956-980a-4bef-b838-43a5b0246d22', 165921, N'Cristian', N'Luna-Zapatero', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'35060d34-04a8-462f-a755-e9487c72d7c5', 166037, N'Maria Hannah', N'Ordaz Lopez', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'64e1b898-5020-43ef-b400-1371a4051017', 166071, N'Paola', N'Arellano', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c3580a6f-34c5-4544-975c-f5febba452fa', 166249, N'Alexander', N'Bustos', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd93ee009-5f43-40ba-9c09-58e6790905c3', 166314, N'Diego', N'Garcia-Zapatero', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bdc0c188-16f9-43e5-b0cc-784dada68ee4', 166433, N'Sebastian', N'Griebel', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9187e1ae-ba0f-4958-a19e-09c88fb0532c', 166451, N'Victoria', N'Hernandez', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a0e529b7-672b-4630-8a98-309bf0b866a2', 166551, N'Javier', N'Cortez-Vargas', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'138464a5-5419-4ddd-ac82-d51fbc57e8aa', 166552, N'Genaro', N'Cercas-Munoz', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8613942f-51a6-44ea-9522-71aae71a35cf', 166719, N'Edith', N'Lopez Zepeda', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e93fc598-6ea9-4161-a8b7-820a2b8c5ec4', 166725, N'Ivan', N'Montes-Zavala', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bcdf0f74-e059-432f-a6fa-e206b29d1a4f', 166751, N'Anthony', N'Arredondo-Fraire', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3b1ae23f-c8aa-4f34-a519-2202365ec866', 166759, N'Valeria', N'Martinez Alvarado', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f6b0bf02-bd63-4c55-881f-9b37cd9e67ed', 166886, N'Shea', N'Stillman', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e6d0370f-ee21-429d-bec9-1d6abafb02b3', 166887, N'Tessa', N'Fox', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e4ec8aa0-51d2-4b4e-9241-f04fa7a0bc97', 166893, N'Jaden', N'Henkel', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9ecc1dc5-b8f0-48b6-994d-ca564bcc20bd', 166940, N'Eduardo', N'Lopez Zepeda', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c9841845-9bd6-4fe2-93c9-b2b37f9abbb5', 166945, N'Christopher', N'Lopez-Avalos', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'cff0d05c-1c0f-4655-a779-42df2cca85cc', 166948, N'Angel', N'Aguilar Murillo', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fc7a7505-b525-4022-9ba8-93e66138253e', 166949, N'Guadalupe', N'De La Cruz Arellano', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'987af15a-9c20-4c17-a173-6d44526b8963', 166950, N'Sebastian', N'Ramirez Medina', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9e6c2218-8e4f-44c6-9aab-dd9f7cb3742c', 166951, N'River', N'Breed-Carithers', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1ab5de72-6a61-4f05-a88c-07c4383359b4', 166952, N'Noah', N'Bookman Urroz', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'599e99f9-50dd-49d5-85e3-f00509a9b892', 166956, N'Batia', N'Wilson', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6f2412f7-c840-4700-ac37-10808f4be2dd', 166959, N'Lizbet', N'Ramirez Escalante', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7fa652aa-61bf-42c9-970a-8febe72e9e1c', 166965, N'Michael', N'Quijada Escobar', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'04a15cfc-ae72-43de-92e4-e8234fdded2c', 166969, N'Dylan', N'Haney', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6a03cc90-a4eb-40c7-b12b-d227235bdd1d', 166970, N'Allan', N'Rodriguez Gomez', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9375e124-cd22-48c6-b952-5f214b2444e9', 166972, N'Jayden', N'Sanchez Garcia', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8a1c06c8-b378-4cfd-95a3-71dbc5c3e7c5', 166978, N'Wesley', N'Walsh', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'24600735-7d5c-4057-aa8b-7a1e686fd9e4', 166983, N'Andres', N'Herrera-Murillo', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7054f435-732f-470b-8cf7-56152cdaa354', 166995, N'Jonathan', N'Jaimes Mena', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'492d60a8-26e0-4a4a-9979-d8b2760b8809', 167003, N'Concepcion', N'Chigo Cagal', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'46d0bfe9-0d67-4477-b54a-b4c6ace8ad02', 167008, N'Beau', N'Pryor', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'28e82e2a-2cab-4cea-9961-5cb6893487f2', 167010, N'Marely', N'Garcia Estrada', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'41e20f4f-f632-4344-b2f6-6a7bd681acf7', 167011, N'Fatima', N'Rodriguez', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'648937c2-46d7-4261-8909-6c7c40a44127', 167013, N'Joseline', N'Gordillo Perez', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a0270b1e-fbb4-46c8-a2fb-a4163aa7233a', 167016, N'Edgar', N'Chagala Macedonio', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f0810e0a-8546-4255-8a9d-faa6b32b19a0', 167018, N'Raul', N'Morales', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'748c40dd-60a9-4f73-9d65-46efa931fbcf', 167023, N'Angel', N'Romero Herrera', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b5a7a147-80e8-4f44-b5f2-29d900b82c63', 167024, N'Alisson', N'Silva Ordaz', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9b621eac-5130-4ee6-bbc4-27f854eb8fef', 167027, N'Emily', N'Zamudio-Ordaz', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ddecc6f4-d88b-4370-9748-63a441f4cb61', 167032, N'Simon', N'Puente Vasquez', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'16d440b1-2226-44c6-af82-dc9edf7a8587', 167045, N'Ivan', N'Aguijosa-Castillo', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'716b0124-3e31-4a02-8ce9-27a2488a34b6', 167052, N'Edwin', N'Rincon Zavala', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fbd62ace-efc3-44b6-9aa2-daa17713f2af', 167053, N'Mason', N'Fischer', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'004c9a77-fe6b-4c82-8fab-cb3bca9aa802', 167059, N'Leidy', N'Abrego-Portillo', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8fe0af07-8d66-4249-9d4f-ac6550aa9737', 167060, N'Giovanii', N'Dominguez Garcia', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'402556bc-1646-404e-be45-92bdea749a35', 167067, N'Ivon', N'Morquecho Zavala', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a18b0bc0-1d34-41ba-a169-c18feb05495b', 167068, N'Bryan', N'Chairez Martinez', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd06a2868-a6eb-44c5-a3ab-0d6de5ec103b', 167069, N'Diego', N'Almeda Solis', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9ad52c25-904b-4e52-b473-db56fd4c1c7c', 167071, N'Lisette', N'Sanchez Escalante', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'02abc30e-b929-4ec3-8959-b0b60ec64af2', 167072, N'Coulter', N'Dayton', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c0e1b115-068b-46c3-8970-5b7833c42f09', 167073, N'Oliver', N'Hernandez Cornelio', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd3a7be6c-b752-443c-b640-65807f698533', 167074, N'Maria', N'Perez-Ledezma', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fb4e8bb6-5f06-41c4-955c-70fa1fb277b1', 167084, N'Aidan', N'Cardona Ramirez', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9af2db87-b84e-4280-a26a-1c0daa150e07', 167086, N'James', N'Embry', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'25ad0b1b-ab22-46f3-898e-5e43db57cbc1', 167095, N'Jorge', N'Perales Salazar', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'01834967-c7fd-45ad-a815-d1ec48824e82', 167102, N'Luis', N'Valtierra Guerrero', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd116d58e-0df4-42b2-9172-52d8cf1dee2a', 167108, N'Victoria', N'Alaniz Cardona', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'51d160ba-15d2-4fa9-bf17-4ea7f784edf4', 167127, N'Eksar', N'Ruiz', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'048af666-6149-40d7-b848-ce9d0a3512c4', 167130, N'Dylan', N'Delgado-Salas', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b6c6375b-064b-4c55-8092-85b86c4e44e4', 167145, N'Valeria', N'Ordaz-Garcia', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'293f8af9-73e1-4494-865a-3b13ebfe9eb8', 167146, N'Leonardo', N'Sanchez Arreola', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'77d4e750-98ab-4cb6-9e89-95720be021cc', 167171, N'Martin', N'Fernandez Jaquez', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a25fd295-fb01-47b1-bf71-088ede45994e', 167173, N'Jayson', N'Fernandez Zavala', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5899bfe3-5665-473c-9515-ceb94b555639', 167175, N'Alexis', N'Martinez Martinez', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'df120f03-f982-49ef-9a76-012121db93d1', 167196, N'Gabriel', N'Reynolds Marti', N'Davis, Leslie (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'becd32df-9c4a-410e-a7a1-095b78c24781', 167197, N'Tristan', N'Bonta', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f49a6ed1-35f3-419f-9384-9f3b36e3b65a', 167200, N'Eduardo', N'Iglesias-Ruiz', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'46868805-899c-4a08-8dc7-c2cb37a15159', 171076, N'Bryan', N'Colis', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'38b83d39-eea9-46d4-9908-425ce1c3f7e6', 171083, N'Alexa', N'Ramirez Escalante', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c0a686ba-24fd-4f7a-8f46-2aa09ed9ee0d', 171118, N'Maria', N'Chigo Cagal', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1bad28b6-d276-454e-80bf-33cdbce1dc04', 171197, N'Alan', N'Ricardo-Martinez', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2da5dbe3-d823-436c-b83d-b03c72e621ff', 171251, N'Juanita', N'Ortiz-Ramirez', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a0afedcc-0c71-432b-8db8-6c64f441230d', 171262, N'Leslie', N'Hernandez', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7446b5fa-969c-4710-871b-a086c956ae9b', 171264, N'Daniel', N'Balderas-Lujan', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bc1512dc-34cf-4a9d-ba7f-be82907f538c', 171272, N'Jason', N'Arias Hernandez', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'32c4467a-5d8e-4340-97c0-c87397bbe53f', 171291, N'Omar', N'Morquecho Zavala', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b6531793-beb0-47c1-a8b5-6858863e8e37', 171292, N'Kevin', N'Ordaz Garcia', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f38fd4aa-c460-419c-bcf2-b9a2145956b3', 171293, N'Emily', N'Gordillo Perez', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'565c4835-7c41-480d-9bd4-a4272f5a367b', 171316, N'Yasmeen', N'Silva', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'38947e43-9832-42da-bd97-d577dfe78192', 171337, N'Emma', N'Rincon-Zavala', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c6a1b523-6edd-417f-8f7c-42f5acefbf44', 171399, N'Haley', N'Bonewitz', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'274c313a-53d6-4895-b421-92087738a91a', 171448, N'Rhys', N'Haney', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1fe3362a-721a-4a68-ba6a-141d8609ee7f', 171461, N'Salomon', N'Rodriguez Gomez', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'970fa846-93ca-411d-bf9b-d7a476cd25f7', 171544, N'McKenzie', N'Jones', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f967cc1a-ee31-4bf3-8cad-8f62656eb6db', 171546, N'Carson', N'Bolgatz', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'68a76637-4e9d-49cc-968e-c7684ebb132e', 171555, N'Samuel', N'Colis Delgado', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5d8c94c0-5b18-4e00-a5cd-2e249ba782c3', 171562, N'Luis', N'Murillo Ramirez', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8be60813-e347-4f5b-afa1-03c34ab7670a', 171566, N'Selma-Jane', N'Yavuz', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'0d8385dc-14cd-4bc5-840b-b3a7466d1599', 171583, N'Eric', N'Hernandez-Garcia', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ea82f094-fdeb-43be-9392-4d89d219d56e', 171666, N'Jonathan', N'Ibarra', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3a7b1fe0-ad21-468b-b6ed-d432706ebdd5', 171672, N'Christian', N'Aguilar', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'da0e6cf1-af87-43f0-ae5d-b19c3c5f2475', 171673, N'Mikayah', N'Levy Wright', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b56e89bf-9cd4-4f3c-8910-b8ce941d3b89', 171674, N'Jose', N'Hernandez', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f9fb6a0d-7050-4a1f-9783-bb6a35a6f339', 171679, N'Daisy', N'Torres Lopez', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'84c061df-0528-403d-8eed-d1eceb616145', 171690, N'Kevin', N'Kembel', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'32858e5f-3c6d-4853-bcf4-f590441a4b92', 171695, N'Julissa', N'Gutierrez Navarro', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd6d806a9-bdc0-4135-abc2-986626675426', 171699, N'Isabela', N'Perez', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a83a5478-20ed-4795-95ac-2e9ea1b3bddf', 171704, N'Reina', N'Rodriguez-Arellano', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6d3b283b-c697-40cb-bd45-293731bf04e2', 171720, N'Marisol', N'Longoria-Rodriguez', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5622de77-8130-4695-bc25-2fd1593c559a', 171721, N'Alexa', N'Valles Ramirez', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'223f83d6-5e2e-4d00-9f40-d33f1d9d8a5f', 171724, N'Michelle', N'Acosta Martinez', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'11b2650c-a188-4a7c-87f7-c1723b43e8d2', 171725, N'Steven', N'Lippold Sustache', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'770cd45b-9a18-45ce-a46d-20689202a271', 171727, N'Flavio', N'Ramirez-Alaniz', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b32dcd03-c31c-4873-851f-452e1d9ef8c8', 171744, N'Javier', N'Aguilar Ramirez', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'abaa099e-fe29-4646-b6d9-f2beec3270e3', 171752, N'Ruby', N'Garcia-Martinez', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e9fc4b91-1eac-4131-aedf-09ebd77bf77a', 171760, N'Vanessa', N'Lopez-Zepeda', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'0e57feae-8f20-448d-a244-d78875d3f2fe', 171793, N'Gustavo', N'Aguijosa Castillo', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5713a89c-7c88-4dd4-9084-2170a0888818', 171840, N'Adolfo', N'Castro-Cital', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd03401d2-ed87-4c67-9c5e-1c2f70dc818c', 171844, N'Felix', N'Slade', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fc1dd894-0610-44ed-8400-ad238794238b', 171860, N'Noah', N'Stoddard', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'25964280-ab77-4a24-8603-d87746637847', 171874, N'Sylvie', N'Paradiso', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b740258d-8dc7-4fd6-b210-39719e6917ad', 171875, N'Taytem', N'Kowalchuk', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'aedfd5d3-d813-4873-abf6-3d30c8ae2113', 171878, N'Jack', N'Wendell', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'520b52fc-484a-40c4-8d1f-734818f841fd', 171882, N'Naomi', N'Sullivan', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'cb65f6e7-d7ad-47ca-ae1b-0178c96266d9', 171894, N'Isabel', N'Kembel', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'41b47d0b-a795-45bf-8cdc-7427451c4fa6', 171900, N'Michael', N'Molina-Cardenas', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a5e5ef3f-0ea2-4cd1-8e79-fd201d0fa1ac', 171902, N'Samuel', N'Cook', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'24c4b0d6-4bee-4da8-9d58-f3db4c935303', 171910, N'Diana', N'Ponce', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f794d250-acc2-4119-b970-0e93888300f9', 171918, N'Maria', N'Arias-Aguilar', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'16334043-4b7b-4854-b011-5891bdcb5b1e', 171923, N'Jaya', N'Kohm', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'719c802f-43f7-4b73-8aa8-6cc0f71e4b3e', 171928, N'Mekdes', N'Bass', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ea40e6f6-1af2-4610-bbb1-bb8489d6b280', 171951, N'Jade', N'Haag-Toney', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8c7fa15c-0aa7-466f-84ee-f6694252ff7b', 171956, N'Diego', N'Goodwin', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'71918bdc-4bcd-489a-bf4f-f108579b47d5', 171972, N'Jackson', N'Kirshner', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd1ba3d3e-8e14-4ca6-8450-e270a5b6e635', 171974, N'Oren Atticus Binx', N'Dutton', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'0397a1de-e7d4-4e6f-9125-beec1de93bdc', 171975, N'Denise', N'Longoria Portillo', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5530ce55-68a4-406b-b8c9-128f7cf5cf80', 171980, N'Van', N'Nelson', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a56899fa-8595-4d8b-9087-e275c96b179f', 171981, N'Della', N'Baker-Rosenthal', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9a08818e-e1e4-45d9-8531-7ccfab867c30', 171982, N'Paloma', N'Espinosa', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b24c480a-5301-419f-842c-b163771e0591', 171983, N'Azul', N'Espinosa', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3f49a489-d61b-4e83-842a-add4d6e377dd', 171991, N'Jorge', N'Ibarra', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ca39d3c2-50b7-46f4-8397-6e4a5af3364e', 171995, N'Genesis', N'Acosta Martinez', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5b2b8dea-176c-43a3-b24b-d9402e56630c', 171998, N'Jaqueline', N'Martinez Martinez', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2ab5ee5f-2a8e-4cb5-b82b-4c6fae6e55dd', 171999, N'Chayton', N'Sampson', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6740e9e6-e7b1-4a39-a084-2c671a77f2ff', 172000, N'Alma', N'Murillo', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'dd5fe69a-335f-43b4-bac7-e8a2daf3f7f7', 172005, N'Miguel', N'Montes-Ramirez', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'24515629-fb24-4a9b-9c68-820885928483', 172031, N'Anna', N'Boromisza-Habashi', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'eab36c10-be54-4288-86bf-339253466389', 172069, N'Gabriel', N'Rothschild-Balzan', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ebbe771a-ca4d-4c74-a089-28e1331e5e8d', 172106, N'Christian', N'Esparza Arellano', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c3730f26-45e3-477b-887c-9d730d5fb920', 172108, N'Bryan', N'Rodriguez Portillo', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c3e80f53-843a-42c0-9204-ecf9a9ce7e12', 172114, N'Hannah', N'Cohen', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'82b3ed16-7335-4143-8e84-4b28d3f9d20b', 172115, N'Giorgio', N'Loffredo', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c18e4853-e3ab-4406-81f2-31f8e5fbb644', 172117, N'Ashley', N'Perales', N'Myers, Laura', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'70a242c8-fc11-4a05-adc6-7bf5f4ee32af', 172118, N'Andrea', N'Herrera Rincon', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4a9ebf2e-0636-46f2-96e0-df7be4f5d7ea', 172122, N'Jorge', N'Ramirez Ramirez', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b9989683-677f-4b71-9743-ed30bdcd9f56', 172129, N'Lizette', N'Elizalde Zamora', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b2bf497f-11c4-4b62-952b-85d9d6011a13', 172131, N'Lesly', N'Lopez Ramirez', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'135893dd-b318-4a8d-bcb7-6e8983cca8c1', 172146, N'Santiago', N'Fuentes Leiva', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'86ae4df4-c31f-4e83-a1f0-209ec9b14ad3', 172166, N'Alex', N'Arellano Ordaz', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'58e09c31-b539-412f-96d5-8cbf7928d733', 172179, N'Yasmin', N'Hernandez Altamira', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b60392ec-7910-48de-a39e-ba4d3bd98773', 172185, N'Nelsy', N'Segovia Ibarra', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'dbb4100d-357a-4577-9a2d-a97ecb6d70cb', 172219, N'Rebecca', N'Kless', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'38a0c4e7-a381-4841-9018-f794ac1296b0', 172222, N'Wallace', N'Gilreath', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8cebce8b-d886-40b9-a4f1-f074e047c2fd', 172225, N'Coco', N'Howser', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5ff72663-e382-4247-a616-cb5bf5ef5514', 172240, N'Quinn', N'Kingsbury', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'de7a6f47-234e-4c88-950b-d933578e3e1d', 172260, N'Abilene', N'Adelman', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e96910fa-d99a-4779-8d33-340754732790', 172274, N'Sova', N'Coyle', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9d385d9d-2e22-4c48-8490-2dcae41d7df6', 172275, N'Eugene', N'Ellsworth Bowers', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e51a4877-af32-4448-bc6c-1c99bbe425d6', 172281, N'Ariel', N'Bartell', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'78d3aff2-653e-4aea-bf96-25b9246c0711', 172292, N'Vivian', N'Congedo', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'214735c2-02ec-4fc5-bb7a-e1a924e7f6de', 172297, N'Stella', N'Breed-Carithers', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6a495541-014c-4e0d-ae9a-9aaab24a1953', 172327, N'Sebastian', N'Rothschild Balzan', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd5b6db28-8f7d-49c9-a51d-54fc841e70f6', 172337, N'Sebastian', N'Muir', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd3b18ba5-3383-4e2d-a74f-aaf064b23918', 172343, N'Viquel', N'Ramirez Aguilar', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2bd63256-6064-45bb-84d4-c6da640240b6', 172358, N'Ashley', N'Juarez-Portillo', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5c0f9a08-08ae-46e4-bf40-9cebc12730da', 172362, N'Charles', N'Goetz', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ce82fb28-98a9-4e5e-87fc-85afdad3dca7', 172365, N'Colton', N'Mann', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6b362ad0-016c-48f2-9090-cb0d4f40f979', 172367, N'Adamaris', N'Longoria Portillo', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ab445b37-aa73-43ed-8c17-92a82f3f4fd6', 172369, N'Alvaro', N'Fraire Monrreal', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4efeeb8b-0696-4378-ab8f-585e90b9c5e4', 172375, N'Lola', N'Ferrell', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'509064cf-a943-4e40-8f32-1412bf6a9a84', 172381, N'Summit', N'Louth', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'0c72ff0d-c809-4416-afd4-7834bef476be', 172384, N'Ian', N'Rodriguez Arellano', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e9a123dc-bae1-4bb6-9578-08499b86f9a2', 172393, N'Tristan', N'Barrett', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f21a3c06-0cae-4c49-b998-6e6cf4e751a2', 172400, N'Jeremy', N'Roe', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fb6c8ae5-841a-4af8-a991-304f1727b8c8', 172423, N'Bryan', N'Soledad-Puebla', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3e538d82-aebf-452f-aefe-17fd2efdb85b', 172424, N'Levi', N'Epstein', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ee8328d7-ba2c-4130-83cc-5d08a6ac655e', 172443, N'Selena', N'Guevara', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'86f6ac4e-fed0-4ce6-8a6e-7967e0cee864', 172444, N'Susana', N'Torres Lopez', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'048034f6-8f9b-4c0c-94f5-46466d5df789', 172450, N'Estrella', N'Alpizar', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c3a856d1-36aa-486e-ac2f-e12a0df07fff', 172481, N'Lucie', N'Wlad Mengering', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd38c8c98-c01e-4ea3-9fea-f78b13e9c6ad', 172499, N'Eric', N'Becerra', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bce8332b-f9e7-4f33-8620-84fb11a3d8cb', 172503, N'Skylar', N'Rutkowski', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'21a7a719-b874-4211-9393-a2e89071872b', 172504, N'Raudel', N'Aldaba Torres', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ffab1a61-b215-4317-8a8c-80e930f5d8ca', 172509, N'Sabrina', N'Ortiz', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6f40dc07-21e1-4baf-9134-ff55cb2e821d', 172511, N'Reilly', N'Moreno Fabela', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd60d2020-9288-4110-a163-28f78fb58a7e', 172513, N'Qiunn', N'Bernthal', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f8b6c066-ce43-45c9-a7e1-dfd05da3f795', 172517, N'Sylvana', N'Perez', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'feceb845-1374-4cc0-a68b-7fad7ede820d', 172519, N'Angel', N'Galvan Badillo', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'afe8c00c-c433-4530-9a68-0fccbe018ecb', 172523, N'Roberto', N'Barcenas Guerrero', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd8325810-0a19-45c4-bcf5-968eb780319e', 172535, N'Abigail', N'Ponce Prado', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'321965d6-ff35-4150-9c4f-e297ef74b253', 172536, N'Christopher', N'Arellano Devora', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9620b9bb-e983-49a5-99a6-29003dff06bb', 172540, N'Julyssa', N'Macias Ruiz', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1d9eb7ae-70a3-4c95-950e-f7a8af522361', 172556, N'Cristian', N'Lopez-Organista', N'Kowalchuk, Sarah .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3541d47f-7ddc-45b6-86b9-8ca940b29c4c', 172557, N'Lucero', N'Valtierra Guerrero', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5b81874a-3d8b-46e5-bf2f-696259b39a36', 172627, N'Sawyer', N'Zeldner', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ede80357-278c-4d1b-96d3-0b16af8a4e41', 172651, N'Liam', N'Brod', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ddb069f1-36db-457e-81a7-fd0719e41378', 172655, N'Anna', N'Munro', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'acfb3311-1a90-4af9-aad9-7a250e2043d8', 172671, N'Daelin', N'Krutsinger Swenson', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'0b3a8739-e740-4695-a3fd-48ddec77f13b', 172697, N'Javier', N'Slade', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4021ddd8-7c7b-4ec9-bed0-c26a5891a09d', 172704, N'Bryant', N'Callahan', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'29b132ce-c7b0-469c-957e-5c24f19a48f6', 172706, N'Takoda', N'Sampson', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'300eeb84-fbda-4294-972a-b3151b7a847a', 172707, N'Boone', N'Kowalchuk', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'849a9756-d6b9-4aed-9424-6cb12e1d4490', 172709, N'Giselle', N'Sloan', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2b3328d7-fbc3-4d46-bad0-0bd06b0708c3', 172710, N'Joshua Antonio', N'Velayo', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f31d67d0-2df3-4cca-a3df-96d8eb1b8574', 172720, N'Gael', N'Najera', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd46955cd-2815-44a5-8953-cf6a295adfe3', 172722, N'Pierce', N'Dayton', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'06e8f88a-46b6-4eea-8836-ad168662385a', 172732, N'Andrea', N'Lopez', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'42c73e4a-f570-42c1-b7ad-03484b8cad25', 172744, N'Charles', N'Coyle', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'323134ad-12e6-40a6-b5a0-63de27e98767', 172745, N'Jocelyn', N'Ramirez Ordaz', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'15c49bcf-7d37-4528-8600-d4274672db3a', 172746, N'Jacob', N'Gurrola', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'38feba0b-c26f-411d-ba22-c7ff2902651c', 172757, N'Samantha', N'Uvina Chavarria', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3fcca669-a250-4f06-8481-688f6c8b9eb7', 172762, N'Shelsy', N'Rincon Zavala', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e752bab8-ee18-41a0-a080-04f91a136f9e', 172763, N'Quinlan', N'Eberle-Taylor', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'31084685-0809-4dd0-84a5-8fda5ece04b8', 172776, N'Dulce', N'Arias Hernandez', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd026a7d2-c00a-46fc-9ac4-e9fb8ca88897', 172780, N'John', N'Linsenmeyer', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6cbe0e7d-bcf5-44c9-bf6e-6a5eed0f5b0b', 172786, N'Lucia', N'De La Lama', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'81f93b25-53b6-4513-bab9-4d6cdbb8a4dc', 172791, N'Sebastian', N'Sermeno-Urroz', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'05cc6a97-8f3d-42b7-9204-461197281e4f', 172792, N'Nicholas', N'Woodson', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7c7c3980-53fd-4197-ab57-35822da97870', 172793, N'Jack', N'Rissman', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'af358634-9ef6-403d-8d01-3d6d7dae8125', 172795, N'Lindsey', N'Montes-Ramirez', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'12bf066d-52fa-4906-9395-82b4d55780de', 172797, N'Felice', N'Borden', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c243f23f-cc25-45e3-885f-81d22eb12705', 172798, N'Camila', N'Garcia Aguilar', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'24e9403a-6ab0-41fc-b881-04d3436a1b12', 172799, N'Aden', N'Windholz', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c6b12766-765b-4b49-9c27-fc91349deeb7', 172801, N'Maria Guadalupe', N'Morales', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd0583fca-f0ca-4452-b317-96d27953f99a', 172802, N'Hector', N'Lopez Gutierrez', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1e1df8a3-5d71-42b7-acab-c9b3bd2c4384', 172804, N'Vanesa', N'Alaniz Cardona', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5d4cc151-082e-47a4-a631-132ba2c6a65f', 172806, N'Kimberly', N'Murillo', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'eb9112dc-331e-4060-9235-94a5f99b7a78', 172904, N'Yailin', N'Urquiza Lopez', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'225f5b09-2df4-49b1-8879-43373b5d942b', 172909, N'Julissa', N'Silva', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4c7888f0-0fad-46c6-a832-b4e251451d84', 172942, N'Diego', N'Arellano Martinez', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b96cf659-ba42-4daf-b503-5c63cbdb7cd8', 172943, N'Ximena', N'Murillo', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3030cbdb-55e9-432f-a9d3-a91594ad0371', 172946, N'Luis', N'Canales-Hernandez', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'468003a2-82b4-472c-9188-9f3eb1ce1226', 172975, N'Kadin', N'Doles', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6993edfc-11c3-4906-88bc-55a7f9dededb', 172996, N'Jorge', N'Garcia', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3df297f4-03a9-4462-b4cc-5fa6b8c6195a', 172999, N'Ximena', N'Sanchez Devora', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a20f0f2a-fabb-4a61-b92c-cd5929b5fff6', 173022, N'Caio', N'Cullison-Assuncao', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'42169f46-f95e-4651-aa4a-2353a2411c4d', 173032, N'Isabella', N'Goodwin', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'708ebb39-bea1-42f6-9a5c-2fb4568805cb', 173036, N'Jackson', N'White', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'75f2627a-27fe-4765-b4ba-3676ab596ec8', 173038, N'Angel', N'Arredondo Monreal', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'dd67fb2b-0274-49d7-a74d-8d0c1ed12f1c', 173050, N'Sienna', N'Kless', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'cb606e3d-ff9e-4126-9093-a5a9b233aa53', 173057, N'Clarence', N'Gilreath', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ff8472ed-70fd-420c-9a5b-0af7192201ec', 173069, N'Mateo', N'Arden', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'23d78407-2ce8-4ea7-a1ae-a1506396bc60', 173092, N'Miriam', N'Romero Robles', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ce6c055c-8d9d-4826-ac93-ef1055dfe87d', 173098, N'Reyna', N'Zavala Longoria', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'093dceff-72cf-4cf7-93df-034ad6e5d564', 173099, N'Emmanuel', N'Rodriguez', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'752906a7-2bf9-4ca6-94ad-dab186c90492', 173100, N'Bintang', N'Stone', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'23ca3360-b11b-4f83-b215-341e32dcee63', 173121, N'Amalia', N'Milstein', N'Johnson, Alexandra D', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'23d632a9-9b26-4a31-b17b-036b870bbe0f', 173122, N'Daniel', N'Gonzalino', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'71dd494b-06c0-4c3a-b09b-2113fa495d4d', 173123, N'Allan', N'Robison', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'83c9cd76-0ae9-4f08-b04c-9d0132b1df03', 173127, N'Lia', N'Stoddard', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c97d71d6-a2a1-4098-bbc4-5772cf84db83', 173130, N'Alvaro', N'Arellano-Torres', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c0d5f664-1d0b-44da-81d8-41f9f063ab2f', 173132, N'Violet', N'Kuhns', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b285bfd2-abcb-4b64-ad03-01317accfa34', 173134, N'Gabriel', N'Mitchell', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6a3ab78d-ea92-48a3-8992-7b9bbbc75563', 173135, N'Charlotte', N'Pryor', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'21b37eaf-5e82-49d6-8412-1e91b70cfe8e', 173138, N'Aileen', N'Borjon Rodriguez', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'11913162-7663-402f-a01a-a92d1d032a44', 173139, N'Sarah', N'Kamundia', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'dbb0491f-2b4b-45e5-a353-1f4ccca1f9f8', 173141, N'Joaquin', N'McKee', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'73a65865-a85f-405e-8161-79e267b98ab5', 173143, N'Maddox', N'Koler Stage', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e73be8a7-e66a-4005-a7c1-a7a90f8180e0', 173145, N'Kian', N'Feurtado-Morgan', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c32ae8df-1de8-4623-87dc-a6fa86f5a025', 173146, N'Ellen', N'Ceres', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'00c81903-bb0d-4a30-90c1-7a62ad03b491', 173151, N'Heidy', N'Garcia Estrada', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'76f5ee31-7b65-4938-ae3b-07bdcd371c26', 173153, N'Cash', N'Callahan', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bf1d0672-38d6-4fd2-b169-b862daff927a', 173165, N'Benjamin', N'Duke', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'93161e55-6752-4da8-ad8c-e15651a01261', 173171, N'Sydney', N'Oremus', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b4fc002c-bf6d-4850-b290-94c83cd4bfc5', 173174, N'Camila', N'Aguilar Barron', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bc2e83ef-4540-4629-8e9c-36ed63030bbe', 173178, N'Fatima', N'Monreal Arellano', N'Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1ffa6c44-07a0-4836-b1e2-025103d9b2e6', 173179, N'Isis', N'White-Henderson', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5e993ca3-b60f-4bc0-b73d-048d7d7d8ef2', 173181, N'Valery', N'Murillo Jaime', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3a2e1637-7d76-42da-88a2-ccf8ce252d34', 173182, N'Allison', N'Macareno Carrillo', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c13568ea-a57d-4279-81e2-d08d604a8dba', 173184, N'Skyler', N'Martin', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'db276cbf-5653-4919-a312-90fc301fe693', 173189, N'Samantha', N'Martinez', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f64044b4-0720-487d-8fcb-3c27b9738842', 173201, N'Sheamus', N'Murphy', N'Tobin, Melissa', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a432e8f3-56e6-40e8-b9d0-c77b7a3f6833', 173212, N'Abigail', N'Borden', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fdc09ce9-09b9-4203-864e-28330e8d66ca', 173213, N'Celina', N'Bretado Ordaz', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'01019c48-9a38-4090-b512-ac9d5b5ebc3a', 173219, N'Tomas', N'Juza', N'Figueroa, Ignacio', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'67fbbc34-cc0a-47ab-9bd7-8ba7687702ca', 173228, N'Toray', N'Davis', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1c77ba6f-4d9d-430c-8a7f-448d5d80e8ab', 173239, N'Niamh', N'Lowrimore', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e915902c-60a3-431d-ab00-da2ab143ac33', 173257, N'Somi', N'Whitaker', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6e1c142b-e9ae-463e-ba55-84f3ea5bb282', 173288, N'Zaya', N'Pohl', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'39d182c4-8c29-437d-9e50-d14c40478fb1', 173292, N'Matteus', N'Juza', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'047da64f-94a2-422c-96b9-8c50fa5017f6', 173295, N'Charlene', N'Cortez Vargas', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a6487062-8452-49d6-8a55-863eaef62919', 173312, N'Jordan', N'Rutkowski', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7d850135-533b-4e9a-ba67-13fba5133db7', 173314, N'Jacobi', N'Olivares', N'Pesquera, Sonia .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'41ea8d68-66b5-48e6-9ae2-a632b6e23c90', 173322, N'Camila', N'Morquecho Castruita', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ff99752a-8774-4135-817d-0f5f713c77fa', 173323, N'Kai', N'Vogt', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c4a5e35e-59f6-4744-9eea-a090642ba327', 173344, N'Luis', N'Ramirez-Segura', N'Martinez, Enriqueta', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6b9562b0-3650-44a9-8be9-fcbe2124b5da', 173347, N'Katie', N'Soria Sanchez', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'eb24e061-d52b-45af-911a-725eb285677d', 173348, N'Brysa', N'Aparicio Hernandez', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6032a3d0-e8b8-4214-9d47-37be0f433865', 173349, N'Karla', N'Reynolds Marti', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6f7ab229-e01f-45bc-a5bd-d496fa04bb70', 173357, N'Yoeli', N'Lopez Ramirez', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9c0a8baa-9412-401c-88c2-5a55a1b0579e', 173359, N'Katheryn', N'Ordaz Garcia', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ed7c95d3-c7e2-43e6-9983-5229a2192e67', 173360, N'Francisca', N'Zambrano Ramos', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b708625e-e120-42b2-8234-2e8091f60a8c', 173375, N'Collins', N'Zado', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'88b3fc1b-4cfb-4a92-b902-4980b1ebe7c7', 173383, N'Erick', N'Lopez Beltran', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'42c7f585-bddd-491a-8c8e-6249a675f959', 173425, N'Andres', N'Guerrero Lopez', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'935fb76c-01ba-4247-b96d-00d9f8e3516b', 173426, N'Lilian', N'Ruskay', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'79f6a825-ba4d-40da-853d-56e78e91cad3', 173485, N'Danni', N'Steig', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'27da4013-4888-4682-b294-1afa9ecd7228', 173487, N'Sofia', N'Wiland', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f3992998-1a4a-4014-8048-beb7a020000b', 173489, N'Seneca', N'Griebel', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ff9a9dd4-ff25-44ce-ae8a-a7023b40cecc', 173497, N'Danicka', N'Kelton', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'948f9a9c-abd8-47b6-800c-a20c172965a4', 173500, N'Evan', N'Embry', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'218e08f2-412e-4d8d-beff-e4222cbd44c0', 173522, N'Victor', N'Guerrero Ordaz', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'90fb1de9-cb3f-4241-90f6-a6a46a7891fd', 173523, N'Luis', N'Portillo_Chavez', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8c875de3-3463-4afa-96fb-8c0d5dd8ad60', 173527, N'Allison', N'Erickson', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8b97b68d-debd-4cf2-a8e0-ca8bc895a91b', 173534, N'Jadyn', N'Warshaw', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f4333b4d-58ae-43b7-acc8-a49490b593ab', 173535, N'Vlaney', N'Sanchez Devora', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6f946ae2-3fe6-4aa1-acc9-fa3e8de5fb30', 173536, N'Zahira', N'Rodriguez Portillo', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e1092146-1bb5-4f04-b6b0-45d3f429daab', 173537, N'William', N'Eberle-Taylor', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'252396ae-4df8-4625-a413-5ba26b3ff550', 173538, N'Charles', N'Raveczky Orlando', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd3b0b980-f6a0-4a0f-9f6f-9b47a0908da4', 173540, N'Mira', N'Rodarte Badillo', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8e9d794c-833c-46e8-8567-d9d20695b50c', 173542, N'Clara', N'Buell', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2f51dc65-f195-422c-a086-a168af3f5461', 173545, N'Skyler', N'Robertson', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9be7a34c-0073-4a05-be62-d4bfdd6e1dff', 173554, N'Kenneth', N'Schorr', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'793199c2-a2b2-440a-8057-88ce92dabb37', 173563, N'Eva', N'Rosales Jimenez', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a3066f35-0c9f-4e45-9ecf-d746efbb7f5e', 173570, N'Nyssa', N'Soto Gonzalez', N'Smith, Natalia', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'956e73ec-486f-420e-a19f-be354587b299', 173571, N'Gabriela', N'Bickford', N'Diaz, Dulce', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bda07c7b-b3d7-4f60-ab40-ffe269b70438', 173596, N'Jazmin', N'Monreal Ordaz', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ea966ecd-ff2f-4a7a-85fb-f257a1467f82', 173613, N'Leonardo', N'Becerra-Zavala', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bde3c311-8258-48cf-9e29-5f830eb87c34', 173620, N'Abigail', N'Buell', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ec6dcb29-196d-4c78-83e4-b15afd46b711', 173621, N'Juniper', N'Schmid', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd80d132d-4f0a-40fe-a5e0-e62762171032', 173626, N'Amaya', N'Sepulveda Visbeck', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3d0a549a-6fe7-4054-8d10-1896d716d002', 173641, N'Annika', N'King', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f16dca17-a1e5-4541-9c63-2db0eaa3379f', 173644, N'Kieran', N'Lowrimore', N'Gilreath, Mary', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b19fe472-ca5c-4086-90f6-b52426efd45f', 173653, N'Jennyfer', N'Salvador Flores', N'Urroz, Hector', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7e8039c3-2392-4ac2-80a8-90021081a806', 173666, N'Savannah', N'Kieffer', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9847aa9d-9895-4d2f-a9c8-a80acbca0ce1', 173671, N'Taj', N'Mandy', N'Meyers, Julie', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1a43de4c-4153-43ec-82c4-2c004a9a29f0', 173695, N'Tyler', N'McCoy', N'Nelson, Sara .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'19b13e36-93dd-41c2-84be-6625d7a25b56', 173698, N'Hayden', N'Loredo', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'235600ab-cdbb-48b3-9489-ce79210b9b60', 173737, N'Kassandra', N'Devora Gonzalez', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c7c8e741-3521-47bd-8725-a64d299259bf', 173740, N'Katherine', N'Ordaz_Zavala', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'980d5d8a-4621-450b-9f70-d940cdb4f8ea', 173742, N'Siri', N'King', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'15dd4c9e-9da6-493a-9c8f-e0e1ae5ce0c2', 173744, N'Josiah', N'Wood-Avendano', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'cd4c02fd-7a49-44bc-8607-0dedd6221f1d', 173768, N'Santiago', N'Alegria Lastiri', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8ae8d68f-84bd-42f6-9b4f-2c0eabcf192c', 173782, N'Leonardo', N'Schlipf', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2f1f888b-ad82-4536-a9d2-8bda709534ca', 173788, N'Jessica', N'Guerrero Devora', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'145e0682-6822-49b7-83f8-721ca720bf8e', 173789, N'Manuel', N'Anica Perez', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a71c9a78-0587-4494-bb36-724ca0665bea', 173796, N'Ariana', N'Segovia Ibarra', N'Davis, Leslie (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7fca0f2a-48ae-4476-b3a8-c98cb3979ed9', 173806, N'August', N'Hildreth', N'Kotnour, Kathy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'6aafd72d-0083-4c94-8e1f-4e809500ae46', 173814, N'Adrian', N'Bonta', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4bff159c-3685-4b1c-bc90-e058b58dc330', 173820, N'Roberto', N'Devora Padilla', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'dd1bce32-f0a7-4dc3-9248-136b63dd2b49', 173867, N'Lydia', N'Simkin', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'511cfa7f-b27b-42b0-a7ee-bff02fd12ecb', 173873, N'Silas', N'Groves', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'edc7505b-0811-4748-a158-aa2690376578', 173882, N'David', N'Lawson', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'858261a9-5857-44d4-8303-d35afa9068c4', 173890, N'Lucas', N'Jaramillo Ortman', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e1681470-3af4-4cf0-b33e-525461d64f37', 173891, N'Anthony', N'Hernandez', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'061f6001-f579-4d68-b8b7-70cbe7c6b8ea', 173899, N'Lorelai', N'Sloan', N'Davis, Leslie (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b5a74593-7c02-418c-b0e5-b119c0bd5a10', 173909, N'Aidan', N'Hite', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'359219d0-daf0-4f14-a617-45dd9fe103ef', 173910, N'Luna', N'Sheppard', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'f6beb839-e63a-447b-b456-1a53e488f716', 173911, N'Maxwell', N'Turman', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'775ef13e-c49a-48d8-a008-30ed36bb7a26', 173912, N'Karina', N'Ortiz', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'519178e6-512e-4c4d-b71e-b5effa20f91b', 173916, N'Walter', N'Sheppard', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'9d22ed34-0bbb-41fa-8bea-d4d305f39eb2', 173917, N'Ximena', N'Zavala Velazquez', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'50897cfe-138f-4f98-86e8-6d96f1f1ee3a', 173926, N'Taylor', N'Walsh', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e7d3c772-1c29-4cac-9d94-d1720c4604ad', 173946, N'Milo', N'Mowen', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3e10d25a-0216-4d2e-9abf-b6a91bd65b17', 173950, N'Isaac', N'Roetto', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'da84448f-3f52-4342-a5e0-77593c117532', 173951, N'Noa', N'Saber', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'cbc9d3cd-168f-4870-af95-44fdc1a51275', 173953, N'Maria', N'Bretado Ordaz', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'd2075d24-207d-40c5-afe4-4ec19cb8a251', 173954, N'Albert', N'Rojas', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1a6cbf34-39a6-4bdd-ab43-9cacf4813b12', 173962, N'Andrea', N'Quijada', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'555b26f9-828b-4376-9db5-65c97b2b5f6d', 173964, N'Mia', N'Vazquez Lopez', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'13fd3c6f-ca57-4d08-8f30-c03c5599a9f3', 173971, N'Raquel', N'Mortimer', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'326bf97a-18c1-498e-9efb-db3e1a8db0f7', 173974, N'Camila', N'Zavala Longoria', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2ce75a34-f0b4-4220-81d4-cd04f0a6fc58', 173975, N'Henry', N'Poe', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'500677cf-cc73-40ac-90d5-39054b151885', 173976, N'Sofia', N'Becerra-Zavala', N'Davis, Leslie (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'bdc4ca4f-2f11-412f-b21e-80bcac7aff6c', 173983, N'Allyson', N'Garcia Sanchez', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1999ee8d-c242-405c-a1de-e70cbef7b0db', 173987, N'Yamileth', N'Garcia Nunez', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b90f8b85-3c77-4adf-97c6-ddb33d823bbf', 173993, N'Samuel', N'Zeldner', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'08d837cd-683e-48f5-9fbf-6e9a98c4d73d', 174000, N'Arya', N'Featherstone', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'c1fcca46-b8e0-408d-be76-6ed3ea2acf48', 174003, N'Mercedes', N'Carr', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'343dc9b1-c883-488e-907e-cd336a87745d', 174010, N'Bailey', N'Hayes', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'2b9a854b-6f95-4461-82da-841eaa1e79cc', 174012, N'Jovanni', N'Lopez Gutierrez', N'Mares morales, Maria', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fd72bf33-8ea4-48e9-b27b-fe8818c32006', 174017, N'Noah', N'Rubin', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'b57f619d-b2af-45bd-a6d2-69fddfc54db7', 174038, N'Ezequiel', N'De La Hoya Garcia', N'Garcia, Jennifer (AM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'01bd8947-6def-48c7-87be-72a7c790f826', 174039, N'Neo', N'Valle Caldera', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'4279b68d-d18a-453d-ae85-1a66c77da0f3', 174048, N'Tobias', N'Torres Lopez', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'518520c9-3c78-4d30-a4cb-7d6f1ae1497b', 174055, N'Lars', N'Olsen', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'331bb661-b19a-49d4-be57-40f0fb210542', 174065, N'Dahlia', N'Oviatt', N'Potter, Emily', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'052e7c6b-7a03-43f3-bb75-c13c8cab9c58', 174074, N'Cartier', N'Meyer-Lesiuk', N'Magee, Jenny', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'3740470e-49b8-4621-9615-4d993be01c6d', 174088, N'Jacob', N'Valladares', N'Bovino, Gisela .NMN', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ed99012c-799b-4e9e-bb6f-d7d23cb91dae', 174089, N'Alana', N'Valladares', N'Gonzalez figueroa, Lourdes .NM', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'7baf2902-1c5d-4785-9401-46f7539fe77d', 174121, N'Raquel', N'Solis', N'Jette, Elizabeth', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1a269961-b715-41db-a993-a711c2676972', 174127, N'Marianne', N'Russo Ruiz', N'Jenny Magee', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'a62b9e14-33b0-4086-a10e-4f9cb3c3755b', 174155, N'Elias', N'Christol', N'Arrieta, Cindy', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1e92d342-300b-4c92-8431-06c5cb92d491', 174157, N'Eve', N'Coyne', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1d51bfaf-6df1-4984-b00a-ca5190df0084', 174166, N'Gabriella', N'Mbagoyi', N'Lizette', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'89fced4c-5dba-4b89-9f3c-2ad7152a957a', 174172, N'Gabriela', N'Lavasida Rascon', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'fac36caf-5e5b-4794-96bb-f7f580660bc1', 174173, N'Gabriela', N'Lavastida-Rascon', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'5d1b18e0-32d4-457f-9e43-88df570fd8c4', 174177, N'Duniya', N'M''bagoyi', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'e06e4b11-8a77-4911-b9c0-0dd96b8c7b09', 174179, N'Angel', N'Torres-Rivas', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'1ebbfadc-d14a-463c-8167-0721a4c53b2b', 174189, N'Brisa', N'Benetiz Torres', N'Garcia, Jennifer (PM)', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'42a3edde-0d89-4f1e-bc5c-5dee06f69c40', 174197, N'Greily', N'Abrego-Portillo', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'aa932b0a-8f81-4cdb-b253-cdf10cafe023', 174211, N'Kingston', N'Ryan', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'8f248aa2-4f6d-4954-bcf1-0f9942e84ba1', 174224, N'Mauricio', N'Koo', N'Reyna', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ab870b13-c224-413c-9c30-82c049c51b76', 174230, N'Jillian', N'Tabak', N'', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'ee32b9c8-e7ce-4d66-bfcc-2d8c9e5f1ec6', 174242, N'Robert', N'Wiegand', N'Jennifer', NULL, NULL)
GO
INSERT [dbo].[Students] ([Rp], [ID], [FirstName], [LastName], [Teacher], [School], [Distance]) VALUES (N'521d4fab-c91d-46c0-a1e5-8e5b2271a0b0', 174244, N'Augusta', N'Carney', N'Leslie', NULL, NULL)
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'e61d0fdb-c2e1-4744-a430-0ac5be902463', N'Davis, Leslie (AM)', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'e3eccabc-65ab-46ad-a459-16e8589aee3e', N'Garcia, Jennifer (AM)', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'5f4d1641-314b-408f-88a5-259e20c8307d', N'Jette, Elizabeth', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'c0c0b681-5030-4098-95be-3359b2b445a1', N'Martinez, Enriqueta', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'05caf65d-60ff-4f8d-9de5-34fd9c9a2d9e', N'Diaz, Dulce', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'45473545-6ec5-40aa-aff0-392606750aeb', N'Leslie', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'19dc384c-99b0-4d30-828d-3d9ba5568819', N'Pesquera, Sonia .NMN', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'b46d4323-27d4-4949-b505-4ac231d47009', N'Gilreath, Mary', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'0d241c57-d64a-48d4-9de6-5a1b7e030975', N'Kotnour, Kathy', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'1010d154-3299-4082-be77-5c7ff9e4b695', N'Kowalchuk, Sarah .NMN', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'636e3800-6b9e-4d78-82d0-694cb63f6228', N'Bovino, Gisela .NMN', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'6ec40a4e-14c0-4d97-ac12-7cb181ae0d3b', N'Lizette', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'29e87958-75e7-42c5-a00a-8064411f42b1', N'Potter, Emily', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'236bd9d0-c304-4a01-ba8c-886493a82a75', N'Jenny Magee', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'16546ea9-c140-4ef9-9596-92cd0e184567', N'Figueroa, Ignacio', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'7539ffee-5eb6-4f2a-a570-9467f5163abc', N'', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'570309ef-2f41-4163-87fb-98c93c561a18', N'Johnson, Alexandra D', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'b0d03b95-687e-48aa-b94e-9a00dc4583aa', N'Magee, Jenny', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'979afe84-7144-4b77-9f4f-9f3f9859ff1b', N'Meyers, Julie', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'8e85044e-aa58-445c-808e-aa6021114d19', N'Urroz, Hector', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'ee2be924-147c-4896-bb43-b2de44879c56', N'Jennifer', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'f398e1ec-fb1b-4f23-b4a0-bb2763b10013', N'Smith, Natalia', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'ce24b8aa-2bf2-447d-9869-cd0b4faedf89', N'Natalia', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'69f8c024-fc49-4589-acdd-cd69d5af8474', N'Tobin, Melissa', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'5d52d4fe-ea90-4578-a776-d0fc8e460c55', N'Gonzalez figueroa, Lourdes .NM', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'f0814472-6288-4329-8fbd-d6988a737ce1', N'Myers, Laura', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'60ac39c3-3c18-46c8-a7af-e7a2804fd8b6', N'Reyna', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'd1b8c0cc-54c0-4a37-8905-e7d06a8d420c', N'Mares morales, Maria', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'dfc41173-1e20-458f-bc85-f18b9f1aec3c', N'Garcia, Jennifer (PM)', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'479a9114-a6c2-4ae0-a73e-f8e972dc75f8', N'Davis, Leslie (PM)', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'02920725-bc91-4c63-b7a7-fcb9d5bf9636', N'Arrieta, Cindy', N'UNIHILL')
GO
INSERT [dbo].[Teachers] ([Rp], [FullName], [School]) VALUES (N'33f85b40-d077-4eec-8398-fda45b70f1f2', N'Nelson, Sara .NMN', N'UNIHILL')
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Castruita, Joaxin', N'Joaxin', N'167010', 443655, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Congedo, Vivian', N'Vivian', N'172292', 496484, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Eberle-Taylor, Quinlan', N'Quinlan', N'172763', 501187, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Fox, Sylvie', N'Sylvie', N'171874', 492302, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Garcia, Alma', N'Alma', N'172000', 493556, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Lopez, Jesus', N'Jesus', N'171760', 491157, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Lopez, Caesar', N'Caesar', N'171900', 492563, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Luna-Zapatero', N'Cristian', N'165921', 432766, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Martinez', N'Jaqueline', N'171998', 493542, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Munro', N'Anna', N'172655', 500110, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Murillo', N'Alexis', N'172000', 493555, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Murphy', N'Sheamus', N'173201', 505568, NULL, NULL, 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Najera', N'Gael', N'172720', 500757, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Ramirez', N'Jorge', N'172122', 494784, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Rincon', N'Shelsy', N'172762', 501184, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Sermeno-Urroz', N'Sebastian', N'172791', 501467, NULL, NULL, 4, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Wendell', N'Jack', N'171878', 492336, NULL, NULL, 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Wilson', N'Batia', N'166956', 443124, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Aguilar', N'Camila', N'173174', 505299, NULL, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Aguilar Ramirez', N'Yurem', N'171744', 490996, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Aldaba', N'Joseline', N'167013', 443685, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Arellano', N'Paola', N'166071', 434266, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Arias', N'Allison', N'173527', 508834, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Canales', N'Juan Luis', N'172946', 503016, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Chagala', N'Edgar', N'167016', 443721, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Garcia', N'Ruby', N'171752', 491079, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Lopez-Zepeda', N'Eduardo', N'166940', 442961, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Monreal', N'Jazmin', N'173596', 509521, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Monreal', N'Fatima', N'173178', 505341, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Morales', N'Raul', N'167018', 443735, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Morquecho', N'Camila', N'173322', 506776, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Murillo', N'Kimberly', N'172806', 501615, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Rincon', N'Edwin', N'167052', 444084, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Salvador', N'Jennyfer', N'173653', 510087, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Sanchez', N'Vianey', N'173535', 508914, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Silva', N'Abel', N'172909', 502654, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Natalia L1', N'Uvina', N'Kenny', N'172757', 501133, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Bellinger', N'Christopher', N'173145', 505006, NULL, NULL, 17, NULL, 19, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Abrego', N'Leidy', N'167059', 444146, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Aguilar', N'Jonathan', N'172757', 501128, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Arden', N'Mateo', N'173069', 504253, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Barcenas', N'Roberto', N'172523', 498788, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Colis', N'Sabrina', N'172509', 498651, NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Doles', N'Kadin', N'172975', 503306, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Duke', N'Ben', N'173165', 505207, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Fraire', N'Alvaro', N'172369', 497245, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Garcia', N'Diego', N'166314', 436695, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Kowalchuk', N'Boone', N'172707', 500633, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Krutsinger Swenson', N'Daelin', N'172671', 500274, NULL, NULL, 18, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Murillo', N'Analis', N'172509', 498645, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Oremus', N'Sydney', N'173171', 505269, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Ramirez', N'Sebastian', N'166950', 443057, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Ramirez', N'Luis', N'173344', 507000, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Ramirez', N'Lizbet', N'166959', 443150, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'Robison', N'Allan', N'173123', 504786, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'White', N'Jackson', N'173036', 503920, NULL, 8, NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Queta', N'White', N'Isis', N'173179', 505346, NULL, NULL, 23, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Valtierra', N'Luis', N'167102', 444582, NULL, NULL, 33, NULL, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'M''Bagoyi', N'Duniya', N'174177', 515328, NULL, NULL, NULL, NULL, 16, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Belfi', N'George', N'174183', 515389, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Castro Calderon', N'Gustavo', N'173323', 506794, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Coyne', N'Eve', N'174157', 515132, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Delgado', N'Dylan', N'167130', 444859, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Guerrero', N'Jessica', N'173788', 511443, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Herrera', N'Maite', N'173132', 504882, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Hite', N'Aiden', N'173909', 512653, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Koo', N'J. Mauricio', N'122644', NULL, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Lopez Gutierrez', N'Jovanni', N'174012', 513679, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Mowen', N'Milo', N'173946', 513018, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Olivares', N'Riley', N'167143', 444993, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Quijada Escobar', N'Andrea', N'173962', 513180, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Ruiz Sanchez', N'Eksar', N'167127', 444833, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Vasquez', N'Mia Sofia', N'173964', 513202, NULL, NULL, 31, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Walsh', N'Taylor', N'173926', 512815, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Reyna', N'Zado', N'Collins', N'173375', 507308, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Gilreath', N'Clay', N'173057', 504130, NULL, NULL, NULL, NULL, 4, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Almeda Solis', N'Diego', N'167069', 444252, NULL, NULL, 35, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Becerra', N'Eric', N'172499', 498547, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Cardona', N'Simon', N'167032', 443877, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Ceres', N'Ellen', N'173146', 505015, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Epstein', N'Levi', N'172424', 497804, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Haney', N'Dylan', N'166969', 443245, 13, NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Lopez', N'Christopher', N'166945', 443010, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Martinez', N'Samantha', N'173189', 505451, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'McCoy', N'Alejandro Carter', N'173695', 510507, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Ponce', N'Abigail', N'172535', 498910, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Quijada', N'Michael', N'166965', 443212, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Ramirez', N'Jocelyn', N'172745', 501013, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Rodriguez', N'Ian', N'172384', 497395, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Rodriguez', N'Emmanuel', N'173099', 504546, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Sanchez', N'Ximena', N'172999', 503554, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Sanchez Escalante', N'Lisette', N'167071', 444269, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Slade', N'Javier', N'172697', 500532, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Stoddard', N'Lia', N'173127', 504828, 1, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sara', N'Zavala', N'Reyna', N'173098', 504544, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Cohen', N'Hannah', N'172114', 494699, 2, 2, NULL, 1, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Espinosa', N'Paloma', N'171982', 493379, 2, NULL, NULL, 17, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Montes', N'Ivan', N'166725', 440806, NULL, NULL, 25, NULL, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Boromisza-Habashi', N'Anna', N'172031', 493870, 2, NULL, NULL, NULL, 8, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Acosta Martinez', N'Michelle', N'171724', 490802, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Cercas', N'Genaro', N'166552', 439076, NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Colis', N'Bryan', N'171076', 484321, NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Goetz', N'Charlie', N'172362', 497178, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Gordillo Perez', N'Emily', N'171293', 486494, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Kirshner', N'Jackson', N'171972', 493282, NULL, 1, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Lippold', N'Stefan', N'171725', 490809, NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Longoria Portillo', N'Denise', N'171975', 493309, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Lopez Zepeda', N'Edith', N'166719', 440749, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Lopez-Organista', N'(Cristian) Alex', N'172556', 499117, NULL, NULL, 3, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Ortiz', N'Angel', N'171251', 486068, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Ponce', N'Diana', N'171910', 492657, 18, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Ramirez Escalante', N'Alexa', N'171083', 484386, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Sarah', N'Stillman', N'Shea', N'166886', 442421, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Bonta', N'Tristan', N'167197', 445528, 21, 6, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Boromisza-Habashi', N'Mira', N'173540', 508962, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Borden', N'Abigail', N'173212', 505675, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Buell', N'Clara', N'173542', 508976, 3, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Chigo', N'Conchita', N'167003', 443585, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Embry', N'James', N'167086', 444422, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Erickson', N'Aiden', N'173527', 508833, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Fischer', N'Mason', N'167053', 444094, NULL, NULL, 18, NULL, NULL, NULL, N'(kid rides bike 3 miles and takes the bus)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'King', N'Annika', N'173641', 509973, 8, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Lane', N'Nyssa', N'173570', 509255, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Raveczky', N'Charles', N'173538', 508941, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Roe', N'Samantha', N'172757', 501130, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Ruskay', N'Lily', N'173426', 507816, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Sloan', N'Giselle', N'172709', 500653, NULL, NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Sia L1', N'Walsh', N'Wesley', N'166978', 443344, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Callahan', N'Quinn Bryant', N'172704', 500601, NULL, NULL, NULL, NULL, 4, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Aguilar', N'Angel', N'166948', 443041, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Barrett', N'Tristan', N'172393', 497486, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Chairez', N'Bryan', N'167068', 444235, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Cook', N'Sam', N'171902', 492578, NULL, NULL, 16, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Cortez', N'Charlene', N'173295', 506505, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Davis', N'Toray', N'173228', 505836, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Garcia', N'Jorge', N'172996', 503521, NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Guerrero', N'Fernanda', N'172384', 497403, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Kless', N'Sienna', N'173050', 504063, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Martin', N'Skyler', N'173184', 505395, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'McKee', N'Joaquin', N'173141', 504971, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Murillo', N'Cristian', N'167011', 443671, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Olivares', N'Jacobi', N'173314', 506696, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Ortiz', N'Alex Cesar', N'172509', 498650, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Perez', N'Sylvana', N'172517', 498725, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Pohl', N'Zaya', N'173288', 506439, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Pryor', N'Lotty', N'173135', 504906, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Rutkowski', N'Jordan', N'173312', 506682, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Torres', N'Susana', N'172444', 497996, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Sonia', N'Valtierra', N'Lucero', N'172557', 499133, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Bickford', N'Raquel', N'173971', 513265, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Bretado', N'Celina (Cena)', N'173213', 505692, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Chairez', N'Julissa', N'172909', 502651, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Chen', N'Kai', N'173131', 504871, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Dayton', N'Coulter', N'167072', 444284, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Embry', N'Evan', N'173500', 508555, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Fernandez Zavala', N'Jayson', N'167173', 445288, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Garcia', N'Jose', N'173917', 512728, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Garcia Estrada', N'Heidy', N'173151', 505069, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Griebel', N'Seneca', N'173489', 508453, NULL, 2, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Jaramillo Ortman', N'Lucas', N'173890', 512464, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Lawson', N'David', N'173882', 512381, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Murillo', N'Valery', N'173181', 505374, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Ordaz-Garcia', N'Valeria', N'167145', 445008, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Oviatte', N'Dahlia', N'174065', 514212, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Rojas', N'Delia', N'173867', 512230, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Zambrano Ramos', N'Francisca', N'173360', 507155, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Emily', N'Zeldner', N'Samuel', N'173993', 513493, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Esparza', N'Christian', N'172106', 494621, NULL, NULL, 5, 5, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Espinosa', N'Azul', N'171983', 493388, NULL, 1, 1, 7, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Baker-Rosenthal', N'Della', N'171981', 493370, NULL, NULL, NULL, NULL, 6, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Aguirre', N'Adriana', N'171951', 493073, NULL, NULL, 8, NULL, 8, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Arredondo Fraire', N'Anthony', N'166751', 441072, NULL, NULL, 14, 3, 9, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Arellano Gamboa', N'Juanita', N'171251', 486069, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Castro Cital', N'Adolfo', N'171840', 491961, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Chigo Cagal', N'Maria Cecilia', N'171118', 484744, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Cortez Vargas', N'Javier', N'166551', 439074, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Lopez Argumedo', N'Reina', N'171704', 490598, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'McCoy', N'Tyler', N'173695', 510508, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Murillo Ramirez', N'Luis', N'171562', 489182, NULL, NULL, 6, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Nelson', N'Van', N'171980', 493356, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Ordaz', N'Jose', N'171292', 486479, 1, 2, 9, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Rothschild', N'Gabriel ', N'172069', 494253, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Sullivan', N'Naomi', N'171882', 492381, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Valladares', N'Jacob', N'174088', 514441, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Gisela', N'Yavuz', N'Selma Jane', N'171566', 489220, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Almeda Solis', N'Steven', N'171725', 490812, NULL, NULL, 23, 1, 2, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Wlad-Mengering', N'Lucie', N'172481', 498369, NULL, 13, NULL, 17, 4, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Chihuahua', N'Marisol', N'171720', 490760, NULL, NULL, 21, NULL, 15, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Arredondo', N'Kevin', N'171690', 490460, NULL, NULL, 35, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Bartell', N'Ariel', N'172281', 496370, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Bernthal', N'Quinn', N'172513', 498691, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Breed-Carithers', N'Stella', N'172297', 496526, NULL, NULL, 13, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Esparza', N'Ayleen', N'166956', 443118, NULL, NULL, 34, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Gurrola', N'Jacob', N'172746', 501015, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Haney', N'Rhys', N'171448', 488043, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Juza', N'Tomas', N'173219', 505748, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Muir', N'Sebastian', N'172337', 496934, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Rincon', N'Emma', N'171337', 486931, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Rodriguez', N'Bryan', N'172108', 494636, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Rodriguez', N'Aileen', N'166956', 443120, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Rodriguez Arrellano', N'Jose', N'171704', 490602, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Rutkowski', N'Skylar', N'172503', 498592, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Slade', N'Felix', N'171844', 492003, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Ignacio', N'Torres Lopez', N'Daisy', N'171679', 490346, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Jennifer', N'Iglesias-Ruiz', N'Eduardo', N'167200', 445562, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Jennifer', N'Ryan', N'Kingston', N'174211', 515674, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Devora', N'Roberto', N'173820', 511760, NULL, NULL, 33, NULL, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Sanchez Garcia', N'Jayden', N'166972', 443284, NULL, NULL, 25, NULL, 3, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Amaral', N'Anabella', N'173742', 510977, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Carr', N'Mercedes', N'174003', 513586, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Day', N'Karina', N'173912', 512681, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Featherstone', N'Arya', N'174000', 513558, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Garcia', N'Allyson', N'173983', 513386, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Garcia', N'Yamileth', N'173987', 513429, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Iturbe', N'Danicka ', N'173497', 508526, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Jaimes', N'Jonathan', N'166995', 443509, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'King', N'Siri', N'173742', 510980, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Meyer Lesiuk', N'Cartier', N'174074', 514298, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Pagel', N'Wolf', N'167049', 444050, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Perez-Ledezma', N'Maria (Lupita)', N'167074', 444300, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Puente', N'Antoni', N'167032', 443875, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Reynolds Marti', N'Alexander', N'173349', 507051, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Rodriguez', N'Zahira', N'173536', 508919, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Roetto', N'Isaac', N'173950', 513058, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Russo Ruiz', N'Marianne A.', N'122644', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Steig', N'Danni', N'173485', 508405, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'Kindergarten', N'Jenny', N'Zavala', N'Camila', N'173974', 513295, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Ibarra', N'Jonathan', N'171666', 490221, NULL, NULL, 12, NULL, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Fuentes Leiva', N'Jaimie', N'172146', 495023, NULL, NULL, 18, NULL, 2, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Gilreath', N'Wallace', N'172222', 495783, NULL, NULL, NULL, NULL, 10, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Kowalchuk', N'Taytem', N'171875', 492314, NULL, NULL, NULL, 2, 22, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Alpizar', N'Estrella', N'172450', 498055, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Bookman Urroz', N'Noah', N'166952', 443080, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Galvan', N'Angel', N'172519', 498751, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Gutierrez', N'Julissa', N'171695', 490505, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Henkel', N'Jaden', N'166893', 442490, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Hernandez Garcia', N'Eric', N'171583', 489387, NULL, NULL, 21, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Howser', N'Coco', N'172225', 495812, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Juarez', N'Ashley', N'172358', 497136, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Levy Wright', N'Mikayah', N'171673', 490288, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Mandy', N'Ella', N'173671', 510271, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Ordaz Lopez', N'Maria Hannah', N'166037', 433931, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Paradiso', N'Johnny', N'171874', 492299, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Perez', N'Isabela', N'171699', 490553, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Ricardo Martinez', N'Alan', N'171197', 485525, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Rodriguez', N'Salomon', N'171461', 488171, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Stoddard', N'Noah', N'171860', 492158, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Julie', N'Valles', N'Alexa', N'171721', 490766, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Arellano', N'Christopher', N'172536', 498918, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Arredondo', N'Christian', N'172540', 498959, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Arredondo', N'Angel', N'173038', 503941, NULL, NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Breed', N'River', N'166951', 443072, NULL, NULL, 18, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Cullison', N'Caio', N'173022', 503775, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Dayton', N'Pierce', N'172722', 500778, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'De La Cruz', N'Lupita (Guadalupe)', N'166949', 443046, NULL, NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Garcia', N'Marely', N'167010', 443660, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Gonzalino', N'Daniel', N'173122', 504778, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Goodwin', N'Isabela', N'173032', 503877, NULL, NULL, 5, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Griebel', N'Sebastian', N'166433', 437889, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Hildreth', N'August', N'173806', 511619, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Juza', N'Matty', N'173292', 506477, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Koler-Stage', N'Maddox', N'173143', 504993, NULL, NULL, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Loredo', N'Hayden', N'173698', 510544, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Martinez', N'Angel', N'173178', 505337, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Moreno', N'Reilly', N'172511', 498668, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Rodriguez', N'Alessa', N'167011', 443669, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Romero', N'Miriam Ruby', N'173092', 504484, NULL, NULL, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Urquiza', N'Yailin', N'172904', 502596, NULL, NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'2nd', N'Kathy', N'Whitaker', N'Somi', N'173257', 506126, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Dutton', N'Oren', N'171974', 493297, NULL, NULL, 12, 5, 5, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Fox', N'Tessa', N'166887', 442425, NULL, NULL, 12, 5, 5, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Martinez Alvarado', N'Valeria', N'166759', 441152, NULL, NULL, 11, NULL, 5, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Jones', N'McKenzie', N'171544', 488997, NULL, NULL, NULL, NULL, 8, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Hernandez', N'Leslie', N'171262', 486180, NULL, NULL, 18, 1, 9, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Goodwin', N'Diego', N'171956', 493118, NULL, NULL, 2, 10, 10, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Kohm', N'Jaya', N'171923', 492788, NULL, NULL, 2, NULL, 18, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Arias Aguilar', N'Maria Fernanda', N'171918', 492738, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Arias Hernandez', N'Jason', N'171272', 486280, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Balderas-Lujan', N'Daniel', N'171264', 486197, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Haag-Toney', N'Jade', N'171951', 493074, NULL, NULL, 2, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Hernandez', N'Jose', N'171674', 490300, NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Loffredo', N'Giorgio', N'172115', 494714, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Martinez Perez', N'Kevin', N'171292', 486481, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Moreno Contreras', N'Andrea', N'171251', 486066, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Morquecho Zavala', N'Omar', N'171291', 486473, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'5th', N'Laura', N'Perales', N'Ashley', N'172117', 494729, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Leslie', N'Kelton', N'Benjamin', N'173497', 508534, 29, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Leslie', N'Lavastida Rascon', N'Abigail', N'174173', 515286, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Leslie', N'Lavastida Rascon', N'Gabriela', N'174172', 515283, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Leslie', N'Sloan', N'Cassidy', N'173899', 512547, NULL, NULL, 6, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'PreK', N'Leslie', N'Wallace', N'Leander', N'173917', 512733, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Kingsbury', N'Quinn', N'172240', 495960, NULL, NULL, NULL, 12, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Lowrimore', N'Niamh', N'173239', 505949, NULL, NULL, NULL, NULL, 1, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'M''Bagoyi', N'Gabriella', N'174166', 515217, NULL, NULL, NULL, NULL, 7, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Adelman', N'Abilene', N'172260', 496163, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Aguilar', N'Alan', N'172343', 496993, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Bolgatz', N'Carson MacLeay', N'171546', 489016, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Bonewitz', N'Haley', N'171399', 487551, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Buell', N'Abigail', N'173620', 509763, 9, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Colis', N'Sammy', N'171555', 489112, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Elizalde', N'Lizette', N'172129', 494846, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Ferrell', N'Lola', N'172375', 497306, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Hernandez A.', N'Yasmin', N'172179', 495349, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Herrera Rincon', N'Andrea', N'172118', 494743, NULL, NULL, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Kless', N'Rebecca', N'172219', 495746, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Longoria', N'Adamaris', N'172367', 497233, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Longoria', N'Alejandro', N'171720', 490762, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Lopez', N'Lesly', N'172131', 494866, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Louth', N'Summit', N'172381', 497366, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Ramirez', N'Viquel', N'172343', 496992, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Schmid', N'George', N'173621', 509773, NULL, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Soledad-Puebla', N'Bryan', N'172423', 497789, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'4th', N'Liz', N'Solis', N'Raquel', N'174121', 514772, 8, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Sepulveda', N'Amaya', N'173626', 509820, NULL, NULL, 7, 2, 10, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Acosta', N'Genesis', N'171995', 493513, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Alaniz', N'Elmer', N'165513', 428688, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Aldaba', N'Raudel', N'172504', 498604, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Arellano', N'Alex', N'172166', 495223, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Fuentes', N'Santiago', N'172146', 495024, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Groves', N'Isadora', N'173873', 512288, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Guevara', N'Selena', N'172443', 497991, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Kembel', N'Isabel', N'171894', 492502, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Linsenmeyer', N'John', N'172780', 501361, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Lopez', N'Andrea', N'172732', 500877, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Lopez-Beltran', N'Erick', N'173383', 507394, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Ordaz', N'Betsy', N'166037', 433927, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Ramirez', N'Flavio', N'171727', 490831, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Rissman', N'Jack', N'172793', 501494, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Rothschild', N'Sebastian', N'172327', 496833, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Sampson', N'Chayton', N'171999', 493548, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Schorr', N'Ramses (Kenneth)', N'173554', 509102, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Segovia', N'Nelsy', N'172185', 495414, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Lourdes', N'Valladares', N'Alana', N'174089', 514445, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Mitchell', N'Gabriel', N'173134', 504895, 1, 1, NULL, NULL, 32, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Aguijosa', N'Ivan', N'167045', 444009, NULL, NULL, 27, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Arellano', N'Diego', N'172942', 502981, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Beck', N'Sarah', N'173139', 504948, NULL, NULL, 32, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Bickford', N'Gabriela', N'173571', 509269, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Bretado', N'Lupita', N'172801', 501573, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Bustos', N'Alexander', N'166249', 436046, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Galvan', N'Emiliano', N'173487', 508429, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Groves', N'Silas', N'173873', 512285, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Herrera', N'Andres', N'166983', 443392, NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Lane', N'Annora', N'173570', 509257, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Melara-Hernandez', N'Karla', N'173349', 507048, NULL, NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Montes', N'Lindsey', N'172795', 501512, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Morquecho', N'Ivon', N'167067', 444229, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Murillo', N'Ximena', N'172943', 502988, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Velayo', N'Joshua', N'172710', 500655, NULL, NULL, 2, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Lupe', N'Warshaw', N'Jadyn ', N'173534', 508899, NULL, 1, 29, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Alaniz', N'Vanessa', N'172804', 501595, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Arellano', N'Alvaro', N'173130', 504862, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Canales Hernandez', N'Luis Miguel', N'172946', 503015, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'D''Onofrio', N'Violet', N'173132', 504876, NULL, NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Eberle-Taylor', N'Will', N'173537', 508925, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Garcia', N'Camila', N'172798', 501536, NULL, NULL, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Lopez', N'Yoelli', N'173357', 507132, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Lowrimore', N'Kieran', N'173644', 509997, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Mandy', N'Taj', N'173671', 510268, NULL, NULL, 14, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Perez-Garcia', N'Itzel', N'166972', 443278, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Robertson', N'Skyler', N'173545', 509012, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Rodarte', N'Alexander', N'173540', 508958, NULL, NULL, 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Rodriguez', N'Allan', N'166970', 443258, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Sampson', N'Takoda', N'172706', 500622, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Schmid', N'Juniper', N'173621', 509774, NULL, 2, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Silva', N'Yasmeen', N'171316', 486723, NULL, NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Soto Gonzalez', N'Alexa', N'173570', 509256, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'1st', N'Mary', N'Stone', N'Bintang', N'173100', 504555, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Woodson', N'Neva ', N'172792', 501475, 2, NULL, NULL, NULL, 2, 0.25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[TripImport] ([Grade], [Teacher], [Last Name], [First Name], [Student ID(T)], [Student ID], [Walk], [Bike], [Bus], [Carpool], [Car+Walk], [C+W Dist], [F13], [F14], [F15], [F16], [F17], [F18], [F19], [F20], [F21], [F22], [F23], [F24], [F25], [F26], [F27], [F28], [F29], [F30]) VALUES (N'3rd', N'Melissa', N'Arias', N'Dulce', N'172776', 501316, NULL, NULL, 32, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'7421a17a-a3f8-469b-a12c-3b93ccc90547', 7, 1, CAST(N'2016-08-20T17:45:18.160' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173910, CAST(12.5000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167102, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171666, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172240, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173239, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173820, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172792, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172704, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173057, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166759, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171981, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 174166, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171544, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 172031, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172222, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 171720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 174177, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171923, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 173145, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171875, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173201, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173644, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 166886, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171555, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171923, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172225, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172710, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173571, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173806, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173873, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 171878, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172556, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172791, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171562, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 173899, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 167016, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173641, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 173500, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171840, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172523, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 166759, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 172122, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 174211, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 171666, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 171900, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 172297, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 171399, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 166969, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171695, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171760, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171902, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 172517, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173375, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173489, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 166945, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 167086, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 167200, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 173145, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166433, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 167053, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171699, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171998, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 172671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 172709, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 171291, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171583, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 173620, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 166552, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171076, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171674, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 173179, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 173349, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 166719, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 171083, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 171975, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 172343, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 172369, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 166725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 172118, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 167003, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171293, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171461, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171721, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171724, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172129, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172358, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172519, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(27.0000000000000 AS Decimal(25, 13)), 167045, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 122644, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 166940, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 171744, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172343, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172423, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172504, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172557, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172762, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 173527, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 172904, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173174, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173542, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 167068, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 171264, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 171272, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172000, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172115, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172384, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173322, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173487, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173570, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173987, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(31.0000000000000 AS Decimal(25, 13)), 173964, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 165513, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166071, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166314, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166948, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167013, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167018, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167052, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167059, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 171727, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 171995, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172000, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172367, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172444, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172757, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172776, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172806, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172909, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172946, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173139, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173178, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173184, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173189, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173383, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173535, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173596, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173653, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 166983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 167102, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172798, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172996, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 173820, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 167011, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 167067, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 171704, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172117, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172131, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172166, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172732, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172745, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172757, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173098, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173122, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173178, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173213, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173295, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173540, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 166949, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 167069, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 171690, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 173038, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 173092, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166249, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166950, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166959, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166965, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166970, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167010, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167011, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167071, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171316, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171337, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171679, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171918, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172108, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172185, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172384, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172424, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172499, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172511, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172536, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172540, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172746, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172795, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172801, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172804, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172942, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172943, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172946, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173099, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173130, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173132, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173181, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173323, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173344, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173357, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173360, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173536, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173788, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173917, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167069, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171583, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171690, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171902, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173050, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173141, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173257, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173867, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171562, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171875, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171878, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172793, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173139, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172337, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172710, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173545, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173201, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173964, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 174121, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171860, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171910, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 173426, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 173032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173127, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172791, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 172297, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 172240, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 173036, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 173179, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173899, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173917, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172219, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172260, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 172556, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 173171, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 173314, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173143, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 173132, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173497, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173489, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171566, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 172381, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173036, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173127, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172031, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172792, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173542, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173538, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173641, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 174121, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 173620, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 166969, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171910, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 166037, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(27.0000000000000 AS Decimal(25, 13)), 172443, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173497, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172535, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2016-06-27T22:43:51.643' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166037, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167102, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171666, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172240, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173239, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173820, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172792, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172704, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173057, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166759, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171981, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 174166, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171544, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 172031, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172222, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 171720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 174177, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171923, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 173145, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171875, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 7, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173201, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173644, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 166886, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171555, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171923, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172225, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172710, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173571, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173806, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173873, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 171878, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172556, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 172791, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171562, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 173899, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 167016, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173641, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 173500, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171840, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172523, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 166759, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 172122, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 174211, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 171666, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 171900, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 172297, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 171399, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(14.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 166969, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171695, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171760, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171902, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 171972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 172517, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173375, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173489, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 166945, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 167086, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 167200, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 173145, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166433, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 167053, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171699, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171998, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 172671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 172709, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 171291, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171583, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171720, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 173620, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 166552, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171076, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 171674, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 173179, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(23.0000000000000 AS Decimal(25, 13)), 173349, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 166719, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 171083, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 171975, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 172343, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 172369, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 166725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(25.0000000000000 AS Decimal(25, 13)), 172118, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 167003, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171293, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171461, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171721, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 171724, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172129, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172358, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 172519, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(27.0000000000000 AS Decimal(25, 13)), 167045, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 122644, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 166940, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 171744, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172343, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172423, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172504, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172557, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 172762, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(28.0000000000000 AS Decimal(25, 13)), 173527, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 172904, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173174, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173542, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 167068, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 171264, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 171272, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172000, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172115, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172384, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173322, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173487, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173570, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 173987, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(31.0000000000000 AS Decimal(25, 13)), 173964, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 165513, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166071, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166314, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166948, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167013, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167018, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167052, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 167059, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 171727, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 171995, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172000, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172367, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172444, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172757, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172776, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172806, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172909, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 172946, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173139, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173178, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173184, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173189, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173383, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173535, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173596, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(32.0000000000000 AS Decimal(25, 13)), 173653, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 166983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 167102, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172509, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172798, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 172996, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 173820, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 167011, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 167067, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 171704, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172117, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172131, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172166, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172732, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172745, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 172757, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173098, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173122, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173178, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173213, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173295, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173540, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 173974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 166949, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 167069, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 171690, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 173038, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(35.0000000000000 AS Decimal(25, 13)), 173092, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166249, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166950, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166959, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166965, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 166970, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167010, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167011, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 167071, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171251, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171316, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171337, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171679, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 171918, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172108, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172185, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172384, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172424, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172499, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172511, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172536, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172540, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172746, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172795, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172801, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172804, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172942, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172943, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 172946, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173099, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173130, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173132, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173181, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173323, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173344, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173357, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173360, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173536, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173788, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 4, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(36.0000000000000 AS Decimal(25, 13)), 173917, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167069, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171262, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171583, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171690, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171725, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171902, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173050, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173141, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173257, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173867, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171562, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171875, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171878, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172793, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173139, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173626, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 166751, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172337, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 172710, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173545, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173671, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173146, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(4.0000000000000 AS Decimal(25, 13)), 173201, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 166887, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 171974, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 172106, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173964, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 174121, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171860, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 171910, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 173426, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(7.0000000000000 AS Decimal(25, 13)), 173032, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173127, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 171956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(10.0000000000000 AS Decimal(25, 13)), 172791, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(11.0000000000000 AS Decimal(25, 13)), 172297, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(12.0000000000000 AS Decimal(25, 13)), 172240, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 173036, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(15.0000000000000 AS Decimal(25, 13)), 173179, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173899, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(16.0000000000000 AS Decimal(25, 13)), 173917, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172219, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172260, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(17.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 166951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(19.0000000000000 AS Decimal(25, 13)), 172556, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 171951, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(20.0000000000000 AS Decimal(25, 13)), 173171, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(24.0000000000000 AS Decimal(25, 13)), 173314, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(26.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173143, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 6, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(33.0000000000000 AS Decimal(25, 13)), 173132, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171972, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171983, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173497, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173534, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173489, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 173621, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(6.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 171566, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 172381, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173036, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 2, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 172481, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166956, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171292, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173127, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173134, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 171982, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172031, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172114, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(2.0000000000000 AS Decimal(25, 13)), 172792, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(3.0000000000000 AS Decimal(25, 13)), 173542, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(5.0000000000000 AS Decimal(25, 13)), 173538, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 173641, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(8.0000000000000 AS Decimal(25, 13)), 174121, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(9.0000000000000 AS Decimal(25, 13)), 173620, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(13.0000000000000 AS Decimal(25, 13)), 166969, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(18.0000000000000 AS Decimal(25, 13)), 171910, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(21.0000000000000 AS Decimal(25, 13)), 167197, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(22.0000000000000 AS Decimal(25, 13)), 166037, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(27.0000000000000 AS Decimal(25, 13)), 172443, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(29.0000000000000 AS Decimal(25, 13)), 173497, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(30.0000000000000 AS Decimal(25, 13)), 172535, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (NULL, 1, 2, CAST(N'2017-04-02T13:12:23.943' AS DateTime), CAST(34.0000000000000 AS Decimal(25, 13)), 166037, NULL)
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'32b3fa08-0028-4e74-a11b-6c2b5f626ddb', 7, 1, CAST(N'2016-07-02T16:53:28.290' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173522, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'39ebc405-907c-41b1-aa25-5413aa91d664', 4, 1, CAST(N'2016-07-03T12:12:20.140' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172975, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'97bffbce-7334-4832-bbf5-fb8d4fd6359c', 3, 1, CAST(N'2016-07-03T12:12:40.530' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173123, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'adf2a2bc-ebb5-4e26-aad7-1451e56777bd', 3, 1, CAST(N'2016-07-12T13:18:48.140' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173563, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'c1877b3b-ab33-4b3a-98f0-2f130bd81224', 1, 1, CAST(N'2016-08-14T19:07:06.500' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 166983, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'd6bbe67f-effe-47be-a97f-5fad21365060', 1, 1, CAST(N'2016-08-14T19:24:27.197' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 173522, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'0e7814f9-18a7-453f-9c6c-2460bd4189f8', 1, 1, CAST(N'2016-08-20T17:00:52.097' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 174010, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'e8a96366-b9b7-4c52-bd65-da08a58a44d3', 2, 1, CAST(N'2016-07-02T16:53:58.237' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 172118, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
INSERT [dbo].[Trips] ([Rp], [TripType], [EntryType], [EntryDate], [Trips], [ID], [Distance]) VALUES (N'1cc81ed0-3f2c-4105-b619-c0416c3e4fed', 7, 1, CAST(N'2016-08-20T17:36:39.600' AS DateTime), CAST(1.0000000000000 AS Decimal(25, 13)), 171981, CAST(0.0000000000000 AS Decimal(25, 13)))
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE spDoBackup
AS

BACKUP DATABASE TripTrackerApp 
TO DISK = 'C:\TripTrackerApp\backup\TripTrackerApp.BAK'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE
[dbo].[spImportData]
@DoReg INT = 0
,@DoTrips INT = 0
,@PerDate DATETIME = null
AS

--EXEC spIMportData 1, 1, '2017-04-02 13:12:23.943'
IF @DoReg = 1
BEGIN
	TRUNCATE TABLE Students
	INSERT INTO Students (FirstName, LastName, ID, Teacher, RP)
	SELECT MAX(First), MAX(Last), ROUND(StudentID_T,0), MAX(student#homeroomteacher), NEWID()
		FROM RegistrationImport
	GROUP BY ROUND(StudentID_T,0) -- dupes
	ORDER BY MAX(StudentID_T) DESC
	SELECT * FROM Students
	TRUNCATE TABLE Teachers
	INSERT INTO Teachers (FullName, Rp, School)
	SELECT Teacher, NEWID(), 'UNIHILL'
		FROM Students
		GROUP BY Teacher
	SELECT * FROM Teachers
END
IF @DoTrips = 1
BEGIN
	IF @PerDate = NULL SET @PerDate = GETDATE()
	SELECT @PerDate
	DELETE FROM TripImport WHERE [Student ID(T)] IS NULL
	-- TODO : Calculate car + walk distance in trips
	INSERT INTO Trips (ID, TripType, EntryType, EntryDate, Trips, Rp) 
	SELECT 
	[Student ID(T)], CASE WHEN Walk > 0 THEN 1 -- 1 Walk, 2 Bike, 3 Skate\Scoot, 4 School Bus, 5 RTD, 6 Carpool, 7 Car + Walk
			WHEN Bike > 0 THEN 2
			WHEN BUs > 0 THEN 4
			WHEN Carpool > 0 THEN 6
			WHEN [Car+Walk] > 0 THEN 7 END, 2, COALESCE(@PerDate,GETDATE())
			, CASE WHEN Walk > 0 THEN SUM(Walk) -- 1 Walk, 2 Bike, 3 Skate\Scoot, 4 School Bus, 5 RTD, 6 Carpool, 7 Car + Walk
			WHEN Bike > 0 THEN SUM(Bike)
			WHEN BUs > 0 THEN SUM(Bus)
			WHEN Carpool > 0 THEN SUM(Carpool)
			WHEN [Car+Walk] > 0 THEN SUM([Car+Walk]) END, NEWID()
	--	,SUM(Walk), SUM(Bike), SUM(Bus), SUM(CarPool), SUM([Car+Walk]), SUM([C+W Dist]), [Student ID(T)]
		FROM tripimport t
		LEFT OUTER JOIN Trips pt ON pt.ID = t.[Student ID(T)]
			AND MONTH(pt.EntryDate) = MONTH(@PerDate) AND YEAR(@PerDate) = YEAR(pt.EntryDate)
		JOIN Periods m ON MONTH(@PerDate) = m.MonthNo AND YEAR(@PerDate) = m.Year
	--WHERE  + pt.Trips < m.MaxTrips -- TODO : CHECK FOR MAX TRIPS
	GROUP BY GROUPING SETS (([Student ID(T)], Walk), ([Student ID(T)], Bike), ([Student ID(T)], Carpool)
		, ([Student ID(T)], Bus), ([Student ID(T)], [Car+Walk]))-- Bus, Carpool, [Car+Walk])
	HAVING Walk > 0 OR Bus > 0 OR Carpool > 0 OR [Car+Walk] > 0 OR Bike > 0
	ORDER BY t.[Student ID(T)] DESC
	--SELECT * FROM TripImport WHERE [Student ID(T)] = 173964
	SELECT * FROM Trips WHERE MONTH(EntryDate) = MONTH(@PerDate)
	-- TODO Update trips exceeding MAX
END
--allow excel access
--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;

----drop and recreate temp table from modified excel file
--drop table _physproptemp
--SELECT * INTO _physproptemp
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Admin\Desktop\PA Attribut Values_List.xls;',[Sheet1$])

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInitPeriods]
AS
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 1, 'September', 42, YEAR(GETDATE()), 9
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 2, 'October', 40, YEAR(GETDATE()), 10
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 3, 'November', 32, YEAR(GETDATE()), 11
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 4, 'January', 28, YEAR(GETDATE()) + 1, 1
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 5, 'February', 36, YEAR(GETDATE()) + 1, 2
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 6, 'March', 36, YEAR(GETDATE()) + 1, 3
INSERT INTO Periods (Period, Month, MaxTrips, Year, MonthNo) SELECT 7, 'April', 36, YEAR(GETDATE()) + 1, 4


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE 
[dbo].[spMakeEntry]
@StudentID INT,
@EntryDate DateTime = null,
@EntryType TINYINT = 1, -- 1 Daily, 2 Monthly
@TripType TINYINT = 1, -- 1 Walk, 2 Bike, 3 Skate\Scoot, 4 School Bus, 5 RTD, 6 Carpool, 7 Car + Walk
@Trips INT = 1, -- Only for monthly, spMakeEntry will run for each type
@Distance DECIMAL(25,13) = 0,
@GUID UNIQUEIDENTIFIER = null, -- Generated by client to prevent duplicate inserts
@ErrMess VARCHAR(MAX) = '' OUTPUT,
@RetVal TINYINT = 1 OUTPUT
/*
SAMPLE CALL

DECLARE @NEWGUID UNIQUEIDENTIFIER = NEWID(), @Date DATETIME = GETDATE()
EXEC spMakeEntry 1234, @Date, 2, 1, 0, @NEWGUID

*/
AS
BEGIN

DECLARE @DistanceFromHome DECIMAL(25,13)
SELECT @DistanceFromHome = COALESCE(Distance,0) FROM Students WHERE @StudentID = ID
SET @EntryDate = COALESCE(@EntryDate, GETDATE())
SET @GUID = NEWID()
SET @Distance = CASE WHEN @TripType IN (1,2) THEN @DistanceFromHome
	WHEN @TripType = 7 THEN @Distance
	ELSE 0 END  /* car + walk = entered distance, walk = distance from home, bike = distance from home */
IF COALESCE(@Distance,0) > 0 SET @Trips = 0
--DECLARE @RetVal TINYINT, @ErrMess VARCHAR(40)
	-- DO CLEANUP HERE (Should we be appending instead?)
		--If already daily entry delete and remake
		DELETE FROM trips WHERE ID = @StudentID
			AND DAY(EntryDate) = DAY(@EntryDate)
			AND EntryType = 1
		IF @@ROWCOUNT > 0
		BEGIN
			SET @ErrMess = 'Existing daily entry has been overwritten.  '
		END
		--If already monthly entry delete and display message
		--DELETE FROM trips WHERE ID = @StudentID
		--	AND MONTH(EntryDate) = MONTH(@EntryDate)
		--	AND EntryType = 2
		--	AND Rp <> @GUID

		--IF @@ROWCOUNT > 0
		--BEGIN
		--	SET @ErrMess = @ErrMess + 'Existing monthly entry has been deleted.  '
		--END
		DECLARE @MaxTrips INT, @TotalTrips INT
		SELECT @MaxTrips = MAX(m.MaxTrips), @TotalTrips = SUM(t.Trips)
			FROM Trips t
			JOIN Periods m ON MONTH(t.EntryDate) = m.Month AND YEAR(t.ENtryDate) = m.Year
			WHERE ID = @StudentID AND MONTH(EntryDate) = MONTH (@EntryDate) AND YEAR(EntryDate) = YEAR(@EntryDate)
				AND (t.Trips + @Trips) > m.MaxTrips
			GROUP BY ID
		IF @@ROWCOUNT > 0
		BEGIN
			SET @ErrMess = 'Max trips of ' + CONVERT(varchar(3),@MaxTrips) + ' exceeded. Current trips = ' + CONVERT(varchar(3),@TotalTrips) + '. Entry has been cancelled'
			SELECT @ErrMess, @MaxTrips, @TotalTrips
			GOTO ERROR
		END

		IF @EntryType = 1 
		BEGIN
			INSERT INTO Trips (ID, TripType, EntryType, EntryDate, Trips, Distance, Rp) 
				SELECT @StudentID, @TripType, @EntryType, @EntryDate, 1, @Distance, @GUID
		END
		ELSE
		BEGIN
			INSERT INTO Trips (ID, TripType, EntryType, EntryDate, Trips, Rp, Distance) 
				SELECT @StudentID, @TripType, @EntryType, @EntryDate, @Trips, @GUID, @Distance
		END
IF @ErrMess > '' GOTO ERROR
RETURN
ERROR:
	SET @RetVal = 2
	SELECT @ErrMess
END


GO
