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
import java.sql.ResultSet;

@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";

        PrintWriter out = response.getWriter();

        boolean result=false;
        String equals="";
        int userid = Integer.parseInt(request.getParameter("UserID"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phonenumber");
        String password = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmpass");
        SecurePassword sp = new SecurePassword();
        int updationResult=0;
        try{
            Class.forName(driver);
            conn = DriverManager.getConnection(url+dbName,"root","");
            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select Password from users where Userid=?");
            pst.setInt(1,userid);
            ResultSet rs = pst.executeQuery();
            while(rs.next()){

                String dbpass = rs.getString("Password");

                result = sp.validatePassword(password,dbpass);
            }
            if(result){
                if(newPassword==null && confirmPass==null){
                    pst = (PreparedStatement)conn.prepareStatement("Update users set Username=? , Email=? , Phone_number =? where Userid=? ");
                    pst.setString(1,username);
                    pst.setString(2,email);
                    pst.setString(3,phoneNo);
                    pst.setInt(4,userid);
                    updationResult = pst.executeUpdate();
                }
                else if(newPassword.equals(confirmPass)){
                    System.out.println(newPassword);
                    String newPassHash = sp.getSecurePassword(newPassword);
                    pst = (PreparedStatement)conn.prepareStatement("Update users set Username=? , Email=? , Phone_number =?, Password=? where Userid=? ");
                    pst.setString(1,username);
                    pst.setString(2,email);
                    pst.setString(3,phoneNo);
                    pst.setString(4,newPassHash);
                    pst.setInt(5,userid);
                    updationResult = pst.executeUpdate();

                }

            }
            if(result==false){
                updationResult=-1;
            }
            if(updationResult==0){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updation Failed. Invalid Data');");
                out.println("location='profile.jsp?UserID="+userid+"';");
                out.println("</script>");

            }
            if(updationResult==1){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updated Successfully.');");
                out.println("location='profile.jsp?UserID="+userid+"';");
                out.println("</script>");

            }

            if(updationResult==-1){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Updation failed. Wrong password');");
                out.println("location='profile.jsp?UserID="+userid+"';");
                out.println("</script>");

            }

            pst.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        out.write(equals);
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
