package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/SaveAnswer1")
public class SaveAnswer1 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader ("Expires", 0);
        HttpSession session=request.getSession();
        int count=(Integer)session.getAttribute("count");
        int noq = (Integer)session.getAttribute("noq");
        int QuesID = Integer.parseInt(request.getParameter("QuestionID"));
        int testid =Integer.parseInt(request.getParameter("testid")) ;
        int userid =Integer.parseInt(request.getParameter("userid")) ;
        int complexity = Integer.parseInt(request.getParameter("complexity"));
        String option = "optradio"+QuesID;
        String ans = request.getParameter(option);
        String options;
        int totalmarks=0;
        System.out.println(ans);
        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        try {
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            System.out.println("SaveAnswer page");
            PreparedStatement st = (PreparedStatement) conn.prepareStatement("select * from report where TestID=? and UserID=?");
            st.setInt(1,testid);
            st.setInt(2,userid);
            ResultSet rs =st.executeQuery();
            options="";
            while(rs.next()){
                totalmarks=rs.getInt("Marks");
                options = rs.getString("Options");
                if(options.length()<=0)
                    options="";
            }

            options=options+ans+',';

            st = (PreparedStatement)conn.prepareStatement("update report set Options=? where TestID=? and UserID=?");
            st.setString(1,options);
            st.setInt(2,testid);
            st.setInt(3,userid);
           int i= st.executeUpdate();
            System.out.println(i);
            String answer="";
            int marks=0;

            st =(PreparedStatement)conn.prepareStatement("select *   from test_questions where QuestionID=?");
            st.setInt(1,QuesID);
            ResultSet ansrs= st.executeQuery();
            while(ansrs.next()){
                answer=ansrs.getString("Answer");
                marks =ansrs.getInt("Marks");
            }
            if(answer.compareToIgnoreCase(ans)==0){
                complexity++;
                totalmarks=totalmarks+marks;
            }
            else{
                complexity--;
            }
            st = (PreparedStatement)conn.prepareStatement("update report set Marks=? where TestID=? and UserID=?");
            st.setInt(1,totalmarks);
            st.setInt(2,testid);
            st.setInt(3,userid);
            i= st.executeUpdate();
            if(complexity>3){
                complexity=3;
            }
            else if(complexity<1){
                complexity=1;
            }
            count++;
            if(count>noq){
                session.setAttribute("complexity",1);
                response.sendRedirect("student_home2.jsp");
            }
            session.setAttribute("count",count);
            session.setAttribute("complexity",complexity);
            response.sendRedirect("testpage1.jsp?testid="+testid);
        }catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
