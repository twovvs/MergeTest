CREATE TABLE [test].[ItemSkuSupplier] (
    [TestRunID]             INT           NULL,
    [OptionID]              INT           NULL,
    [SkuID]                 INT           NULL,
    [SupplierID]            INT           NULL,
    [SupplierSize]          VARCHAR (20)  NULL,
    [SupplierColour]        VARCHAR (20)  NULL,
    [SourceParentIsDeleted] INT           DEFAULT ((0)) NULL,
    [TestRunDesc]           VARCHAR (100) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

