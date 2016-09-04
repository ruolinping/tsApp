
create PROCEDURE SelectItemType
AS
BEGIN TRY
	BEGIN
		BEGIN TRANSACTION
			select * from tblItemType
		COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH 

        ROLLBACK TRANSACTION
    
END CATCH;
GO

EXEC SelectItemType
GO


alter PROCEDURE SelectItem
AS
BEGIN TRY
	BEGIN
		BEGIN TRANSACTION
			select ItemType, [ItemNumber],[ItemDescription],PrePrice, 
			CAST(
             CASE 
                  WHEN [ItemUnits] is null
				                       THEN ' '
                  ELSE  concat(cast([ItemUnits] as varchar(50)), 'x', cast([ItemWeights] as varchar(50)) , ' oz' ) 
             END AS varchar(50))  AS SIZE 
			from tblItem
		COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH 

        ROLLBACK TRANSACTION
    
END CATCH;
GO

EXEC SelectItem
GO

use TropicalServer

alter PROCEDURE SelectCustomersOrders
AS

  select  o.OrderID,ISNULL(o.[OrderTrackingNumber],'N/A') as OrderTrackingNumber, 
  CONVERT(VARCHAR(24),o.[OrderDate],101) OrderDates, o.[OrderCustomerNumber], 
  c.CustName, CONCAT(c.CustBillingAddress1, ' ', c.CustBillingAddress2) Address,
   ISNULL( cast(o.[OrderRouteNumber] as varchar(20)),' ') as OrderRouteNumber
    FROM [TropicalServer].[dbo].[tblOrder] o
	inner join [TropicalServer].[dbo].tblCustomer c
	on c.[CustNumber] = o.OrderCustomerNumber
	inner join [dbo].[tblCustRoute] r
	on r.[CustRouteNumber] = o.[OrderRouteNumber]

use TropicalServer

alter proc  UpdateRowOrders(@id varchar(15), @trackNo varchar(50), @date varchar(50))
as
update tblOrder
set OrderTrackingNumber=@trackNo, tblOrder.OrderDate = cast(@date as datetime)
where OrderID=cast(@id as int)

cast('1')
alter PROCEDURE SelectSalesManager
AS

  select distinct r.CustRouteRep
    FROM [dbo].[tblCustRoute] r

use TropicalServer
alter PROCEDURE GetOrdersOnOrderDate(@s varchar(50))
AS
declare @beforeDate datetime
declare @now datetime
set @now = GETDATE()
set @beforeDate =
	CASE @s 
		when 'Today' then @now
		when 'Last7Days' then dateadd(day,-7,@now)
		when 'Last1Month' then DATEADD(month,-1,@now)
		when 'Last6Month' then DATEADD(month,-6,@now)
	end

  select o.OrderID, ISNULL(o.[OrderTrackingNumber],'N/A') as OrderTrackingNumber, 
  CONVERT(VARCHAR(24),o.[OrderDate],103) OrderDates, o.[OrderCustomerNumber], 
  c.CustName, CONCAT(c.CustBillingAddress1, ' ', c.CustBillingAddress2) Address,
   ISNULL( cast(o.[OrderRouteNumber] as varchar(20)),' ') as OrderRouteNumber
    FROM [TropicalServer].[dbo].[tblOrder] o
	inner join [TropicalServer].[dbo].tblCustomer c
	on c.[CustNumber] = o.OrderCustomerNumber
	where o.[OrderDate] > @beforeDate

	
alter PROCEDURE GetOrdersOnOrderDate(@s varchar(50))
as
	DECLARE @DateVariable datetime;	
	DECLARE @SQLString nvarchar(4000);  
	DECLARE @ParmDefinition nvarchar(4000); 
	declare @beforeDate datetime
	declare @now datetime
	set @now = GETDATE()
	set @beforeDate =
	CASE @s 
		when 'Today' then @now
		when 'Last7Days' then dateadd(day,-7,@now)
		when 'Last1Month' then DATEADD(month,-1,@now)
		when 'Last6Month' then DATEADD(month,-6,@now)
	end
	set @SQLString = N'select o.OrderID, ISNULL(o.[OrderTrackingNumber],' + +char(39)+ 'N/A' +char(39)+') as OrderTrackingNumber, 
  CONVERT(VARCHAR(24),o.[OrderDate],103) OrderDates, o.[OrderCustomerNumber], 
  c.CustName, CONCAT(c.CustBillingAddress1, ' +char(39)+ ' ' +char(39)+', c.CustBillingAddress2) Address,
   ISNULL( cast(o.[OrderRouteNumber] as varchar(20)),' + +char(39)+ 'N/A' +char(39)+') as OrderRouteNumber
    FROM [TropicalServer].[dbo].[tblOrder] o
	inner join [TropicalServer].[dbo].tblCustomer c
	on c.CustID = o.OrderCustomerNumber
	where o.[OrderDate] > @beforeOrderDate';
	SET @ParmDefinition = N'@beforeOrderDate datetime';  
	SET @DateVariable = @beforeDate;  
	EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @beforeOrderDate = @DateVariable;  

GetOrdersOnOrderDate 'Last6Month'
	
use TropicalServer

create proc  DeleteRow(@id varchar(15))
as
DELETE FROM tblOrder
where OrderID=cast(@id as int)

create PROCEDURE GetOrdersOnCID(@s varchar(50))
as	
	declare @thisid int;
	DECLARE @SQLString nvarchar(4000);  
	DECLARE @ParmDefinition nvarchar(4000); 
	set @SQLString = N'select o.OrderID, ISNULL(o.[OrderTrackingNumber],' + +char(39)+ 'N/A' +char(39)+') as OrderTrackingNumber, 
  CONVERT(VARCHAR(24),o.[OrderDate],103) OrderDates, o.[OrderCustomerNumber], 
  c.CustName, CONCAT(c.CustBillingAddress1, ' +char(39)+ ' ' +char(39)+', c.CustBillingAddress2) Address,
   ISNULL( cast(o.[OrderRouteNumber] as varchar(20)),' + +char(39)+ 'N/A' +char(39)+') as OrderRouteNumber
    FROM [TropicalServer].[dbo].[tblOrder] o
	inner join [TropicalServer].[dbo].tblCustomer c
	on c.CustID = o.OrderCustomerNumber
	where c.[CustNumber] = @cid';
	SET @ParmDefinition = N'@cid int';  
	SET @thisid =cast(@s as int);  
	EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @cid = @thisid;
				
					  
alter PROCEDURE filter(@date varchar(50),@id varchar(50), @name varchar(50), @rep varchar(50))
as
	DECLARE @DateVariable datetime;
	declare @idVariable int;
	declare @nameVariable varchar(50);
	declare  @repVariable varchar(50);	
	DECLARE @SQLString nvarchar(4000);  
	DECLARE @ParmDefinition nvarchar(4000); 
	declare @beforeDate datetime
	declare @now datetime
	set @now = GETDATE();
	set @beforeDate =
	CASE @date
		when 'Today' then @now
		when 'Last7Days' then dateadd(day,-7,@now)
		when 'Last1Month' then DATEADD(month,-1,@now)
		when 'Last6Month' then DATEADD(month,-6,@now)
		Else null
	end
	if @id = ''
	set @id = null
	if @name = ''
	set @name = null
	if @rep = ''
	set @rep = null
	set @SQLString = N'select o.OrderID, ISNULL(o.[OrderTrackingNumber],' + +char(39)+ 'N/A' +char(39)+') as OrderTrackingNumber, 
  CONVERT(VARCHAR(24),o.[OrderDate],101) OrderDates, o.[OrderCustomerNumber], 
  c.CustName, CONCAT(c.CustBillingAddress1, ' +char(39)+ ' ' +char(39)+', c.CustBillingAddress2) Address,
   ISNULL( cast(o.[OrderRouteNumber] as varchar(20)),' + +char(39)+ 'N/A' +char(39)+') as OrderRouteNumber, r.[CustRouteRep]
    FROM [TropicalServer].[dbo].[tblOrder] o
	inner join [TropicalServer].[dbo].tblCustomer c
	on c.[CustNumber] = o.OrderCustomerNumber
	inner join [dbo].[tblCustRoute] r
	on r.[CustRouteNumber] = o.[OrderRouteNumber]
	where (@beforeOrderDate is null or o.[OrderDate] > @beforeOrderDate)
	and (@cid is null  or o.OrderCustomerNumber = @cid)
	and (@cname is null or c.CustName = @cname) 
	and (@repName is null or r.[CustRouteRep] = @repName)';
	SET @ParmDefinition = N'@beforeOrderDate datetime, @cid varchar(50), @cname varchar(50), @repname varchar(50)';  
	SET @DateVariable = @beforeDate;  
	set @idVariable = @id;
	set @nameVariable = @name;
	set @repVariable = @rep;
	EXECUTE sp_executesql @SQLString, @ParmDefinition,  
                      @beforeOrderDate = @DateVariable, @cid = @idVariable,
					   @cname = @nameVariable, @repName = @repVariable;  


use TropicalServer
alter PROCEDURE GetAutoComplete(@type varchar(50),@word varchar(50))
AS
declare @likeWord varchar(50);
set @likeWord = '%' + @word + '%';
if @type ='CustNum'
select distinct [CustNumber] from tblCustomer
where CustNumber like @likeWord
Else
select distinct tblCustomer.CustName from tblCustomer
where CustName like @likeWord


use TropicalServer
create PROCEDURE GetItemsandCustomers(@syncDate datetime)
AS
begin
select * from tblCustomer
where SyncDate <= @syncDate or SyncDate is null
select * from tblItem
where SyncDate <= @syncDate or SyncDate is null
end

CREATE type customerType as table (
	[CustID] [int] IDENTITY(1,1) NOT NULL,
	[CustNumber] [int] NULL,
	[CustName] [varchar](100) NULL,
	[CustOfficeAddress1] [varchar](100) NULL,
	[CustOfficeAddress2] [varchar](100) NULL,
	[CustOfficeCity] [varchar](50) NULL,
	[CustOfficeState] [varchar](2) NULL,
	[CustOfficeZip] [int] NULL,
	[CustPhoneNumber] [varchar](50) NULL,
	[CustFaxNumber] [varchar](50) NULL,
	[CustRouteNumber] [int] NULL,
	[CustSalesRepNumber] [int] NULL,
	[CustOrderEntryContactName] [varchar](100) NULL,
	[CustPromoGroup] [int] NULL,
	[CustPriceGroup] [int] NULL,
	[CustPaymentTermsCode] [int] NULL,
	[CustPaymentType] [int] NULL,
	[CustBillingAddress1] [varchar](100) NULL,
	[CustBillingAddress2] [varchar](100) NULL,
	[CustBillingCity] [varchar](100) NULL,
	[CustBillingState] [varchar](2) NULL,
	[CustBillingZip] [int] NULL,
	[CustRouteVisitWeekDay] [varchar](10) NULL,
	[CustSequence] [int] NULL)
 

use TropicalTablet
 CREATE PROCEDURE [dbo].[InsertTableTblCustomer]
    @mycustomerType customerType readonly
AS
BEGIN
    insert into [dbo].[tblCustomer] 
	([CustNumber]
      ,[CustName]
      ,[CustOfficeAddress1]
      ,[CustOfficeAddress2]
      ,[CustOfficeCity]
      ,[CustOfficeState]
      ,[CustOfficeZip]
      ,[CustPhoneNumber]
      ,[CustFaxNumber]
      ,[CustRouteNumber]
      ,[CustSalesRepNumber]
      ,[CustOrderEntryContactName]
      ,[CustPromoGroup]
      ,[CustPriceGroup]
      ,[CustPaymentTermsCode]
      ,[CustPaymentType]
      ,[CustBillingAddress1]
      ,[CustBillingAddress2]
      ,[CustBillingCity]
      ,[CustBillingState]
      ,[CustBillingZip]
      ,[CustRouteVisitWeekDay]
      ,[CustSequence])
	select [CustNumber]
      ,[CustName]
      ,[CustOfficeAddress1]
      ,[CustOfficeAddress2]
      ,[CustOfficeCity]
      ,[CustOfficeState]
      ,[CustOfficeZip]
      ,[CustPhoneNumber]
      ,[CustFaxNumber]
      ,[CustRouteNumber]
      ,[CustSalesRepNumber]
      ,[CustOrderEntryContactName]
      ,[CustPromoGroup]
      ,[CustPriceGroup]
      ,[CustPaymentTermsCode]
      ,[CustPaymentType]
      ,[CustBillingAddress1]
      ,[CustBillingAddress2]
      ,[CustBillingCity]
      ,[CustBillingState]
      ,[CustBillingZip]
      ,[CustRouteVisitWeekDay]
      ,[CustSequence] from @mycustomerType 
END

