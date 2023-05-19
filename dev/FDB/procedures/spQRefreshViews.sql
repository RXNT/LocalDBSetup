SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE spQRefreshViews 
as 	
  begin 	
		set nocount on 	

		declare @Pass     int; 	
		declare @PassMax  int; 	
		declare @ViewName varchar(90); 	

		declare views_cursor cursor for 	
			select TABLE_NAME 	
			from INFORMATION_SCHEMA.VIEWS 	
			where TABLE_NAME not in ('sysconstraints', 'syssegments') 	
			and TABLE_SCHEMA = 'dbo' 	
			order by len(TABLE_NAME); 	
				
		set @PassMax = 9; 	

		set @Pass = 1; 	
		while @Pass <= @PassMax begin 	
			print 'Pass ' + cast(@Pass as varchar(10)); 	
			open views_cursor; 	
			fetch next from views_cursor into @ViewName; 	
			while @@FETCH_STATUS = 0 begin 	
				print 'sp_refreshview ' + @ViewName; 	
				exec sp_refreshview @ViewName; 	
				fetch next from views_cursor into @ViewName; 	
			end  	
			close views_cursor; 	
			set @Pass = @Pass + 1; 	
		end 	
		deallocate views_cursor; 	
  end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
