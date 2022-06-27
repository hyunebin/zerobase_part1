package com.example.zerobase_part1;

import DateBase.DBConnection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/delete.jsp")
public class deleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int a = Integer.parseInt(req.getParameter("idx"));
        Connection connection = DBConnection.getConnection();

        String delete = "Delete from History where ID=" + a;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(delete);
            preparedStatement.execute();

            resp.sendRedirect("history.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            if (connection !=null){
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
