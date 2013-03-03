component name="ChargifyResponse" output="false" hint="A container object for Chargify responses" {

	property type="any" name="httpObject" default=structNew();
	property type="any" name="response" default=structNew();

	public any function init( required any response, responseFormat="json" ){

		setHttpObject(arguments.response);

		if( arguments.responseFormat eq "xml" ){
			// later
		}else{
			setResponse(jsondecode(body()));
		}
	}

	public any function headers(){
		return getResponseObject().responseHeader;
	}

	public any function body(){
		return getResponseObject().fileContent;
	}

	public any function statusCode(){
		return getResponseObject().statusCode;
	}

	// error handling

	public boolean function hasErrors(){
		if( statusCode() gt 201 ){
			return true;
		}
		return false;
	}

	// utility functions

	private any function jsondecode(arg){

		var z=1;//where to start slicing
		var s=0;//stack of tokens passed
		var i=0;// for counter
		var k="";//temp key
		var t="";//temp string
		var split=0;//position of split :
		var o = StructNew();
		var v = arraynew(1);
		var inq=0; // used when checking for ',' to see if we are in a quoted string or not.

		arg = trim(arg);

		if (not IsNumeric(arg) and arg is "true")
			return true;
		else if (not IsNumeric(arg) and (arg is "false"))
			return false;


		switch("#LCase(arg)#"){
			case '""':
			case "''":
				return "";
			case 'null':
				return "null";

			default:
			//numeric
			if (IsNumeric(arg)){
				//numeric
				return LSParseNumber(arg);
			}else if (arg is "true"){
				return true;
			}else if (ReFind('^".+"$',arg,0) is 1 or ReFind("^'.+'$",arg,0) is 1){
				//string
				return replace(mid(arg,2,len(arg)-2),'\"','"',"All");
			}else if (ReFind("^\[.*\]$",arg,0) is 1){
				//array
				// get rid of delims
				arg = mid(arg,2,len(arg)-2);
				// for each one

				for (i=1;i lte len(arg)+1;i=i+1){
					if (mid(arg,i,1) is '"'){
						if (inq is 1){
							inq=0;
						}
						else {
							inq =1;
						}

					}
					else if (mid(arg,i,1) is "\" and inq is 1){
						i= i+1;//skip the escaped character
					}
					else if ((mid(arg,i,1) is "," and  s is 0 and inq is 0) or i is len(arg)+1){
						// we found a comma, or the end
	// the commented code here would possibly deal with empty array elements
	//					if (i-z gt 0)
							arrayappend(v,jsondecode(mid(arg,z,i-z)));
	//					else
	//						arrayappend(v,"");

						z=i+1;//move the start forward
					} else if ("{[" contains mid(arg,i,1) and inq is 0){
						s=s+1;//track if we are moving into a subexpression
					} else if ("}]" contains mid(arg,i,1) and inq is 0){
						s=s-1;//track if we are moving out of a subexpression
					}
				}

				return v;
			}else if (ReFind("^\{.*\}$",arg,0) is 1){
				if (not arg contains ":")
					return "arg contains no : " & arg;
				//struct
				// get rid of delims
				arg = mid(arg,2,len(arg)-2);



				for (i=1;i lte len(arg)+1;i=i+1){
	//				WriteOutput("checking struct character "&i&"->" & mid(arg,i,1)&"<br>");
					if (mid(arg,i,1) is '"'){
						if (inq is 1){
							inq=0;
						}
						else {
							inq =1;
						}
					}
					else if (mid(arg,i,1) is "\" and inq is 1){
						i= i+1;//skip the escaped character
					}
					else if ((mid(arg,i,1) is "," and s is 0 and inq is 0) or i is len(arg)+1){
						// we found a comma, or the end

	// the commented code here would possibly deal with empty array elements
	//					if (i-z gt 0)
							// split on :
							t = mid(arg,z,i-z);
							split=find(":",t);
							if (split is 0){
								return t;
								//return": not found in ->" & t & " with z="&z &" and split="&split&" and i ="&i & " and k="&mid(t,1,split) &" when second half is ->" &mid(t,split+1,len(t)-split);
							}else{
								k=trim(mid(t,1,split-1));
								// if the key is quoted, remove the stinkin quotes
								if (mid(k,1,1) is "'" or mid(k,1,1) is '"')
									k=mid(k,2,len(k)-2);

								r=mid(t,split+1,len(t)-split);
								StructInsert(o,k,jsondecode(r));
							}
							//arrayappend(v,jsondecode(mid(arg,z,i-z)));
	//					else
	//						arrayappend(v,"");

						z=i+1;//move the start forward
					} else if ("{[" contains mid(arg,i,1) and inq is 0){
						s=s+1;//track if we are moving into a subexpression
					} else if ("}]" contains mid(arg,i,1) and inq is 0){
						s=s-1;//track if we are moving out of a subexpression
					}
				}
				return o;
			}
			else{
				//? - if this happens, just go home ;-)
				return "unknown:"&arg;
			}

		}
		return "unknown2:"&arg;
	}

}