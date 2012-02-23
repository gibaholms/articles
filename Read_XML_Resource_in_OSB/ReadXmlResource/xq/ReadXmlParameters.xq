xquery version "1.0" encoding "Cp1252";
(:: pragma bea:schema-type-return type="ns0:Parameters" location="../xsd/Parameters.xsd" ::)

declare namespace xf = "http://tempuri.org/ReadXmlResource/xq/ReadXmlParameters/";
declare namespace ns0 = "http://gibaholms.wordpress.com/samples/xsd/2012/02/parameters";
declare namespace param = "http://gibaholms.wordpress.com/xpath/ReadXmlResource";

declare function xf:ReadXmlParameters() as element() {
    param:readXml("ReadXmlResource/xml/Parameters")
};


xf:ReadXmlParameters()
