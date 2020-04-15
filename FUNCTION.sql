CREATE FUNCTION SupplyCanBeCompleted (@FlowerId int, @PlantationId int, @Amount int)
RETURNS BIT
AS
BEGIN
	 DECLARE @PlantationFlowers int
	 DECLARE @BookedFlowers int

	 SELECT @PlantationFlowers = SUM([PlantationFlowers].[Amount])
	 FROM [PlantationFlowers] 
	 WHERE [PlantationFLowers].[PlantationId] = @PlantationId AND
	       [PlantationFlowers].[FLowerId] = @FlowerId

	 SELECT @BookedFlowers = SUM([SupplyFlowers].[Amount])
	 FROM [SupplyFlowers]
	 LEFT JOIN [Supply] ON [Supply].[PlantationId] = @PlantationId AND
			       [Supply].[Id] = [SupplyFlowers].[SupplyId]

	 IF (@Amount <= @PlantationFlowers - @BookedFlowers)
	 	RETURN 1
	 RETURN 0
END
