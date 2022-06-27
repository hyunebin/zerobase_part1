package DateBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnection {

    public static Connection getConnection(){
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\qortj\\Desktop\\SQLiteStudio\\info");
            System.out.println("DBConnection Success");

        }catch (Exception e){
            e.printStackTrace();
        }

        return connection;
    }


}
