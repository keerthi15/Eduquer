package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/Login")
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        PrintWriter out = response.getWriter();
        try{

            String Uname = request.getParameter("username");

            String Password = request.getParameter("password");
            int flag=0;

                Class.forName(driver).newInstance();

                conn = DriverManager.getConnection(url+dbName,"root", "");
                String storedHash="";
                PreparedStatement pst =(PreparedStatement) conn.prepareStatement("Select * from users where Username=?");//try2 is the name of the table

                pst.setString(1,Uname);



                ResultSet rs = pst.executeQuery();

                while(rs.next()) {
                    storedHash = rs.getString("Password");

                    SecurePassword sp = new SecurePassword();

                    boolean matched = sp.validatePassword(Password, storedHash);

                    if(matched){

                        int admin = rs.getInt("Admin");

                        int uid = rs.getInt("userid");

                        if (admin == 0) {

                            flag = 1;



                            HttpSession session = request.getSession();
                            session.setAttribute("uname", Uname);
                            session.setAttribute("admin", 0);
                            session.setAttribute("userid", uid);
                            session.setAttribute("complexity", 1);
                            response.sendRedirect("student_home2.jsp");

                        } else if (admin == 1) {

                            flag = 1;

                            HttpSession session = request.getSession();
                            session.setAttribute("uname", Uname);
                            session.setAttribute("admin", 1);
                            session.setAttribute("userid", uid);
                            response.sendRedirect("admin_home.jsp");

                        }
                    }
            }
                if(flag==0){

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Login Failed. Invalid Credentials');");
                    out.println("location='index.jsp';");
                    out.println("</script>");

                }

                pst.close();


        }
        catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
