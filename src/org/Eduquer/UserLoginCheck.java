package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/UserLoginCheck")
public class UserLoginCheck extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("hello");

        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        String dataString="";

        PrintWriter out = response.getWriter();


        try{
            System.out.println("in here");


            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            PreparedStatement pst =(PreparedStatement) conn.prepareStatement("Select Userid,Username from users");//try2 is the name of the table

            System.out.println("connected");

            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                int i=rs.getInt("Userid");
                String name=rs.getString("Username");
                dataString+=i+"|"+name+"||";
            }
            System.out.println(dataString);

            pst.close();



        }
        catch (Exception e){
            e.printStackTrace();
        }
        out.write(dataString);
        out.flush();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
