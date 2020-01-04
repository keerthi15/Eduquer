package org.Eduquer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import java.io.*;


@WebServlet("/ReportSideBar")
public class ReportSideBar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn=null;
        String url="jdbc:mysql://localhost/";
        String dbName="eduquer";
        String driver="com.mysql.jdbc.Driver";

        PrintWriter out = response.getWriter();
        String data="";
        String testid=request.getParameter("testid");
        String[] id=testid.split(",");
        int [] test= new int [id.length];
        for(int i=0;i<id.length;i++) {
            test[i] = Integer.parseInt(id[i]);
            try {

                Class.forName(driver).newInstance();
                conn = DriverManager.getConnection(url + dbName, "root", "");
                PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select TestName from tests where TestID=?");//try2 is the name of the table

                pst.setInt(1, test[i]);


                ResultSet rs = pst.executeQuery();
                while (rs.next()) {

                    String name = rs.getString("TestName");
                    data += name + "|";
                }


                pst.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        out.write(data);
        out.flush();


    }
}
