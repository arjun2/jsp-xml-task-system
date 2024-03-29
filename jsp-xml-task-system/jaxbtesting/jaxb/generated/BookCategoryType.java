//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2012.01.02 at 01:12:50 AM EST 
//


package generated;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for bookCategoryType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="bookCategoryType">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="magazine"/>
 *     &lt;enumeration value="novel"/>
 *     &lt;enumeration value="fiction"/>
 *     &lt;enumeration value="other"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "bookCategoryType")
@XmlEnum
public enum BookCategoryType {

    @XmlEnumValue("magazine")
    MAGAZINE("magazine"),
    @XmlEnumValue("novel")
    NOVEL("novel"),
    @XmlEnumValue("fiction")
    FICTION("fiction"),
    @XmlEnumValue("other")
    OTHER("other");
    private final String value;

    BookCategoryType(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static BookCategoryType fromValue(String v) {
        for (BookCategoryType c: BookCategoryType.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
