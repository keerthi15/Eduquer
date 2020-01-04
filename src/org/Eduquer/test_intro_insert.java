package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/test_intro_insert")
public class test_intro_insert extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";

        try{

            String testName = request.getParameter("test_name");
            int hours=Integer.parseInt(request.getParameter("Hours"));
            int mins=Integer.parseInt(request.getParameter("Minutes"));
            int secs=Integer.parseInt(request.getParameter("Seconds"));
            int duration=((hours*60*60)+(mins*60)+secs);
            int marks = Integer.parseInt(request.getParameter("test_mark"));
            int noq = Integer.parseInt(request.getParameter("test_noq"));
            int tnoq = Integer.parseInt(request.getParameter("total_noq"));
            int auto_id=0;
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into tests(TestName,No_of_questions,Duration,Marks) values(?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
            pst.setString(1,testName);
            pst.setInt(2,noq);
            pst.setInt(3,duration);
            pst.setInt(4,marks);

            int returnLastInsertId = pst.executeUpdate();
            if(returnLastInsertId==1) {
                ResultSet rs = pst.getGeneratedKeys();
                rs.next();
                auto_id = rs.getInt(1);
            }

            HttpSession session=request.getSession();
            session.setAttribute("noq",tnoq);
            session.setAttribute("count",1);
            session.setAttribute("testId",auto_id);


            response.sendRedirect("add_testqun.jsp");

            pst.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
