(:: pragma type="soap-env:Header" ::)

declare namespace xf = "http://tempuri.org/xq/AssignSiebelHeaderToken";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace sieb = "http://siebel.com/webservices";

declare function xf:AssignSiebelHeaderToken($token as xs:string) as element() {
	<soap-env:Header>
		<sieb:SessionType>Stateless</sieb:SessionType>
		<sieb:SessionToken>{$token}</sieb:SessionToken>
	</soap-env:Header>
};

declare variable $token as xs:string external;

xf:AssignSiebelHeaderToken($token)
