CREATE TABLE [clean].[ItemSkuSupplier] (
    [HASHPK]                VARBINARY (8000) NULL,
    [HASHChange]            VARBINARY (8000) NULL,
    [OptionID]              INT              NULL,
    [SkuID]                 INT              NULL,
    [SupplierID]            INT              NULL,
    [SupplierSize]          VARCHAR (20)     NULL,
    [SupplierColour]        VARCHAR (20)     NULL,
    [SourceParentIsDeleted] INT              DEFAULT ((0)) NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

