<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 09-03-2019
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import=" java.io.*,java.sql.*"%>
<%@ page import="javax.xml.transform.Result" %>
<html>
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
        #sidebar {
            width: 15%;
            position:fixed;
            margin-top: 10px;
            left: 0;
            height: 100vh;
            z-index: 999;
            background: rgb(52,58,64);
            color: white;
            transition: all 0.3s;
        }

        .sidebar-header{
            padding-left:10px;
            color:white;
        }
        .menuoption{
            list-style-type:none;
            padding-left:20px;
        }

        .domain{
            margin-bottom:10px;
            color:#5cb85c;
            font-weight:bold;
        }
        .main-content{
            margin-right:auto;
            margin-left:100px;
            margin-top:80px;
            width:1100px;
            height:100%;
        }
        .nav1{
            margin-top:20px;
        }

        ol{
            padding-left:15px;
            list-style-type:lower-alpha;
        }
        ol li{
            padding-top:10px;
        }
        p{
            font-weight:bold;

            word-wrap: break-word ;
            white-space: normal;
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

<%
    int testid = Integer.parseInt(request.getParameter("TestID"));
    int count=1;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
%>
<div class="container">
    <div class="row">
        <div class="col-lg-3 col-sm-3 col-xs-3 col-sm-3 col-3" style="width: 30%">
            <nav id="sidebar" class="bg-dark fixed-left">
                <div class="sidebar-header">
                    <h4 class="domain">Tests Available</h4>
                    <br>
                    <ul class="list" id="test_name">
                        <%
                            try{
                                Class.forName(driver).newInstance();
                                conn = DriverManager.getConnection(url+dbName,"root", "");
                                PreparedStatement pst = conn.prepareStatement("Select * from tests");
                                ResultSet r = pst.executeQuery();
                                while(r.next()){
                        %>
                        <li class="active content1">
                            <p class="domain"><a style="color: white;"  href="adminUserReports.jsp?TestID=<%=r.getInt("TestID")%>"><%=r.getString("TestName")%></a></p>
                        </li>
                        <%
                                }
                            }catch(Exception e){
                                e.printStackTrace();
                            }
                        %>
                    </ul>
                </div>
            </nav>

        </div>

<div class="container text-center" style="margin: auto; padding-left: 50px;">
    <div class="col-lg-9 col-sm-9 col-xs-9 col-sm-9 col-9 main-content" style="position: relative;">

    <table class="table table-bordered text-center">
        <thead>
        <th>Rank</th>
        <th>UserName</th>
        <th>Marks</th>
        <th>View Report</th>
        </thead>
        <tbody>
        <%
            try{


                PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select * from report where TestID=? order by Marks desc ");
                st.setInt(1,testid);
                ResultSet rs = st.executeQuery();
                int previousMark = -1;
                count=1;
                int rank=count;
                String username="";
                while(rs.next()){
                    int current_mark = rs.getInt("Marks");
                    if(current_mark!=previousMark){
                        rank=count;
                    }
                    %>
                        <tr>
                            <td><%=rank%></td>
                            <%
                                PreparedStatement pst =(PreparedStatement) conn.prepareStatement("Select UserName from users where Userid=?");
                                pst.setInt(1,rs.getInt("UserID"));
                                ResultSet r = pst.executeQuery();
                                while(r.next()){
                                    %>
                            <td><%=r.getString("UserName")%></td>
                            <%
                                    username=r.getString("UserName");
                                }
                            %>

                            <td><%=rs.getInt("Marks")%></td>
                            <td><a href='adminStudentTestReport.jsp?UserName=<%=username%>&UserId=<%=rs.getInt("UserID")%>&TestID=<%=testid%>'>View Report</a></td>
                        </tr>
                    <%

                        previousMark=current_mark;
                        count++;
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
