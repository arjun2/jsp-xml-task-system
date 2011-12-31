

import generated.BookType;
import generated.BookType.Authors;
import generated.BookType.Promotion;
import generated.Collection;
import generated.Collection.Books;
import generated.ObjectFactory;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Validator;
import javax.xml.datatype.XMLGregorianCalendar;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.GregorianCalendar;



/** 
  * This shows how to use JAXB to create a content tree and populate it
  * and marshal to an xml file
  */

public class JAXBTest {

    public static void main (String args[]) {
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance("generated");
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
                   new Boolean(true));

            ObjectFactory objFactory = new ObjectFactory();
            Collection collection= (Collection) objFactory.createCollection();

            Books booksType = objFactory.
                                  createCollectionBooks();
            List bookList = booksType.getBook();

            BookType book = objFactory.createBookType();
            book.setItemId("307");
            book.setName("JAXB today and beyond");
            book.setDescription("This is an intermediate book on JAXB");
            book.setISBN(987665L);
            book.setPrice("45$");

            book.setBookCategory("other");

            Promotion promotionType = objFactory.
                 createBookTypePromotion();
            promotionType.setDiscount("5% off regular price");
            book.setPromotion(promotionType);
               
            Authors authorsType = objFactory.
              createBookTypeAuthors();
            List authorList = authorsType.getAuthorName();
            authorList.add("Richard K");
            book.setAuthors(authorsType);

            bookList.add(book);       
            collection.setBooks(booksType);

            System.out.println("Created a content tree " + 
               "and marshalled it to jaxbOutput2.xml");
            marshaller.marshal(collection,
                  new FileOutputStream("jaxbOutput2.xml"));
            System.out.println("See output in jaxbOutput2.xml " ) ;
     

       }catch (Exception e ) {
         e.printStackTrace();
       }
    }
}