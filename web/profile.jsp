<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 13-03-2019
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import ="java.sql.*,java.io.*"%>
<html>
<head>
    <title>Eduquer_OTS</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <style>


        .test-detail{
            padding:10px;
        }
        .name,designation{
            padding:3px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;
            font-family: Arial;
        }
        /*.profile_picture{
            opacity: 1;
        }*/
        .details{

            margin-top:10px;
            text-align: center;
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
    int userid = (Integer)session.getAttribute("userid");
%>
<body>
<%
    int admin = (Integer)(session.getAttribute("admin"));
    if(admin==1){
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
                <a class="nav-link " href="#" id="createtest" >
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
    }else{
        %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

    <h1>   <a class="navbar-brand" href="student_home2.jsp" ><h5><b>EDUQUER</b></h5></a></h1>
    <div class="collapse navbar-collapse" id="navbarResponsive1">
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
                <a class="nav-link dropdown-toggle" href="#" id="profiledrop1" data-toggle="dropdown">
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
<%
    }
%>

<%
    int count=1;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
    userid= Integer.parseInt(request.getParameter("UserID"));
    int noq=0,nop=0;
%>
<%
    try{
        conn=DriverManager.getConnection("jdbc:mysql://localhost/eduquer","root","");
        PreparedStatement st = (PreparedStatement) conn.prepareStatement("Select * from users where Userid=?");
        st.setInt(1,userid);
        ResultSet rs=st.executeQuery();
        while(rs.next()){
            %>
<form action="EditProfile" method="post">
    <h2 class="mt-5 text-center " style="color:#5cb85c;"><b >Profile</b></h2><br>
    <div class="container">
        <input type="hidden" name="UserID" value="<%=userid%>">
        <div class="form-group">
            <label for="username"><b>Username:</b></label>
            <input type="text" class="form-control" id="username" name="username" value="<%=rs.getString("Username")%>">

        </div>
        <div class="form-group">
            <label for="email"><b>Email:</b></label>
            <input type="text" class="form-control" name="email" id="email" value="<%=rs.getString("Email")%>" onkeyup="validateEmail(this.value)";>
            <p id="emaildemo"></p>
        </div>

        <div class="form-group">
            <label for="phonenumber"><b>Phone Number</b></label>
            <input type="text" class="form-control" name="phonenumber" id="phonenumber" value="<%=rs.getString("Phone_number")%>" onkeyup="validatePhonenumber(this.value)";>
            <p id="phonedemo"></p>
        </div>
        <%
        String currentPassword =rs.getString("Password");
        %>
        <div class="form-group">
            <label for="currentPassword"><b>Current Password:</b></label>
            <input type="password" class="form-control" id="currentpassword" name="currentPassword" required>
            <p id="curentpassdemo"></p>
        </div>


        <div class="form-group" id="newpass">
            <label for="newPassword"><b>New Password:</b></label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" >
            <p id="passdemo"></p>
        </div>
        <div class="form-group" id="confirmpassword" >
            <label for="confirmpass"><b>Confirm Password:</b></label>
            <input type="password" class="form-control" id="confirmpass" name="confirmpass" >
            <p id="confirmpassdemo"></p>
        </div>
        <div class="form-group text-center">
            <button type="submit" class="btn btn-success shadow-lg rounded" style="padding-right:80px; padding-left:80px;"><b> Save Changes</b></button>
        </div>


    </div>
</form>
    <%
        }
    }catch (Exception e){
        e.printStackTrace();
    }
%>

</body>
<script>
    function validatePassword(){
        var userId = <%=userid%>;
        var password = "&password="+document.getElementById("currentpassword").value;
        console.log(password);
        var hr = new XMLHttpRequest();
        var sendingdata="UserID="+userId+password;
        hr.open("POST","ReportSideBar?"+sendingdata,true);

        hr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        hr.onreadystatechange = function() {
            if (hr.readyState == 4 && hr.status == 200) {
                var equals = (hr.responseText).toString();
                console.log(equals);

                if(equals == "true"){
                    document.getElementById("newpass").hidden=false;
                    // document.getElementById("confirmpassword").hidden=false;
                }
                else{
                    document.getElementById("newpass").hidden=true;
                    // document.getElementById("confirmpassword").hidden=false;
                    alert('Wrong password');
                }
            }
        }
       // hr.send(sendingdata);

    }
</script>
</html>
