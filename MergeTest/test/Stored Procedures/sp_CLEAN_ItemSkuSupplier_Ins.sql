CREATE PROC [test].[sp_CLEAN_ItemSkuSupplier_Ins] @TestRunID [int] AS
begin
	truncate table clean.ItemSkuSupplier
	insert into clean.ItemSkuSupplier
	select 
		  HASHPK = hashbytes('SHA1', cast(OptionID as varchar)+':'+cast(SkuID as varchar)+':'+cast(SupplierID as varchar)) 
		, HASHChange = hashbytes('SHA1', cast(SupplierSize as varchar)+':'+cast(SupplierColour as varchar)) 
		, OptionID		
		, SkuID			
		, SupplierID	
		, SupplierSize	
		, SupplierColour
		, SourceParentIsDeleted
	from test.ItemSkuSupplier tis
	where
		TestRunID = @TestRunID
end