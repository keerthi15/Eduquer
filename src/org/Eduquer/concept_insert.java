package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;


@WebServlet("/concept_insert")
public class concept_insert extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";


        try{

            String Domain = request.getParameter("domain");
            String Category = request.getParameter("category");
            String Content = request.getParameter("concept_text");


                Class.forName(driver).newInstance();
                conn = DriverManager.getConnection(url+dbName,"root", "");
                PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into concept(Concept, Domain, Category) values(?,?,?)");//try2 is the name of the table

               pst.setString(1,Content);

                pst.setString(2,Domain);
                pst.setString(3,Category);

                int i = pst.executeUpdate();
                System.out.println(Content);
                response.sendRedirect("add_concept.jsp");
                pst.close();




        }
        catch (Exception e){
            e.printStackTrace();
        }
    }


}
