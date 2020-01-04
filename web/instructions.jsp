<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 13-01-2019
  Time: 09:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*,java.util.*"%>
<html>
<head>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

    <title>Eduquer</title>


    <style>
        body {
            padding-top: 54px;
            margin:auto;
        }
    </style>
</head>
<%
if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
    int userid = (Integer)session.getAttribute("userid");
int testid=Integer.parseInt(request.getParameter("testid"));

    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
    PreparedStatement st= null;
    ResultSet rs=null,rq;
    long duration=0;
    int noq=0,marks=0;
    String complexity="Easy";
    Timestamp end=null;
    String testname="";
    try{
        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection(url+dbName,"root", "");
        st=conn.prepareStatement("Select * from tests where TestID=?");
        st.setInt(1, testid);

        rs=st.executeQuery();

        while(rs.next()){
            testname = rs.getString("TestName");
            marks=rs.getInt("Marks");
            duration= rs.getLong("Duration");
            noq=rs.getInt("No_of_questions");
        }


    }catch(SQLException e){
        e.printStackTrace();
    }
    session.setAttribute("count",1);
    session.setAttribute("noq",noq);
    int days=(int)Math.floor(duration/(60*60*24));
    int hours=(int)Math.floor((duration%(60*60*24))/(60*60));
    int minutes=(int)Math.floor((duration%(60*60))/(60));
    int seconds=(int)Math.floor((duration%(60)));

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
                    <a tabindex="-4" class="dropdown-item" href="report.jsp">Reports</a>
                    <a tabindex="-4" class="dropdown-item"  href="index.jsp"> <span style="color:black;"><i class="fa fa-sign-out-alt"></i></span> Logout </a>
                </div>

            </li>
        </ul>
    </div>

</nav>
<br>
<br>
<br>
<h2><center>Instruction to the test</center> </h2>

<div style="margin-left: 20px;">  <br>
    <b> Test Name:<span style="margin-left: 10px;"><%=testname%></span><br>
        Duration:<span style="margin-left: 20px;"><%=days%> Days <%=hours%> Hours <%=minutes%> Minutes <%=seconds%> Seconds </span><br>
        Marks:<span style="margin-left: 35px;"><%=marks%></span><br>
        Number of question:<span style="margin-left: 10px;"></span>5
        <br><br>
        <br>

        READ THE INSTRUCTIONS CAREFULLY.<br>
    </b>
    <ul>
        <li> Check your internet connection and power before taking the test.</li>
        <li>Once the test has started, on power failure or internet connection failure, you might not be able to retake the test.</li>
        <li> This test can be taken only once.</li>
        <li>Once you click on the Take Test button, the timer starts running.</li>
        <li>Do not refresh the page. If you do so, your answers will not be stored properly</li>
        <li>You can click on the End button to end the test before you consume the entire time duration.</li>
    </ul>
</div>
<center><a href="testpage1.jsp?testid=<%=testid%>"><button type="button" class="btn btn-success">Take test <i class="fas fa-edit"></i></button></a></center>
</body>
</html>
