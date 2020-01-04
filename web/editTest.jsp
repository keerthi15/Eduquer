<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 03-03-2019
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*,java.sql.*"%>
<html>
<head>
    <title>Eduquer</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <style>



        .designation{
            padding:3px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;
            font-family: Arial;
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

    </style>
</head>

<body>
<%if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
    int userid = (Integer)session.getAttribute("userid");
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

    <h1>   <a class="navbar-brand" href="admin_home.jsp" ><h5><b>EDUQUER</b></h5></a></h1>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">

            <li class="nav-item active dropdown" style="padding-right:20px;">
                <a class="nav-link dropdown-toggle" href="#" id="materialsdrop" data-toggle="dropdown">
                    <b >Add Materials <i class="fas fa-list"></i></b>
                </a>
                <div class="dropdown-menu nav1">
                    <a class="dropdown-item" href='add_concept.jsp'>Concepts</a>
                    <a class="dropdown-item" href='add_practice.jsp'>Practice</a>
                </div>
            </li>
            <li class="nav-item active " style="padding-right:20px;">
                <a class="nav-link " href="add_test_intro.jsp" id="createtest" >
                    <b >Create New Test <i class="fas fa-edit"></i></b>
                </a>
            </li>
            <li class="nav-item active dropdown" style="padding-right:65px;">
                <a class="nav-link dropdown-toggle" href="#" id="profiledrop" data-toggle="dropdown">
                    <b><%=(String)session.getAttribute("uname")%>&nbsp;<i class="fas fa-user-circle"></i></b>
                </a>
                <div class="dropdown-menu nav1">
                    <a tabindex="-4" class="dropdown-item" href="profile.jsp?UserID=<%=userid%>">View User Profile</a>
                    <a tabindex="-4" class="dropdown-item"  href="index.jsp"> <span style="color:black;"><i class="fa fa-sign-out-alt"></i></span> Logout </a>
                </div>

            </li>
        </ul>
    </div>
</nav>
<br>
<br>
<br>
<%
    int count=0;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
    int testid= Integer.parseInt(request.getParameter("TestID"));
    Class.forName(driver);
    conn = DriverManager.getConnection(url+dbName, "root","");
    PreparedStatement stm =(PreparedStatement)conn.prepareStatement("Select TestName from tests where TestID=?");
    stm.setInt(1,testid);
    ResultSet r =stm.executeQuery();
%>
<div class="container">
            <div id="details" class="container tab-pane active">
                <%
                    while(r.next()){
                %>
                <h4 class="text-center"><%=r.getString("TestName")%></h4></center>
                <%
                    }
                %>
            <form name="editForm" action="EditTest" method="post">
                <input type="hidden" name ="TestId" id ="TestId" value="<%=testid%>"/>

                <div class="container"><br>
                <h5>Test Details</h5>

                <table class="table table-bordered text-center" id="domainsTable">

                    <tbody>
                    <%
                        try{

                            PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select * from tests where TestID=?");
                            st.setInt(1,testid);
                            ResultSet rs = st.executeQuery();
                            while (rs.next()){
                                int duration = rs.getInt("Duration");
                                int days=(int)Math.floor(duration/(60*60*24));
                                int hours=(int)Math.floor((duration%(60*60*24))/(60*60));
                                int minutes=(int)Math.floor((duration%(60*60))/(60));
                                int seconds=(int)Math.floor((duration%(60)));

                    %>
                    <tr><td><b>Test Name</b></td><td><input type="text" name ="TestName" value="<%=rs.getString("TestName")%>"/></td>
                    </tr>
                    <tr><td><b>No of Questions</b></td><td><input type="text" name ="NOQ" value="<%=rs.getInt("No_of_questions")%>"/></td>
                    </tr>
                    <tr><td><b>Marks</b></td><td><input type="text" name="Marks" value="<%=rs.getInt("Marks")%>"/></td>
                    </tr>
                    <tr><td><b>Duration</b></td><td><input type ="text"  name ="Hours" value="<%=hours%>"> : <input type ="text" name ="Minutes" value="<%=minutes%>"> : <input type ="text" name ="Seconds" value="<%=seconds%>"></td>
                    </tr>
                    <%
                            }
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                    %>

                    </tbody>
                </table>
            </div>

            <br>
                <center><span class="col-3"><button class="btn btn-success" type="submit">Save Changes</button></span></center>

            </form>
                <span class="col-3"><a href="editTestQuestions.jsp?TestID=<%=testid%>"><button class="btn btn-primary">View Test Questions</button></a></span>
        </div>
</div>
</body>
</html>
