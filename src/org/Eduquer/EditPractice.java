package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/EditPractice")
public class EditPractice extends HttpServlet {
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

            int PracticeID = Integer.parseInt(request.getParameter("QuestionID"));
            String question = request.getParameter("PracticeQuestion");
            String optionA = request.getParameter("A");
            String optionB = request.getParameter("B");
            String optionC = request.getParameter("C");
            String optionD = request.getParameter("D");
            String answer = request.getParameter("Answer");


            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("UPDATE `practice` SET `Question`=?, `A`=?, `B`=?, `C`=?, `D`=?, `Answer`=? WHERE Question_ID=?");
            pst.setString(1,question);
            pst.setString(2,optionA);
            pst.setString(3,optionB);
            pst.setString(4,optionC);
            pst.setString(5,optionD);
            pst.setString(6,answer);
            pst.setInt(7,PracticeID);
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
