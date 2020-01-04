package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/EditConcepts")
public class EditConcepts extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        int count=0;
        PrintWriter out = response.getWriter();

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/eduquer","root","");

            int ConceptID = Integer.parseInt(request.getParameter("ConceptID"));
            String Concept = request.getParameter("Concept");


            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("UPDATE `concept` SET `Concept`=? WHERE Concept_ID=?");
            pst.setString(1,Concept);
            pst.setInt(2,ConceptID);
            int result = pst.executeUpdate();

            if(result==1){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated successfully');");
                out.println("location='admin_home.jsp'");
                out.println("</script>");
            }
            else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updation failed');");
                out.println("location='admin_home.jsp'");
                out.println("</script>");
            }


        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
