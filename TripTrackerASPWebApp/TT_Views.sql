CREATE VIEW [dbo].[vTripSum]
AS
SELECT t.ID, MONTH(EntryDate) AS EntryDate, SUM(Trips) AS TotalTrips, MAX(FullName) AS FullName
	FROM trips t
	JOIN students s ON s.ID = t.ID
GROUP BY t.ID, MONTH(EntryDate)
GO

