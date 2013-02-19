component name="Chargify" output="false" accessors="true" hint="A ColdFusion wrapper for the Chargify API" {

	property type="string" 	name="service"				default="Chargify";
	property type="string"  name="apiKey"				default="";
	property type="string"  name="subdomain"			default="";
	property type="string" 	name="baseUrl"				default="";
	property type="string" 	name="username"				default="";
	property type="string" 	name="password"				default="";
	property type="string" 	name="returnDataFormat"		default="json";
	property type="boolean" name="debugMode"			default=false;

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

		var response = call(service);

		return response;

	}

	/** ALLOCATIONS - http://docs.chargify.com/api-allocations **/

	public any function getAllocations(required any subscription_id, required any component_id, string page=1){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#/allocations.'
			& getReturnDataFormat()
			& '?page=#arguments.page#');

		var response = call(service);

		return response;

	}

	public any function createAllocation(required any subscription_id, required any component_id, required struct allocation){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#/allocations.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.allocation);

		var response = call(service);

		return response;

	}

	/** CHARGES - http://docs.chargify.com/api-charges **/

	public any function createCharge(required any subscription_id, required struct charge){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/charges.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.charge);

		var response = call(service);

		return response;

	}

	/** COMPONENTS - http://docs.chargify.com/api-components **/

	public any function getComponents(required any subscription_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function getComponent(required any subscription_id, required any component_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/components/#arguments.component_id#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function getProductFamilyComponents(required any product_family_id, boolean include_archived=0){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/components.'
			& getReturnDataFormat()
			& '?include_archived=#arguments.include_archived#');

		var response = call(service);

		return response;
	}

	public any function getProductFamilyComponent(required any product_family_id, required any component_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/components/#arguments.component_id#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

	}

	/** COUPONS **/

	public any function createCoupon(required any coupon){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/coupons.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.coupon);

		var response = call(service);

		return response;

	}

	public any function getCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

	}

	public any function updateCoupon(required any coupon_id, required struct coupon){

		var service = createHTTPService("PUT");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.coupon);

		var response = call(service);

		return response;

	}

	public any function archiveCoupon(required any coupon_id){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/coupons/#arguments.coupon_id#.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

	}

	public any function validateCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#/validate.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

	}

	public any function findCoupon(required any code){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/find.'
			& getReturnDataFormat()
			& '?code=#arguments.code#' );

		var response = call(service);

		return response;

	}

	public any function usageCoupon(required any coupon_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/coupons/#arguments.coupon_id#/usage.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

	}

	/** CUSTOMERS - http://docs.chargify.com/api-customers **/

	public any function getCustomers(string page=1,string direction="asc"){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers.'
			& getReturnDataFormat()
			& '?page=#arguments.page#&direction=#arguments.direction#');

		var response = call(service);

		return response;

	}

	public any function getCustomer(required any reference){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers/lookup.'
			& getReturnDataFormat()
			& '?reference=#arguments.reference#' );

		var response = call(service);

		return response;

	}

	public any function createCustomer(required any customer){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/customers.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.customer);

		var response = call(service);

		return response;

	}

	public any function updateCustomer(required any customer){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/customers/'
			& arguments.customer.id & '.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.customer);

		var response = call(service);

		return response;

	}

	public any function deleteCustomer(required any id){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/customers/'
			& arguments.customer.id & '.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

	}

	/** METERED USAGE - http://docs.chargify.com/api-metered-usage **/

	/** MIGRATIONS - http://docs.chargify.com/api-migrations **/

	/** PRODUCTS - http://docs.chargify.com/api-products **/

	public any function getProducts(){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function getProductFamilyProducts(required any product_family_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/product_families/#arguments.product_family_id#/products.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function getProduct(required any product_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products/#arguments.product_id#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function getProductByHandle(required any product_handle){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products/handle/#arguments.product_handle#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function createProduct(required any product){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/products.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.product);

		var response = call(service);

		return response;

	}

	/** SUBSCRIPTIONS **/

	public any function getSubscriptions(any page="", any per_page=""){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions.'
			& getReturnDataFormat());

		service = addUrlParams(service,arguments);

		var response = call(service);

		return response;

	}

	public any function getSubscription(required any subscription_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function createSubscription(required any subscription){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.subscription);

		var response = call(service);

		return response;

	}

	public any function updateSubscription(required any subscription){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription.id#.'
			& getReturnDataFormat() );

		service = addParams(service,arguments.subscription);

		var response = call(service);

		return response;

	}

	public any function deleteSubscription(required any subscription_id, string cancellation_message=""){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat() );

		service = addUrlParams(service,arguments,"subscription_id");

		var response = call(service);

		return response;

	}

	public any function delayCancelSubscription(required any subscription_id, string cancel_at_end_of_period=1){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#.'
			& getReturnDataFormat() );

		service = addUrlParams(service,arguments,"subscription_id");

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

	}

	public any function resetBalanceSubscription(required any subscription_id){

		var service = createHTTPService("PUT");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription.id#/reset_balance.'
			& getReturnDataFormat() );

		var response = call(service);

		return response;

	}

	public any function getCustomerSubscriptions(required any customer_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/customers/#arguments.customer_id#/subscriptions.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	public any function addSubscriptionCoupon(required any subscription_id, required string coupon_code){

		var service = createHTTPService("POST");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/add_coupon.'
			& getReturnDataFormat()
			& '?coupon_code=#arguments.coupon_code#' );

		var response = call(service);

		return response;

	}

	public any function removeSubscriptionCoupon(required any subscription_id, required string coupon_code){

		var service = createHTTPService("DELETE");

		service.setUrl( getBaseUrl()
			& '/subscriptions/#arguments.subscription_id#/remove_coupon.'
			& getReturnDataFormat()
			& '?coupon_code=#arguments.coupon_code#' );

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

	}

	public any function getTransaction(required any transaction_id){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/transactions/#arguments.transaction_id#.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

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

		var response = call(service);

		return response;

	}

	/** PRIVATE **/

	private any function call(required any httpService){

		var result = arguments.httpService.send().getPrefix();

		// log while in development
		writeLog(type="information",file="Chargify",text=toString(result.fileContent));

		if (NOT isDefined("result.statusCode")) {
			throw(type=getService(),errorcode="#getService()#_unresponsive", message="The #getService()# server did not respond.", detail="The #getService()# server did not respond.");
		}

		return toString(result.fileContent);
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

	private any function jsonencode(arg)
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

}