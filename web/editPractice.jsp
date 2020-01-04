<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 12-03-2019
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import ="java.io.*,java.sql.*"%>
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
<script>
    function provide_func(pages){


        var prev= document.getElementById("previous");
        var next= document.getElementById("next");
        prev.setAttribute('onclick','changepage("page1")');
        if(pages>1){
            next.setAttribute('onclick','changepage("page2")');
        }
        else{
            next.setAttribute('onclick','changepage("page1")');
        }

    }

</script>
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
    int noq=0,nop=0;
%>
<%
    try{
        conn=DriverManager.getConnection("jdbc:mysql://localhost/eduquer","root","");
        PreparedStatement st = (PreparedStatement) conn.prepareStatement("Select * from practice where Domain=? and Category=?");
        st.setString(1,domain);
        st.setString(2,category);
        ResultSet rs=st.executeQuery();

%>
<div class="container">
    <div class="row">
        <div class="col-3">
            <nav id="sidebar" class="bg-dark fixed-left">
                <div class="sidebar-header">
                    <center>  <h4 class="domain"><a href=<%= "\"categories.jsp?category=" + category + "\"" %> > <%=category%></a></h4></center>
                    <br>
                    <ul class="list" id="domains">
                    </ul>
                </div>
            </nav>
        </div>
        <div class="container" >
            <div class="col-lg-9 col-sm-9 col-xs-9 col-sm-9 col-9 main-content" style="position: relative;">

                <table width="900">
                    <tbody>
                    <tr>
                        <td>
                            <div class="float-left"><a class="previous"> <button id="previous" type="button" class="btn btn-success"><span><i class="fas fa-arrow-left"></i></span> Previous</button></a></div>
                        </td>

                        <td>
                            <div class="float-right"> <a class="next"><button id="next" type="button" id="next-button" class="btn btn-success">Next <span><i class="fas fa-arrow-right"></i></span></button></a></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br><br>
                <table class="questdisplay" id="questions">
                    <tbody >
                    <%
                        while(rs.next()){
                    %>
                    <tr id="question<%=count%>">
                        <form action="EditPractice" method="post">
                        <td>
                            <input type="hidden" name="QuestionID" value="<%=rs.getInt("Question_ID")%>">
                             <span><p class="question"><%=count%>.
                                 <textarea name="PracticeQuestion">
                                 <%=rs.getString("Question")%>
                                 </textarea>
                                 </p>

                        <ol class="quest-options">
                           <li><input class="form-control" name="A" value=" <%=rs.getString("A")%>"></li>
                           <li><input class="form-control" name="B" value=" <%=rs.getString("B")%>"></li>
                           <li><input class="form-control" name="C" value=" <%=rs.getString("C")%>"></li>
                           <li><input class="form-control" name="D" value=" <%=rs.getString("D")%>"></li>
                        </ol>
                                 <p id="answer<%=count%>">Answer: <input class="form-control" name="Answer" value="  <%=rs.getString("Answer")%>"> </p>
                        <button type="submit" class="btn btn-success">Save Changes</button>
                            </span>
                            <br>
                            <br>
                        </td>
                        </form>
                    </tr>

                    <%
                            count++;
                        }
                        PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select count(*) from practice where Domain=? and Category=?");
                        pst.setString(1,domain);
                        pst.setString(2,category);
                        ResultSet rt= pst.executeQuery();
                        while(rt.next()){
                            noq=(Integer)rt.getInt(1);

                            nop=noq/5;
                            if((nop*5)<noq)
                                nop++;
                            System.out.println(nop+" "+noq);
                        }

                    %>
                    </tbody>
                </table>
                <br>
                <br>
                <script>
                    provide_func('<%=nop%>');
                </script>
                <div class="container">
                    <table width="900">
                        <tbody>
                        <tr>
                            <td>
                                <ul class="pagination"  style="margin-left: 50%; margin-right: 33%;">
                                    <%
                                        for(int i=1;i<=nop;i++){
                                            if(i==1){
                                    %>

                                    <li class="page-item active" id='page<%=i%>'><a class="page-link" onclick="changepage(this.parentElement.id)"><%=i%></a></li>
                                    <% }
                                    else {%>
                                    <li class="page-item" id='page<%=i%>'><a class="page-link" onclick="changepage(this.parentElement.id)"><%=i%></a></li>

                                    <% }
                                    }
                                    }
                                    catch(Exception e){
                                        e.printStackTrace();
                                    }
                                    %>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </div>

            </div>
        </div>
    </div>
</div>

</body>

<script>
    loadDomain();

    function changepage(id){
        var pages=parseInt('<%=nop%>');
        console.log(parseInt(pages));
        var parentNode=document.getElementById(id);
        var flag;
        var totalquestions='<%=noq%>';
        var prev= document.getElementById("previous");
        var next= document.getElementById("next");
        console.log(prev);
        console.log(next);

        for(var i=1;i<=pages;i++){
            var temp="page"+i;

            if(temp==id){
                flag=i;
                parentNode.setAttribute('class','page-item active');

            }
            else{
                var pageno=document.getElementById(temp);
                pageno.setAttribute('class','page-item')
            }
        }
        for(var i=1;i<=totalquestions;i++){
            if((i>=(flag*5)-4)&&(i<=(flag*5))&&(i<=totalquestions)){
                var temp="question"+i;
                var question=document.getElementById(temp);
                question.hidden=false;
            }
            else{
                var temp="question"+i;
                var question=document.getElementById(temp);
                question.hidden=true;
            }
        }
    }

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
