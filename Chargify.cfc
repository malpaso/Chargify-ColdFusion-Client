component name="Chargify" output="false" accessors="true" hint="A ColdFusion wrapper for the Chargify API" {

	property type="string" 	name="service"				default="Chargify"	getter=true setter=true;
	property type="string"  name="apiKey"				default=""			getter=true setter=true;
	property type="string"  name="subdomain"			default=""			getter=true setter=true;
	property type="string" 	name="baseUrl"				default=""			getter=true setter=true;
	property type="string" 	name="username"				default=""			getter=true setter=true;
	property type="string" 	name="password"				default=""			getter=true setter=true;
	property type="string" 	name="returnDataFormat"		default="json"		getter=true setter=true;
	property type="boolean" name="debugMode"			default=false		getter=true setter=true;

	public any function init( required struct settings ){

		for( key in arguments.settings ){
			evaluate("set#key#('#arguments.settings[key]#')");
		}

		return this;
	}

	/** ADJUSTMENTS - http://docs.chargify.com/api-adjustments **/

	public any function createAdjustment(required any subscription_id, required struct adjustment){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/adjustments.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.adjustment);

		return call(service);

	}

	/** ALLOCATIONS - http://docs.chargify.com/api-allocations **/

	public any function getAllocations(required any subscription_id, required any component_id, string page=1){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#/allocations.'
			& getReturnDataFormat()
			& '?page=#arguments.page#');

		return call(service);

	}

	public any function createAllocation(required any subscription_id, required any component_id, required struct allocation){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#/allocations.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.allocation);

		return call(service);

	}

	/** CHARGES - http://docs.chargify.com/api-charges **/

	public any function createCharge(required any subscription_id, required struct charge){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/charges.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.charge);

		return call(service);

	}

	/** COMPONENTS - http://docs.chargify.com/api-components **/

	public any function getComponents(required any subscription_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getComponent(required any subscription_id, required any component_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getProductFamilyComponents(required any product_family_id, boolean include_archived=0){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/components.'
			& getReturnDataFormat()
			& '?include_archived=#arguments.include_archived#');

		return call(service);
	}

	public any function getProductFamilyComponent(required any product_family_id, required any component_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/components/#arguments.component_id#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function createProductFamilyComponent(required any product_family_id, required string plural_kind, required any component){

		var service = createHTTPService("POST");

		if( listFindNoCase("metered_components,quantity_based_components,on_off_components",arguments.plural_kind) EQ 0 ){
			throw(type=getService(),message="createProductFamilyComponent : plural_kind is INVALID",detail="PRODUCT_FAMILY_ID:#arguments.product_family_id# PLURAL_KIND:#arguments.plural_kind#");
		}

		service.setUrl( getBaseUrl()
			& '/product_families/#arguments.product_family_id#/#arguments.plural_kind#.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.component);

		return call(service);

	}

	/** COUPONS **/

	public any function createCoupon(required any coupon){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/coupons.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.coupon);

		return call(service);

	}

	public any function getCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		return call(service);

	}

	public any function updateCoupon(required any coupon_id, required struct coupon){

		var service = createHTTPService("PUT");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.coupon);

		return call(service);

	}

	public any function archiveCoupon(required any coupon_id){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		return call(service);

	}

	public any function validateCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#/validate.'
			& getReturnDataFormat() );

		return call(service);

	}

	public any function findCoupon(required any code){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/find.'
			& getReturnDataFormat()
			& '?code=#arguments.code#' );

		return call(service);

	}

	public any function usageCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#/usage.'
			& getReturnDataFormat() );

		return call(service);

	}

	/** CUSTOMERS - http://docs.chargify.com/api-customers **/

	public any function getCustomers(string page=1,string direction="asc"){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers.'
			& getReturnDataFormat()
			& '?page=#arguments.page#&direction=#arguments.direction#');

		return call(service);

	}

	public any function getCustomer(required any reference){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers/lookup.'
			& getReturnDataFormat()
			& '?reference=#arguments.reference#' );

		return call(service);

	}

	public any function createCustomer(required any customer){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/customers.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.customer);

		return call(service);

	}

	public any function updateCustomer(required any customer){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/customers/'
			& arguments.customer.id & '.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.customer);

		return call(service);

	}

	public any function deleteCustomer(required any id){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/customers/'
			& arguments.customer.id & '.'
			& getReturnDataFormat() );

		return call(service);

	}

	/** EVENTS - http://docs.chargify.com/api-events **/

	public any function getEvents(
		any page="",
		any per_page="",
		any since_id="",
		any max_id="",
		any direction=""
	){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/events.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments);

		return call(service);

	}

	public any function getSubscriptionEvents(
		required any subscription_id,
		any page="",
		any per_page="",
		any since_id="",
		any max_id="",
		any direction=""
	){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/events.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments,"subscription_id");

		return call(service);

	}

	/** METERED USAGE - http://docs.chargify.com/api-metered-usage **/

	/** MIGRATIONS - http://docs.chargify.com/api-migrations **/

	/** PRODUCTS - http://docs.chargify.com/api-products **/

	public any function getProducts(){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getProductFamilyProducts(required any product_family_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/products.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getProduct(required any product_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products/#arguments.product_id#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getProductByHandle(required any product_handle){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products/handle/#arguments.product_handle#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function createProduct(required any product){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/products.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.product);

		return call(service);

	}

	/** SUBSCRIPTIONS **/

	public any function getSubscriptions(any page="", any per_page=""){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments);

		return call(service);

	}

	public any function getSubscription(required any subscription_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function createSubscription(required any subscription){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.subscription);

		return call(service);

	}

	public any function updateSubscription(required any subscription){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription.id#.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.subscription);

		return call(service);

	}

	public any function deleteSubscription(required any subscription_id, string cancellation_message=""){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat() );

		service = addUrlParams(service,arguments,"subscription_id");

		return call(service);

	}

	public any function delayCancelSubscription(required any subscription_id, string cancel_at_end_of_period=1){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat() );

		service = addUrlParams(service,arguments,"subscription_id");

		return call(service);

	}

	public any function reactivateSubscription(
		required any subscription_id,
		any include_trial="",
		any preserve_balance="",
		string coupon_code=""
	){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription.id#/reactivate.'
			& getReturnDataFormat() );

		service = addUrlParams(service,arguments,"subscription_id");

		return call(service);

	}

	public any function resetBalanceSubscription(required any subscription_id){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription.id#/reset_balance.'
			& getReturnDataFormat() );

		return call(service);

	}

	public any function getCustomerSubscriptions(required any customer_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers/#arguments.customer_id#/subscriptions.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function addSubscriptionCoupon(required any subscription_id, required string coupon_code){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/add_coupon.'
			& getReturnDataFormat()
			& '?coupon_code=#arguments.coupon_code#' );

		return call(service);

	}

	public any function removeSubscriptionCoupon(required any subscription_id, required string coupon_code){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/remove_coupon.'
			& getReturnDataFormat()
			& '?coupon_code=#arguments.coupon_code#' );

		return call(service);

	}

	/** TRANSACTIONS - http://docs.chargify.com/api-transactions **/

	public any function getTransactions(
		array array_kinds=arrayNew(1),
		any since_id="",
		any max_id="",
		any since_date="",
		any until_date="",
		any page="",
		any per_page=""
	){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/transactions.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments,"array_kinds");

		return call(service);

	}

	public any function getTransaction(required any transaction_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/transactions/#arguments.transaction_id#.'
			& getReturnDataFormat());

		return call(service);

	}

	public any function getSubscriptionTransactions(
		required any subscription_id,
		array array_kinds=arrayNew(1),
		any since_id="",
		any max_id="",
		any since_date="",
		any until_date="",
		any page="",
		any per_page=""
	){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/transactions.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments,"subscription_id,array_kinds");

		return call(service);

	}

	/** PRIVATE **/

	private any function call(required any httpService){

		var result = arguments.httpService.send().getPrefix();

		// log while in development
		if( this.debugMode ){
			writeLog(type="information",file="Chargify",text=toString(result.fileContent));
		}

		if (NOT isDefined("result.statusCode")) {
			throw(type=getService(),errorcode="#getService()#_unresponsive", message="The #getService()# server did not respond.", detail="The #getService()# server did not respond.");
		}

		var response = createObject("component","ChargifyResponse").init( result, getReturnDataFormat() );

		return response; // deserializeJSON(result.fileContent);
	}

	private HTTP function createHTTPService(string urlmethod='POST', any httptimeout=30) {

		var service = new HTTP();
		service.setUsername(getUsername());
		service.setPassword(getPassword());
		service.setMethod(arguments.urlmethod);
		service.setCharset('utf-8');
		service.setTimeout(arguments.httptimeout);
		service.addParam(type="header",name="Content-Type",value="application/#getReturnDataFormat()#");
		service.addParam(type="header",name="mimetype",value="application/#getReturnDataFormat()#");

		return service;
	}
	
	private any function addParams( required any service, required struct params ){
		var s = arguments.service;
		var p = arguments.params;
		var debug = {};
		
		s.addParam( type="body", value=jsonencode(p) );
		
		return s;
	}

	/**
	 * @hint adds form fields from nested structures (2 deep) to an HTTP service. Format (name[name]=value) OR (name[name][name]=value), also adds parent level variables (name=value).
	 */
	private any function _addParams(required any service, required struct params ){
		var s = arguments.service;
		var p = arguments.params;
		var debug = {};

		for( key in p ){
			if( isStruct(p[key]) ){
				var f2 = p[key];
				for( k in f2 ){
					if( ! isStruct(f2[k]) ){
						s.addParam(
							type="formfield",
							name="#key#[#k#]",
							value=trim(f2[k])
						);
					}else{
						var f3 = f2[k];
						for( k2 in f3 ){
							if( ! isStruct(f3[k2]) ){
								s.addParam(
									type="formfield",
									name="#key#[#k#][#k2#]",
									value=trim(f3[k2])
								);
							}
						}
					}
				}
			}else{
				if( ! isStruct(p[key]) ){
					s.addParam(
						type="formfield",
						name=key,
						value=trim(p[key])
					);
				}
			}
		}

		return s;
	}

	private any function addUrlParams( required any service, required struct params, string exclude_list="" ){

		var s = arguments.service;
		var p = arguments.params;
		var e = arguments.exclude_list;

		for( key in p ){
			if( listFindNoCase(e,key) eq 0 AND len(p[key]) gt 0 ){
				s.addParam(
					type="url",
					name=key,
					value=trim(p[key])
				);
			}
			// check the exclude_list for prefixed 'array_' keys and add
			if( listFindNoCase(e,key) AND left(key,6) eq "array_" ){
				var _arr = p[key];
				var param_name = right(key,len(key)-6);
				// loop over the array and add the name value pairs to the service
				for( k=1;k<=arrayLen(_arr);k++){
					s.addParam(
						type="url",
						name="#param_name#[]",
						value=_arr[k]
					);
				}
			}
		}

		return s;
	}
	
	/**
	 * Serialize native ColdFusion objects (simple values, arrays, structures, queries) into JSON format
	 * http://json.org/
	 * http://jehiah.com/projects/cfjson/
	 *
	 * @param object Native data to be serialized
	 * @return Returns string with serialized data.
	 * @author Jehiah Czebotar (jehiah@gmail.com)
	 * @version 1.2, August 20, 2005
	 */

	public any function jsonencode(arg)
	{
		var i=0;
		var o="";
		var u="";
		var v="";
		var z="";
		var r="";

		if (isarray(arg))
		{
			o="";
			for (i=1;i lte arraylen(arg);i=i+1){
				try{
					v = jsonencode(arg[i]);
					if (o neq ""){
						o = o & ',';
					}
					o = o & v;
				}
				catch(Any ex){
					o=o;
				}
			}
			return '['& o &']';
		}
		if (isstruct(arg))
		{
			o = '';
			if (structisempty(arg)){
				return "{null}";
			}
			z = StructKeyArray(arg);
			for (i=1;i lte arrayLen(z);i=i+1){
				try{
				v = jsonencode(evaluate("arg."&z[i]));
				}catch(Any err){WriteOutput("caught an error when trying to evaluate z[i] where i="& i &" it evals to "  & z[i] );}
				if (o neq ""){
					o = o & ",";
				}
				o = o & '"'& lcase(z[i]) & '":' & v;
			} 
			return '{' & o & '}';
		}
		if (isobject(arg)){
			return "unknown";
		}
		if (issimplevalue(arg) and isnumeric(arg)){
			return ToString(arg);
		}
		if (issimplevalue(arg)){
			return '"' & JSStringFormat(ToString(arg)) & '"';
		}
		if (IsQuery(arg)){
			o = o & '"RECORDCOUNT":' & arg.recordcount;
			o = o & ',"COLUMNLIST":'&jsonencode(arg.columnlist);
			// do the data [].column
			o = o & ',"DATA":{';
			// loop through the columns
			for (i=1;i lte listlen(arg.columnlist);i=i+1){
				v = '';
				// loop throw the records
				for (z=1;z lte arg.recordcount;z=z+1){
					if (v neq ""){
						v =v  & ",";
					}
					// encode this cell
					v = v & jsonencode(evaluate("arg." & listgetat(arg.columnlist,i) & "["& z & "]"));
				}
				// put this column in the output
				if (i neq 1){
					o = o & ",";
				}
				o = o & '"' & listgetat(arg.columnlist,i) & '":[' & v & ']';
			}
			// close our data section
			o = o & '}';
			// put the query struct in the output
			return '{' & o & '}';
		}
		return "unknown";
	}

	public any function jsondecode(arg){

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