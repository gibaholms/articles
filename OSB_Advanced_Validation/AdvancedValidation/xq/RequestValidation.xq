(:: pragma bea:global-element-parameter parameter="$orderRequest" element="ns1:OrderRequest" location="../wsdl/OrderService-v1.wsdl" ::)
(:: pragma bea:schema-type-return type="ns0:Validation" location="../xsd/validation.xsd" ::)

declare namespace xf = "http://tempuri.org/AdvancedValidation/xq/RequestValidation/";
declare namespace ns1 = "http://gibaholms.wordpress.com/samples/wsdl/Order-v1.0";
declare namespace ns0 = "http://gibaholms.wordpress.com/samples/xsd/2011/11/validation";

declare function xf:RequestValidation($orderRequest as element(ns1:OrderRequest)) as element() {
	<ns0:Validation>
		<ns0:Payload>{$orderRequest/.}</ns0:Payload>
		<ns0:ValidationErrorList>{
			(: BEGIN - Required Field Validations :)
			if (empty($orderRequest/ns1:Customer/ns1:FirstName/text())) then
				<ns0:ValidationError>
					<ns0:code>1</ns0:code>
					<ns0:message>FirstName: Required Field</ns0:message>
				</ns0:ValidationError>
			else if (empty($orderRequest/ns1:Customer/ns1:DocumentNumber/text())) then
				<ns0:ValidationError>
					<ns0:code>2</ns0:code>
					<ns0:message>DocumentNumber: Required Field</ns0:message>
				</ns0:ValidationError>
			 else if (empty($orderRequest/ns1:Customer/ns1:Email/text())) then
				<ns0:ValidationError>
					<ns0:code>3</ns0:code>
					<ns0:message>Email: Required Field</ns0:message>
				</ns0:ValidationError>
			else if (empty($orderRequest/ns1:Customer/ns1:Age/text())) then
				<ns0:ValidationError>
					<ns0:code>4</ns0:code>
					<ns0:message>Age: Required Field</ns0:message>
				</ns0:ValidationError>
			else if (empty($orderRequest/ns1:Product/ns1:ProductID/text())) then
				<ns0:ValidationError>
					<ns0:code>5</ns0:code>
					<ns0:message>ProductID: Required Field</ns0:message>
				</ns0:ValidationError>
			else if (empty($orderRequest/ns1:Product/ns1:Quantity/text())) then
				<ns0:ValidationError>
					<ns0:code>6</ns0:code>
					<ns0:message>Quantity: Required Field</ns0:message>
				</ns0:ValidationError>
			(: END - Required Field Validations :)	
			
			else
			
			(: BEGIN - Field Specific Validations :)	
			if (not(matches($orderRequest/ns1:Customer/ns1:DocumentNumber/text(), '^[0-9]+$'))) then	 
				<ns0:ValidationError>
					<ns0:code>7</ns0:code>
					<ns0:message>DocumentNumber: Must Contain Only Numbers</ns0:message>
				</ns0:ValidationError> 
			else if (not(matches($orderRequest/ns1:Customer/ns1:Email/text(), '^[a-z0-9]+([\._-][a-z0-9]+)*@[a-z0-9_-]+(\.[a-z0-9]+){0,4}\.[a-z0-9]{1,4}$'))) then 
				<ns0:ValidationError>
					<ns0:code>8</ns0:code>
					<ns0:message>Email: Not a Valid Email Format</ns0:message>
				</ns0:ValidationError>
			else if (not(empty($orderRequest/ns1:Customer/ns1:Password/text())) 
				and $orderRequest/ns1:Customer/ns1:Password/text() != $orderRequest/ns1:Customer/ns1:PasswordConfirmation/text()) then
				<ns0:ValidationError>
					<ns0:code>9</ns0:code>
					<ns0:message>Password: Must Match PasswordConfirmation</ns0:message>
				</ns0:ValidationError>
			else if (not(empty($orderRequest/ns1:Product/ns1:ProductRestriction/text()))
				and $orderRequest/ns1:Product/ns1:ProductRestriction/text() = 'OVER18'
				and xs:int($orderRequest/ns1:Customer/ns1:Age/text()) < 18) then
				<ns0:ValidationError>
					<ns0:code>10</ns0:code>
					<ns0:message>Customer Must Be OVER 18 Years</ns0:message>
				</ns0:ValidationError>
			(: END - Field Specific Validations :)   
			 
			else ''
		}</ns0:ValidationErrorList>
	</ns0:Validation>
};

declare variable $orderRequest as element(ns1:OrderRequest) external;

xf:RequestValidation($orderRequest)
