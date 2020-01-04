package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/EditTest")
public class EditTest extends HttpServlet {
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

            int TestID = Integer.parseInt(request.getParameter("TestId"));
            String TestName = request.getParameter("TestName");
            int noq = Integer.parseInt(request.getParameter("NOQ"));
            int marks = Integer.parseInt(request.getParameter("Marks"));
            int hours = Integer.parseInt(request.getParameter("Hours"));
            int minutes = Integer.parseInt(request.getParameter("Minutes"));
            int seconds = Integer.parseInt(request.getParameter("Seconds"));
            int duration=((hours*60*60)+(minutes*60)+seconds);

            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("UPDATE `tests` SET `TestName`=?,`No_of_questions`=?,`Duration`=?,`Marks`=? WHERE TestID=?");
            pst.setString(1,TestName);
            pst.setInt(2,noq);
            pst.setInt(3,duration);
            pst.setInt(4,marks);
            pst.setInt(5,TestID);
            int result = pst.executeUpdate();

            if(result==1){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated successfully');");
                out.println("location='editTest.jsp?TestID="+TestID+"'");
                out.println("</script>");
            }
            else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updation failed');");
                out.println("location='editTest.jsp?TestID="+TestID+"'");
                out.println("</script>");
            }


        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
