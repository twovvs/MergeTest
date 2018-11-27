CREATE PROC [StoreHistory].[sp_STOREHISTORYItemSkuSupplier_Merge] AS
begin

	create table storehistory.NEW_ItemSkuSupplier with (DISTRIBUTION = ROUND_ROBIN)
	as 
	-- New Rows
	select
		  HASHPK		
		, HASHChange	
		, OptionID		
		, SkuID			
		, SupplierID	
		, SupplierSize	
		, SupplierColour
		, ETLStartDate-- = @ETLEndDate
		, ETLEndDate	= cast('2999-12-31' as datetime2(7))
	from store.ItemSkuSupplier
	except
	select
		  HASHPK		
		, HASHChange	
		, OptionID		
		, SkuID			
		, SupplierID	
		, SupplierSize	
		, SupplierColour
		, ETLStartDate --= @ETLEndDate
		, ETLStartDate	= cast('2999-12-31' as datetime2(7))
	from storehistory.ItemSkuSupplier
	
	union
	-- store history Changed Rows set to closed
	select
		  shss.HASHPK		
		, shss.HASHChange	
		, shss.OptionID		
		, shss.SkuID			
		, shss.SupplierID	
		, shss.SupplierSize	
		, shss.SupplierColour
		, shss.ETLStartDate
		, ETLEndDate = ss.ETLStartDate
	from 
			 storehistory.ItemSkuSupplier shss 
		join store.ItemSkuSupplier ss 
		  on	ss.HASHPK = shss.HASHPK 
			and ss.HASHChange != shss.HASHChange
			and shss.ETLEndDate > getdate()

	union
	-- Existing store rows, with no change
	select
		  shss.HASHPK		
		, shss.HASHChange	
		, shss.OptionID		
		, shss.SkuID			
		, shss.SupplierID	
		, shss.SupplierSize	
		, shss.SupplierColour
		, shss.ETLStartDate
		, shss.ETLEndDate
	from 
			 storehistory.ItemSkuSupplier shss
		join store.ItemSkuSupplier ss 
		  on(	ss.HASHPK = shss.HASHPK 
			and ss.HASHChange = shss.HASHChange )
			 or 
			(   ss.HASHPK = shss.HASHPK 
			and shss.ETLEndDate <= getdate() )

	union
	-- Close off deleted rows
	-- Make sure previous deleted records are brought through
	select
		  shss.HASHPK		
		, shss.HASHChange	
		, shss.OptionID		
		, shss.SkuID			
		, shss.SupplierID	
		, shss.SupplierSize	
		, shss.SupplierColour
		, shss.ETLStartDate
		, ETLEndDate = case when shss.etlenddate >= getdate()  then getdate() else shss.etlenddate end
	from 
			 storehistory.ItemSkuSupplier shss
	left join store.ItemSkuSupplier ss on  shss.hashpk = ss.hashpk
	where ss.hashpk is null


	begin
		drop table storehistory.ItemSkuSupplier
		RENAME OBJECT storehistory.NEW_ItemSkuSupplier TO ItemSkuSupplier;  
	end

end