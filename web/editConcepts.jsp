<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 12-03-2019
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import ="java.sql.*,java.io.*"%>
<html>
<head>
    <title>Eduquer</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cloud.tinymce.com/5/tinymce.min.js?apiKey=kdxq0rbn6ap4lg7x4yl74jhxigxlqpe4n7mf5b0e7s4u4q0n"></script>
    <script>tinymce.init({forced_root_block : "", selector:'textarea' });</script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <style>
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
            margin-right:auto;
            margin-left:120px;
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
            width:900px;
            word-wrap: break-word ;
            white-space: normal;
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

<%
    int count=1;
    Connection conn=null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
    String category=request.getParameter("category");
    String domain=request.getParameter("domain");
    String requested= request.getParameter("requested");
%>
<%
    try{
        conn=DriverManager.getConnection("jdbc:mysql://localhost/eduquer","root","");
        PreparedStatement st = (PreparedStatement) conn.prepareStatement("Select * from concept where Domain=? and Category=?");
        st.setString(1,domain);
        st.setString(2,category);
        ResultSet rs=st.executeQuery();

%>
<div class="container">
    <div class="row">
        <div class="col-3">
            <nav id="sidebar" class="bg-dark fixed-left">
                <div class="sidebar-header">
                    <center> <h4 class="domain"><%=category%></h4></center>
                    <br>
                    <ul class="list" id="domains">

                    </ul>
                </div>
            </nav>
        </div>
        <div class="col-9 main-content">
            <div id="content"><h2 style="color: green;" ><b><%=domain%></b></h2><br>
                <table class="conceptdisplay" id="concepts">
                    <tbody >
                    <%
                        while(rs.next()){
                    %>

                    <tr id="concept<%=count%>">
                        <form action="EditConcepts" method="post">
                        <td>
                            <input type="hidden" name="ConceptID" value="<%=rs.getInt("Concept_ID")%>"/>
                                <span><p class="concept"><%=count%>.
                                 <textarea  name="Concept" >
                                        <%=rs.getString("Concept")%>
                                     </textarea>

                                </p>
                                    <button type="submit" class="btn btn-success">Save Changes</button>
                                 <br><br>
                                 </span>

                        </td>
                    </form>
                    </tr>
                    <%
                            count++;
                        }

                    %>

                    </tbody>
                </table>
                <%
                    }
                    catch(Exception e){
                    e.printStackTrace();
                    }
                %>

            </div>
        </div>
<div>
    <div>
    </div>

</body>
<script>
    loadDomain();
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
                    var concept_link='editConcepts.jsp?domain='+dataArray[i]+'&requested=concept&category='+category;
                    var practice_link='editPractice.jsp?domain='+dataArray[i]+'&requested=practice&category='+category;
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
</html>
