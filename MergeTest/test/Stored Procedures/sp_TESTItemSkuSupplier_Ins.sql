CREATE PROC [test].[sp_TESTItemSkuSupplier_Ins] AS
begin
	truncate table test.ItemSkuSupplier 

	-- 1. Inital rows
	insert into test.ItemSkuSupplier values (1, 1234, 9999, 1, 'Small','Green', 0, 'Inital Rows')
	insert into test.ItemSkuSupplier values (1, 1234, 9999, 2, 'Small','Yellow', 0, 'Inital Rows')
	insert into test.ItemSkuSupplier values (1, 1234, 9000, 1, 'Small','Green', 0, 'Inital Rows')
	-- Additional Item with no change
	insert into test.ItemSkuSupplier values (1, 1333, 7000, 1, 'Small','Green', 0, 'Inital Rows')
	insert into test.ItemSkuSupplier values (1, 1333, 9000, 1, 'Small','Green', 0, 'Inital Rows')

	-- 2. New Rows
	insert into test.ItemSkuSupplier values (2, 1234, 9999, 1, 'Small','Green'	, 0, 'No Change')
	insert into test.ItemSkuSupplier values (2, 1234, 9999, 2, 'Small','Yellow'	, 0, 'No Change')
	insert into test.ItemSkuSupplier values (2, 1234, 9999, 3, 'Medium','Red'	, 0, 'New Row')
	insert into test.ItemSkuSupplier values (2, 1234, 9000, 1, 'Small','Green'	, 0, 'No Change')
	insert into test.ItemSkuSupplier values (2, 1234, 9000, 4, 'Large','Black'	, 0, 'New Row')

	-- 3. Update Records
	insert into test.ItemSkuSupplier values (3, 1234, 9999, 1, 'Small','Pink', 0, 'Update Green -> Pink')
	insert into test.ItemSkuSupplier values (3, 1234, 9999, 2, 'Small','Yellow', 0, 'No Change')
	insert into test.ItemSkuSupplier values (3, 1234, 9999, 3, 'Medium','Red', 0, 'No Change')
	insert into test.ItemSkuSupplier values (3, 1234, 9000, 1, 'Small','Pink', 0, 'Update Green -> Pink')
	insert into test.ItemSkuSupplier values (3, 1234, 9000, 4, 'Large','Black', 0, 'No Change')

	-- 4. Delete Record
	insert into test.ItemSkuSupplier values (4, 1234, 9999, 1, 'Small','Pink', 0, 'No Change')
	--insert into test.ItemSkuSupplier values (4, 1234, 9999, 2, 'Small','Yellow',0,  'Inital Rows')
	insert into test.ItemSkuSupplier values (4, 1234, 9999, 3, 'Medium','Blue', 0, 'Update Red -> Blue')
	insert into test.ItemSkuSupplier values (4, 1234, 9000, 1, 'Small','Pink', 0, 'No Change')
	insert into test.ItemSkuSupplier values (4, 1234, 9000, 4, 'Large','Black', 0, 'No Change')

	-- 5. Re-Insert Record
	insert into test.ItemSkuSupplier values (5, 1234, 9999, 1, 'Small','Pink', 0, 'No Change')
	insert into test.ItemSkuSupplier values (5, 1234, 9999, 2, 'Small','Yellow', 0, 'New Row, but seen before')
	insert into test.ItemSkuSupplier values (5, 1234, 9999, 3, 'Medium','Red', 0, 'Update Blue -> Red reverting')
	insert into test.ItemSkuSupplier values (5, 1234, 9000, 1, 'Small','Pink', 0, 'No Change')
	insert into test.ItemSkuSupplier values (5, 1234, 9000, 4, 'Large','Black', 0, 'No Change')

	-- 6. Re-Delete Record
	insert into test.ItemSkuSupplier values (6, 1234, 9999, 1, 'Small','Pink', 0, 'No Change')
	--insert into test.ItemSkuSupplier values (6, 1234, 9999, 2, 'Small','Yellow', 0, 'Inital Rows')
	insert into test.ItemSkuSupplier values (6, 1234, 9999, 3, 'Medium','Red', 0, 'No Change')
	insert into test.ItemSkuSupplier values (6, 1234, 9000, 1, 'Small','Pink', 0, 'No Change')
	insert into test.ItemSkuSupplier values (6, 1234, 9000, 4, 'Large','Black', 0, 'No Change')

	-- 7. Delete Option
	insert into test.ItemSkuSupplier values (7, 1234, 9999, 1, 'Small','Pink', 0, 'No Change')
	insert into test.ItemSkuSupplier values (7, 1234, 9999, 3, 'Medium','Red', 0, 'No Change')

	-- 8. Delete Item
	insert into test.ItemSkuSupplier values (8, 1234, null, null, null, null, 1, 'Delete Item 1234')
end