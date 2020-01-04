package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;

@WebServlet("/EditTestQuestion")
public class EditTestQuestion extends HttpServlet {
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
            int testId = Integer.parseInt(request.getParameter("TestID"));
            int questionId = Integer.parseInt(request.getParameter("QuestionID"));
            String question = request.getParameter("Question");
            String optionA = request.getParameter("Option A");
            String optionB = request.getParameter("Option B");
            String optionC = request.getParameter("Option C");
            String optionD = request.getParameter("Option D");
            String answer = request.getParameter("Answer");
            int marks = Integer.parseInt(request.getParameter("Marks"));
            String difficulty = request.getParameter("Difficulty");
            int complexity=1;
            if(difficulty.equals("Easy")){
                complexity=1;
            }
            else if(difficulty.equals("Medium")){
                complexity=2;
            }
            else if(difficulty.equals("Hard")){
                complexity=3;
            }

            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Update test_questions set Question=?, `Option A`=?, `Option B`=? , `Option C`=?, `Option D`=?, Marks=?, Answer=?, Complexity=? where TestID=? and QuestionID=?");
            pst.setString(1,question);
            pst.setString(2,optionA);
            pst.setString(3,optionB);
            pst.setString(4,optionC);
            pst.setString(5,optionD);
            pst.setInt(6,marks);
            pst.setString(7,answer);
            pst.setInt(8,complexity);
            pst.setInt(9,testId);
            pst.setInt(10,questionId);

            int result = pst.executeUpdate();
            if(result==1){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated successfully');");
                out.println("location='editTestQuestions.jsp?TestID="+testId+"'");
                out.println("</script>");
            }
            else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updation failed');");
                out.println("location='editTestQuestions.jsp?TestID="+testId+"'");
                out.println("</script>");
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
