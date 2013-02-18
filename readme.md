Chargify ColdFusion Client
==========================
Bill Tindal, 2013 (dbloh7@hotmail.com)

** work in progress **

This is a ColdFusion client for the Chargify billing API - http://docs.chargify.com/api-introduction

Example usage:

`<cfscript>`
	`settings = {`
		`apiKey = "",`
		`subdomain = "",`
		`baseUrl = "",`
		`username = "",`
		`password = "",`
		`returnDataFormat = "json"`
	`};`
	`chargify = createObject("component","Chargify").init(settings);`
	`// create a customer`
	`customer = {`
		`first_name = "",`
		`last_name = "",`
		`email = "",`
		`reference = "unique identifier in your app"`
	`};`
	`new_customer = chargify.createCustomer(customer);`
`</cfscript>`