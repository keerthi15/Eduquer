package org.Eduquer;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DBInsert
 */
@WebServlet("/DBInsert")
public class DBInsert extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";
        int count=0;
        PrintWriter out = response.getWriter();
        try{
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url+dbName,"root", "");
            count=0;
            String Uname = request.getParameter("username");
            String Emailid = request.getParameter("email");
            String phone_no = request.getParameter("phonenumber");
            String Password = request.getParameter("password");
            String confirmpass = request.getParameter("confirmpass");
            String SecurePasswordHash="";
            if(confirmpass.equals(Password)){
                SecurePassword sp = new SecurePassword();
                SecurePasswordHash = sp.getSecurePassword(Password);
                PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select * from users where Username = ? or Password=? or Email=?");
                st.setString(1,Uname);
                st.setString(2,SecurePasswordHash);
                st.setString(3,Emailid);
                ResultSet rs = st.executeQuery();
                while(rs.next()){
                    count++;
                }
                int i=0;
                if(count==0){
                    PreparedStatement pst =(PreparedStatement) conn.prepareStatement("insert into users(Username,Password,Email,Phone_number) values(?,?,?,?)");
                    System.out.println(Uname+" "+Password);
                    pst.setString(1,Uname);
                    pst.setString(2,SecurePasswordHash);
                    pst.setString(3,Emailid);
                    pst.setString(4,phone_no);

                    i = pst.executeUpdate();
                    response.sendRedirect("index.jsp");
                    pst.close();
                }
                if((count!=0)||(i!=1)){
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Signup Failed. Credentials already exist');");
                    out.println("location='signup.jsp';");
                    out.println("</script>");
                }


            }


        }
        catch (Exception e){
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Signup Failed. Credentials already exist');");
            out.println("location='signup.jsp';");
            out.println("</script>");
            e.printStackTrace();
        }

    }

}
