package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;


@WebServlet("/practice_insert")
public class practice_insert extends HttpServlet {
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
            String question = request.getParameter("practice_quntext");
            String a=request.getParameter("option_a");
            String b=request.getParameter("option_b");
            String c=request.getParameter("option_c");
            String d=request.getParameter("option_d");
            String answer=request.getParameter("practice_answer");



            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into practice(Question, A, B, C, D, Answer, Domain, Category) values(?,?,?,?,?,?,?,?)");//try2 is the name of the table

            pst.setString(1,question);
            pst.setString(2,a);
            pst.setString(3,b);
            pst.setString(4,c);
            pst.setString(5,d);
            pst.setString(6,answer);
            pst.setString(7,Domain);
            pst.setString(8,Category);

            int i = pst.executeUpdate();
            System.out.println(answer);
            response.sendRedirect("add_practice.jsp");
            pst.close();




        }
        catch (Exception e){
            e.printStackTrace();
        }
    }


}

