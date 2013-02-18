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

	/** PRODUCTS - http://docs.chargify.com/api-products **/

	public any function getProducts(){

		var service = createHTTPService("GET");

		service.setUrl(	getBaseUrl()
			& '/products.'
			& getReturnDataFormat());

		var response = call(service);

		return response;

	}

	/** SUBSCRIPTIONS **/

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

	/**
	 * @hint adds form fields from nested structures (2 deep) to an HTTP service. Format (name[name]=value) OR (name[name][name]=value), also adds parent level variables (name=value).
	 */
	private any function addParams(required any service, required struct params ){
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

}