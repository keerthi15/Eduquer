<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 27-12-2018
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*,java.sql.*"%>
<%@ page import="javax.xml.transform.Result" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Eduquer_OTS</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.j   s" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor1/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
            margin-top: 25px;
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
        a{
            color:white;
        }
        a:hover{
            color:#5cb85c;
        }
        .content1{
            margin-bottom:10px;
        }
        .domain{
            margin-bottom:10px;
            color:#5cb85c;
            font-weight:bold;
        }
        .main-content{
            padding-left:100px;
        }
        .nav1{
            margin-top:20px;
        }
        table.center {
            margin-left:auto;
            margin-right:auto;
            margin-top:50%;
            font-size: 20px;
        }
        table tr td{
            padding:20px;
        }

    </style>

</head>
<body>
<%if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
    int userid = (Integer)session.getAttribute("userid");
%>
<% String category=request.getParameter("category");%>
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

<%

    int count=0;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
%>
<div class="container">
    <div class="row">
        <div class="col-3">
            <%--<nav id="sidebar" class="bg-dark fixed-left">--%>
                <%--<div class="sidebar-header">--%>
                    <%--<center> <h4 class="domain"> <a href=<%= "\"categories.jsp?category=" + category + "\"" %>> <%=category%></a></h4></center>--%>
                    <%--<br>--%>
                    <%--<ul class="list" id="domains">--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</nav>--%>
            <br><br>
            <div class="col-9 main-content">
                <table width="900" class="align-content-center center">
            <%
            try{
                Class.forName(driver).newInstance();
                conn = DriverManager.getConnection(url+dbName,"root", "");

                PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select distinct Category from domains");
                ResultSet rs = pst.executeQuery();
                while(rs.next()){
                    String unique_category = rs.getString("Category");
                    %>
                    <tr>
                        <td align="center"><b><%=unique_category%></b>
                        </td>
                    </tr>
            <%
                    PreparedStatement  st =(PreparedStatement)conn.prepareStatement("Select DomainName from domains where Category=?");
                    st.setString(1,unique_category);
                    ResultSet r = st.executeQuery();
                    while(r.next()){
                        %>
                    <tr>
                        <td align="center"><a style="color: green;" href='concepts.jsp?domain=<%=r.getString("DomainName")%>&requested=concept&category=<%=unique_category%>'><%=r.getString("DomainName")%>
                        </a></td>
                    </tr>
                    <%
                    }
                }

            }catch(Exception e){
                e.printStackTrace();
            }
            %>


                </table>
            </div>
        </div>
    </div>
</div>
<script>
  //  loadDomain();
    function loadDomain(){
        var category='<%=category%>';
        var results_box =document.getElementById("domains");

        var hr=new XMLHttpRequest();
        var sendingdata= "category="+category;
        var final="";
        while (results_box.firstChild) {
            results_box.removeChild(results_box.firstChild);
        }
        hr.open("GET","SideBar?"+sendingdata,true);
        hr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        hr.onreadystatechange = function(){
            if(hr.readyState==4 && hr.status==200){
                var data= (hr.responseText).toString();

                var dataArray=data.split("|");
                var i;
                var parent;
                for(i=0;i< dataArray.length -1;i++){

                    var domainname=dataArray[i];
                    var concept_link='concepts.jsp?domain='+dataArray[i]+'&requested=concept&category='+category;
                    var practice_link='practice.jsp?domain='+dataArray[i]+'&requested=practice&category='+category;
                    var parent= document.createElement("li");
                    parent.setAttribute("class","active content1");

                    var para = document.createElement("p");
                    para.setAttribute("class","domain");


                    var textvalue=document.createTextNode(domainname);
                    para.appendChild(textvalue);

                    parent.appendChild(para);

                    var list =document.createElement("ul");
                    list.setAttribute("class","list menuoption");

                    var newitem = document.createElement("li");

                    var link= document.createElement("a");
                    link.setAttribute("href",concept_link);

                    var concept=document.createTextNode("Concepts");
                    link.appendChild(concept);

                    newitem.appendChild(link);

                    list.appendChild(newitem);

                    var newitem2 = document.createElement("li");

                    var link2= document.createElement("a");
                    link2.setAttribute("href",practice_link);

                    var practice=document.createTextNode("Practice");
                    link2.appendChild(practice);

                    newitem2.appendChild(link2);

                    list.appendChild(newitem2);

                    parent.appendChild(list);

                    results_box.appendChild(parent);

                }


            }

    }

        hr.send(sendingdata);
    }
</script>

</body>
</html>