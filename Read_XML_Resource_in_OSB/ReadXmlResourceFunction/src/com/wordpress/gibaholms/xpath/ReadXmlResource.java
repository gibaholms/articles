package com.wordpress.gibaholms.xpath;

import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlObject;

import com.bea.wli.config.Ref;
import com.bea.wli.config.component.NotFoundException;
import com.bea.wli.sb.resources.config.XmlEntryDocument;
import com.bea.wli.sb.resources.xml.XmlRepository;

public class ReadXmlResource {

	public static XmlObject readXml(String xmlRefPath) {
		Ref ref = new com.bea.wli.config.Ref("XML", Ref.getNames(xmlRefPath));
		XmlObject xmlObject = null;
		try {
			XmlEntryDocument xmlEntryDocument = XmlRepository.get().getEntry(ref);
			String xmlContent = xmlEntryDocument.getXmlEntry().getXmlContent();
			xmlObject = XmlObject.Factory.parse(xmlContent);
		} catch (NotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("XML Resource not found.");
		} catch (XmlException e) {
			e.printStackTrace();
			throw new RuntimeException("Error parsing XML content.", e);
		}
		return xmlObject;
	}
	
}
