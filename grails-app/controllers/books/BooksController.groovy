package books

import grails.converters.JSON
import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartFile

class BooksController {

    static allowedMethods = [index: 'GET', testPost: 'POST']

    List<Book> books = new ArrayList<>()

    def index() {
        render(view: "index")
    }

    def getDataForFirstTable() {
        Thread.sleep(3000)
        render(books as JSON)
    }

    def getDataForSecondTable() {
        Author author = new Author(id: 1, secondName: "Piterson", description: "great psychologist")
        Author author2 = new Author(id: 2, secondName: "Pushkin", description: "great arap")
        Author author3 = new Author(id: 3, secondName: "Pushkin3", description: "great arap3")
        List<Author> authors = [author, author2, author3]
//        for (int i = 3; i < 50; i++) {
//            authors.add(new Author(id: i, secondName: "Pushkin", description: "great arap"))
//        }

        render(authors as JSON)
    }

    def getFirstData() {
        print(params)
        Book book = new Book(id: 10, name: "Harry Potter", author: "Joan Rowling")
        JSON json = book as JSON
        render(json)
    }

    def addDataForFirstTable() {
        books.add(new Book(id: 777, name: "Generated Name", author: "Generated Author"))
    }

    def renderTablesDialog() {
        render(template: "tablesDialog")
    }

    def renderAddRelationshipDialog() {
        render(template: "addDependencyDialog")
    }

    def generateDataForFirstTable() {
        JSONObject json = request.getJSON()
        println(json)
        Book book = new Book(id: 10, name: "Harry Potter", author: "joan Rowling")
        Book book2 = new Book(id: 11, name: "Alladin", author: "Great Man")
        books.add(book)
        books.add(book2)
        render(status: 200)
    }

    def clearFirstTable() {
        books.clear()
        render(status: 200)
    }

    def upload() {

        List<CommonsMultipartFile> result2 = request.multipartFiles.collect {it.value}.flatten()
        MultipartFile file = request.getFile('myFile')
        if (file.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'uploadForm')
            return
        }

        byte[] bytes = file.getBytes()
        File outputFiule = new File("somepath")
        FileUtils.writeByteArrayToFile(outputFiule, bytes);

        response.sendError(200, 'Done')

    }

    def openDeleteDialog() {
        print(params)
        render(template: 'addDependencyDialog')
    }

    def openDraggable() {
        render(view: 'draggable')
    }

    def addDependencyDialog() {

        render(template: 'addDependencyDialog')
    }

    def exceptionHandler(final ValidationException exception) {
        print exception.getMessage()
        JSON json = ["exceptionMessage": exception.getMessage(),
                     "exceptionType"   : exception.class.toString()] as JSON
        render(json)
    }

    def demo() {

        render(view: 'demo')
    }

    def openUpload() {
        render(view: 'upload')
    }

    def testPost(){

        def param = params.id

        println 'inside testPost ' + param

        render(text: "sucess", contentType: "text/plain")

    }


}
