package org.Eduquer;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SideBar")
public class SideBar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn =null;
        String category = request.getParameter("category");
        String data="";
        System.out.println("category ="+category);
        PrintWriter out = response.getWriter();
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/eduquer","root","");
            PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select distinct DomainName from domains where category =?");
            pst.setString(1,category);
            ResultSet rs = pst.executeQuery();
            while(rs.next()){
                String domains = rs.getString("DomainName");
                data+=domains+"|";
            }
            System.out.println("data= "+data);
            pst.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        out.write(data);
        out.flush();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";

        PrintWriter out = response.getWriter();

        String data="";
        String category=request.getParameter("category");

        try{

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            PreparedStatement pst =(PreparedStatement) conn.prepareStatement("Select DISTINCT Domain from practice where Category=?");


            pst.setString(1,category);


            ResultSet rs = pst.executeQuery();
            while(rs.next()){

                String name=rs.getString("Domain");
                data+=name+"|";
            }

            pst.close();

        }
        catch (Exception e){
            e.printStackTrace();
        }
        out.write(data);
        out.flush();
    }
}
