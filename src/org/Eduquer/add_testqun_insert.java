package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/add_testqun_insert")
public class add_testqun_insert extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        int level =1;
        try{
            int testid=Integer.parseInt(request.getParameter("testId"));
            System.out.println(testid);
            int noq= Integer.parseInt(request.getParameter("noq"));
            int count= Integer.parseInt(request.getParameter("count"));
            int marks= Integer.parseInt(request.getParameter("marks"));
            String difficulty= request.getParameter("d_level");
            if(difficulty.compareToIgnoreCase("easy")==0){
                level=1;
            }
            else if(difficulty.compareToIgnoreCase("medium")==0){
                level=2;
            }
            else if(difficulty.compareToIgnoreCase("hard")==0){
                level =3;
            }

            String question = request.getParameter("quntext");
            String a=request.getParameter("option_a");
            String b=request.getParameter("option_b");
            String c=request.getParameter("option_c");
            String d=request.getParameter("option_d");

            System.out.println(a+" "+b+" "+c+" "+d);

            String answer = request.getParameter("Answer");

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into test_questions(`TestID`, `Question`, `Option A`,`Option B`, `Option C`, `Option D`, `Answer`, `Marks`, `Complexity`) values(?,?,?,?,?,?,?,?,?)");//try2 is the name of the table
            pst.setInt(1,testid);
            pst.setString(2,question);
            pst.setString(3,a);
            pst.setString(4,b);
            pst.setString(5,c);
            pst.setString(6,d);
            pst.setString(7,answer);
            pst.setInt(8,marks);
            pst.setInt(9,level);

            int i = pst.executeUpdate();
            if(i==1){
                HttpSession session=request.getSession();
                session.setAttribute("noq",noq);
                session.setAttribute("count",count+1);
                session.setAttribute("testId",testid);
            }
            if(count<noq){
                response.sendRedirect("add_testqun.jsp");
            }
            else
            {
                HttpSession session=request.getSession();
                session.setAttribute("noq","");
                session.setAttribute("count","");
                session.setAttribute("testId","");
                response.sendRedirect("add_test_intro.jsp");
            }
        }catch(Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
