SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientMismatchInfoHtml] 
(  
	@RxNTPatientFirstName VARCHAR(50),
    @PatientFirstName VARCHAR(50),
    @RxNTPatientLastName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @RxNTPatientDOB DATETIME,
    @PatientDOB DATETIME,
    @PatientMiddleName VARCHAR(50),
    @PatientGender VARCHAR(1),
    @PatientAddressLine1 VARCHAR(100),
    @PatientAddressLine2 VARCHAR(100)=NULL,
    @PatientCity VARCHAR(100),
    @PatientState VARCHAR(50),
    @PatientZipCode VARCHAR(50),
    @PatientPhone VARCHAR(50)
) 
	RETURNS VARCHAR(MAX)
	BEGIN 
		DECLARE @Info VARCHAR(MAX)= '<table>';
		
		SET @RxNTPatientFirstName=ISNULL(@RxNTPatientFirstName,'')
		SET @PatientFirstName=ISNULL(@PatientFirstName,'')
		SET @RxNTPatientLastName = ISNULL(@RxNTPatientLastName,'')
		SET @PatientLastName = ISNULL(@PatientLastName,'')
		SET @RxNTPatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
		SET @PatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
		IF LOWER(@RxNTPatientFirstName)!= LOWER(@PatientFirstName)
		BEGIN
			SET @Info = @Info+'<tr><td><div id=''mismatched''><label>First Name:</label></div></td>  <td><div id=''mismatched''> '+@PatientFirstName+'</div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>First Name:</label></div></td>  <td> <div> '+@PatientFirstName+' </div></td></tr>'
		END
		
		IF LOWER(@RxNTPatientLastName) != LOWER(@PatientLastName)
		BEGIN
			SET @Info = @Info+ '<tr><td><div id=''mismatched''><label>Last Name:</label></div></td>  <td> <div id=''mismatched''>'+@PatientLastName+' </div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>Last Name:</label> </div></td>  <td><div>'+@PatientLastName+'</div></td></tr>'
		END

    

		IF LEN(@PatientMiddleName)>0
			SET @Info = @Info+ '<tr><td><div><label>Middle Name:</label> </div></td>  <td><div>'+@PatientMiddleName+'</div></td></tr>'

		IF CONVERT(VARCHAR(20),@RxNTPatientDOB,101) != CONVERT(VARCHAR(20),@PatientDOB,101) 
		BEGIN 
			SET @Info = @Info+ '<tr><td><div id=''mismatched''><label>DateOfBirth:</label></div></td>  <td> <div id=''mismatched''>'+CONVERT(VARCHAR(20),@PatientDOB,101)+'</div></td></tr>'
		END
		ELSE
		BEGIN
			SET @Info = @Info+ '<tr><td><div><label>DateOfBirth:</label></div></td>  <td><div> '+CONVERT(VARCHAR(20),@PatientDOB,101)+' </div></td></tr>';
		END
		SET @Info = @Info+ '<tr><td><div><label>Sex:</label></div></td>  <td><div> '+@PatientGender+' </div></td></tr>'
		IF LEN(@PatientAddressLine1)>0
			SET @Info = @Info+ '<tr><td><div><label>Address1:</label> </div></td>  <td><div>'+@PatientAddressLine1+' </div></td></tr>'
		IF LEN(@PatientCity)>0
			SET @Info = @Info+ '<tr><td><div><label>City:</label> </div></td>  <td><div>'+@PatientCity+'</div></td></tr>'
		IF LEN(@PatientState)>0
			SET @Info = @Info+ '<tr><td><div><label>State:</label> </div></td>  <td><div>'+@PatientState+'</div></td></tr>'
		IF LEN(@PatientZipCode)>0
			SET @Info = @Info+ '<tr><td><div><label>ZipCode:</label></div></td>  <td><div>'+@PatientZipCode+'</div></td></tr>'
		IF LEN(@PatientAddressLine2)>0
			SET @Info = @Info+ '<tr><td><div><label>Address2:</label> </div></td>  <td><div>'+@PatientAddressLine2+' </div></td></tr>'

		IF LEN(@PatientPhone)>0
			SET @Info = @Info+ '<tr><td><div><label>Phone:</label> </div></td>  <td><div>'+@PatientPhone+' </div></td></tr>'
                       
		SET @Info = @Info+ '</table>';
		RETURN  @Info
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
