component name="ChargifyResponse" accessors="true" output="false" hint="A container object for Chargify responses" {

	property type="any" name="httpObject" default="" getter=true setter=true;
	property type="any" name="response" default="" getter=true setter=true;

	public any function init( required any response, responseFormat="json" ){

		setHttpObject(arguments.response);

		if( arguments.responseFormat eq "xml" ){
			// TODO
		}else{
			setResponse( deserializeJSON(body()) );
		}

		return this;
	}

	public any function headers(){
		return getHttpObject().responseHeader;
	}

	public any function body(){
		return getHttpObject().fileContent;
	}

	public any function statusCode(){
		return getHttpObject().statusCode;
	}

	// error handling

	public boolean function hasErrors(){
		if( left(statusCode(),3) gt 201 ){
			return true;
		}
		return false;
	}

	public any function getError(){
		var error = {
			code = "",
			message = "",
			errors = arrayNew(1)
		};
		if( hasErrors() ){
			switch( left(statusCode(),3) ){
				case "401":
					error["code"] = "401";
					error["message"] = "Not Authorized";
					break;
				case "404":
					error["code"] = "404";
					error["message"] = "Not Found";
					break;
				case "422":
					error["code"] = "422";
					error["message"] = "Unprocessable Entity";
					errors = getResponse().errors;
					break;
				case "500":
					error["code"] = "500";
					error["message"] = "Internal Server Error";
					break;
			}
		}
		return error;
	}

}