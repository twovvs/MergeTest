CREATE PROC [store].[sp_STOREItemSkuSupplier_Merge] AS
begin

	create table store.NEW_ItemSkuSupplier with (DISTRIBUTION = ROUND_ROBIN)
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
		, ETLStartDate	= GETDATE()
	from clean.ItemSkuSupplier
	where HASHPK is not null
	except
	select
		  HASHPK		
		, HASHChange	
		, OptionID		
		, SkuID			
		, SupplierID	
		, SupplierSize	
		, SupplierColour
		, ETLStartDate		= GETDATE()
	from store.ItemSkuSupplier

	-- Changed Rows
	union
	select
		  cs.HASHPK		
		, cs.HASHChange	
		, cs.OptionID		
		, cs.SkuID			
		, cs.SupplierID	
		, cs.SupplierSize	
		, cs.SupplierColour
		, ETLStartDate		= GETDATE()
	from 
			 store.ItemSkuSupplier ss 
		join clean.ItemSkuSupplier cs 
		  on	ss.HASHPK = cs.HASHPK 
			and ss.HASHChange != cs.HASHChange

	-- Existing store rows, with no change, but are present in clean
	-- This will also ensure deletes are not brought through
	union
	select
		  ss.HASHPK		
		, ss.HASHChange	
		, ss.OptionID		
		, ss.SkuID			
		, ss.SupplierID	
		, ss.SupplierSize	
		, ss.SupplierColour
		, ss.ETLStartDate
	from 
			 store.ItemSkuSupplier ss 
		join clean.ItemSkuSupplier cs 
		  on	ss.HASHPK = cs.HASHPK 
			and ss.HASHChange = cs.HASHChange

	union
	-- Existing rows not in clean
	select
		  ss.HASHPK		
		, ss.HASHChange	
		, ss.OptionID		
		, ss.SkuID			
		, ss.SupplierID	
		, ss.SupplierSize	
		, ss.SupplierColour
		, ss.ETLStartDate
	from 
			 store.ItemSkuSupplier ss 
	where
		NOT EXISTS (Select cs.OptionID from clean.ItemSkuSupplier cs where cs.OptionID = ss.OptionID)

		
	begin
		drop table store.ItemSkuSupplier
		RENAME OBJECT store.NEW_ItemSkuSupplier TO ItemSkuSupplier;  
	end

end