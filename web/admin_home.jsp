<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 30-12-2018
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*,java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
<%if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
    int userid = (Integer)session.getAttribute("userid");
%>
<body>
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
    int count=1;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
%>
<div class="container">
    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#materials">Existing Materials</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#tests">Existing Tests</a>
        </li>
    </ul>

    <div class="tab-content">
        <div id="materials" class="container tab-pane active">
            <div class="container"><br>
                <h5>Domains</h5>
                <table class="table table-bordered text-center" id="Domains Table">
                    <thead>
                    <tr>
                        <th>Domain Name</th>
                        <th>Category</th>
                        <th>Action</th>

                    </tr>
                    </thead>
                    <tbody>
                    <%
                    try{
                        Class.forName(driver).newInstance();
                        conn = DriverManager.getConnection(url+dbName,"root", "");
                        PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select * from domains");
                        ResultSet rs = st.executeQuery();
                        while (rs.next()){
                            %>
                    <tr>
                        <td><%=rs.getString("DomainName")%></td>
                        <td><%=rs.getString("Category")%></td>
                        <td><a href="editConcepts.jsp?domain=<%=rs.getString("DomainName")%>&requested=concept&category=<%=rs.getString("Category")%>">Edit</a></td>
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
        </div>



        <div id="tests" class="container tab-pane fade">
            <div class="container"><br>
                <h5>Tests</h5>
                <table class="table table-bordered text-center" id="Tests Table">
                    <thead>
                    <tr>
                        <th>Test Name</th>
                        <th>Count</th>
                        <th>Action</th>
                        <th>Reports</th>

                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try{
                            Class.forName(driver).newInstance();
                            conn = DriverManager.getConnection(url+dbName,"root", "");
                            PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select * from tests");
                            ResultSet rs = st.executeQuery();
                            while (rs.next()){
                    %>
                    <tr>
                        <td><%=rs.getString("TestName")%></td>
                        <%
                            PreparedStatement pst =  (PreparedStatement)conn.prepareStatement("select count(*) from report where TestID=?");
                            pst.setInt(1,rs.getInt("TestID"));
                            ResultSet r = pst.executeQuery();
                            while(r.next()){
                                %>
                        <td><%=r.getInt(1)%></td>
                        <%
                            }
                        %>
                        <td><a href="editTest.jsp?TestID=<%=rs.getInt("TestID")%>">Edit</a></td>
                        <td><a href="adminUserReports.jsp?TestID=<%=rs.getInt("TestID")%>">View Reports</a></td>
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
        </div>
    </div>

</div>
</body>
</html>

