package attachments

import grls.app.Attachment
import groovy.sql.Sql
import org.hibernate.Session
import org.hibernate.SessionFactory

import javax.sql.DataSource
import java.sql.Blob
import java.sql.Connection
import java.sql.PreparedStatement
import java.sql.ResultSet
import java.sql.Statement

class AttachmentsController {
    SessionFactory sessionFactory
    DataSource dataSource
//        new Attachment(id: 1, filename: 'from').save(flush: true, failOnError: true, validate: true)


    def index() {
        Blob
        SocketException

//        Session session = sessionFactory.openSession()
        Connection connection = dataSource.getConnection()

        String sql = 'select * from attachment order by id'
        Statement statement = connection.createStatement()

        ResultSet rs = statement.executeQuery(sql)

        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("filename");
            System.out.println(id + "  " + name);
        }

        render(view: 'index', status: 200)
    }

//    def index() {
//
//        Sql sql = new Sql(dataSource)
//
//        String select = 'select * from Attachment'
//
//        def result = sql.query(select, { resultSet -> return resultSet })
//
//        render(view: 'index', status: 200)
//    }


//    def index() {
//        Session session = sessionFactory.openSession()
//        session.beginTransaction()
//
//        Attachment attachment = (Attachment) session.get(Attachment.class, Long.valueOf(2))
//
//        session.getTransaction().commit()
//        session.close()
//
//        render(view: 'index', status: 200)
//    }
}
