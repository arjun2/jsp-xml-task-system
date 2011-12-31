

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Validator;
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
            JAXBContext jaxbContext = JAXBContext.newInstance("test.jaxb");
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
                   new Boolean(true));
            Validator validator = jaxbContext.createValidator();

            ObjectFactory objFactory = new ObjectFactory();
            Collection collection= (Collection) objFactory.createCollection();

            Collection.BooksType booksType = objFactory.
                                  createCollectionTypeBooksType();
            List bookList = booksType.getBook();

            BookType book = objFactory.createBookType();
            book.setItemId("307");
            book.setName("JAXB today and beyond");
            book.setDescription("This is an intermediate book on JAXB");
            book.setISBN(987665L);
            book.setPrice("45$");
            book.setPublicationDate(new GregorianCalendar(2000,2,2));
            book.setBookCategory("other");

            BookType.PromotionType promotionType = objFactory.
                 createBookTypePromotionType();
            promotionType.setDiscount("5% off regular price");
            book.setPromotion(promotionType);
               
            BookType.AuthorsType authorsType = objFactory.
              createBookTypeAuthorsType();
            List authorList = authorsType.getAuthorName();
            authorList.add("Richard K");
            book.setAuthors(authorsType);

            bookList.add(book);       
            collection.setBooks(booksType);
            System.out.println("Validator returned " + 
               validator.validate(collection));
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