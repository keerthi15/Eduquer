<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 20-02-2019
  Time: 09:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*,java.sql.*"%>

<html>
<head>
    <title>Eduquer</title>
    <meta charset="UTF-8">
    <title>Eduquer_OTS</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <style>
        .name,designation{
            padding:3px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;
            font-family: Arial;
        }

        .alert-top{
            top: 60px;
            margin-left: auto;
            margin-right: auto;
            width: 80%;
        }
        body {
            padding-top: 54px;
            margin:auto;
        }
        @media (min-width: 992px) {
            body {
                padding-top: 56px;
            }
        }
        .dropdown-item{
            padding:10px;
        }
        .navbar{
            margin:auto;

        }

        .element{
            display:inline-block;

        }
        a{
            color:white;
        }
        a:hover{
            color:#5cb85c;
        }

    </style>
</head>
<%if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
session.setAttribute("complexity",1);
    int userid = (Integer)session.getAttribute("userid");
%>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

    <h1>   <a class="navbar-brand" href="student_home2.jsp" ><h5><b>EDUQUER</b></h5></a></h1>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">

            <li class="nav-item active dropdown" style="padding-right:20px;">
                <a class="nav-link dropdown-toggle" href="#" id="categoriesdrop" data-toggle="dropdown">
                    <b >Categories <i class="fas fa-list"></i></b>
                </a>
                <div class="dropdown-menu nav1">
                    <a class="dropdown-item" href='categories.jsp?category=Quantitative Aptitude'>Quantitative Aptitude</a>
                    <a class="dropdown-item" href='categories.jsp?category=Technical'>Technical</a>
                    <a class="dropdown-item" href='categories.jsp?category=Analytical'>Analytical</a>

                </div>
            </li>
            <li class="nav-item active dropdown" style="padding-right:65px;">
                <a class="nav-link dropdown-toggle" href="#" id="profiledrop" data-toggle="dropdown">
                    <b><%=(String)session.getAttribute("uname")%>&nbsp;<i class="fas fa-user-circle"></i></b>
                </a>
                <div class="dropdown-menu nav1">
                    <a tabindex="-4" class="dropdown-item" href="profile.jsp?UserID=<%=userid%>">View Profile</a>
                    <a tabindex="-4" class="dropdown-item" href="report.jsp?testname=null">Reports</a>
                    <a tabindex="-4" class="dropdown-item"  href="index.jsp"> <span style="color:black;"><i class="fa fa-sign-out-alt"></i></span> Logout </a>
                </div>

            </li>
        </ul>
    </div>

</nav>
<br>
<br>
<%

    int count=0;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
%>
<div class="container">
    <center><h3> TESTS AVAILABLE</h3></center>
    <br>
    <table class="table">
    <%try{
        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection(url+dbName,"root", "");

        PreparedStatement pst =(PreparedStatement)conn.prepareStatement("SELECT * from tests");
        int uid =(Integer)session.getAttribute("userid");
        ResultSet rs = pst.executeQuery();

        while(rs.next()){

            count=0;

            String testname =rs.getString("TestName");
            int testid = rs.getInt("TestID");
            int duration = rs.getInt("Duration");
            int days=(int)Math.floor(duration/(60*60*24));
            int hours=(int)Math.floor((duration%(60*60*24))/(60*60));
            int minutes=(int)Math.floor((duration%(60*60))/(60));
            int seconds=(int)Math.floor((duration%(60)));

            PreparedStatement st = (PreparedStatement)conn.prepareStatement("select * from report where TestID=? and UserID=?");
            st.setInt(1,testid);
            st.setInt(2,uid);
            ResultSet r= st.executeQuery();

            while(r.next()){
                count++;
            }
    %>

        <div class="test-detail" >
            <div class="details" >
                 <tr>
                     <td> <span class="element"> <h4><b> <p class="name"><%=testname%></p></b></h4></span></td>
                    <%
                        if(count==0){
                    %>
                     <td><span class="element"><h5>Duration => <%=hours%> : <%=minutes%> : <%=seconds%></h5></span></td>
                    <td><span class="element" style="float: right;"> <a href="instructions.jsp?testid=<%=testid%>"><button type="button" class="btn btn-success"><b>View Test&nbsp; <i class="fas fa-eye"></i></b></button></a></span></td>
                    <%
                    }
                    else if(count>0){
                    %>
                     <td><span class="element" style="color: red;"><h5>Test already taken</h5></span></td>
                            <td><span class="element"  > <a href="report.jsp?testname=<%=testname%>"><button type="button" class="btn btn-block"><b>View Report &nbsp; <i class="fas fa-eye"></i></b></button></a></span></td>
                    <%
                        }%>
                        </tr>

                </div>
            </div>
    <%
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    %>
    </table>
</div>
</body>
</html>
