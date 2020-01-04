        <%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 27-12-2018
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*,java.io.*,java.math.*" %>
        <%if(session.getAttribute("uname")==null){
            response.sendRedirect("index.jsp");
        }
        %>
<%Class.forName("com.mysql.jdbc.Driver").newInstance();
    int count = 1, noq = 0;
    double nop = 0;
    int userid = (Integer)session.getAttribute("userid");
%>

        <%   int uid = (Integer) session.getAttribute("userid");%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Eduquer_OTS</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
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
            width:900px;
            word-wrap: break-word ;
            white-space: normal;
        }

    </style>
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
</head>
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


<%

    String testid="";
    float marks=0;
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/eduquer", "root", "");
        PreparedStatement st = (PreparedStatement) conn.prepareStatement("Select TestID from report where UserID=?");
        st.setInt(1, uid);

        ResultSet rs = st.executeQuery();
        testid = "";
        while (rs.next()) {
            testid = testid + rs.getInt("TestID") + ",";

        }

%>
<div class="container">
    <div class="row">
        <div class="col-3">
            <nav id="sidebar" class="bg-dark fixed-left">
                <div class="sidebar-header">
                    <center>  <h4 class="domain">
                       Tests Taken</h4></center>
                    <br>
                    <ul class="list" id="test_name">
                    </ul>
                </div>
            </nav>
            <div class="container" >
                <div class="col-lg-9 col-sm-9 col-xs-9 col-sm-9 col-9 main-content" style="position: relative;">

                    <table class="questdisplay" id="questions">
                        <tbody >
            <%
                String name=request.getParameter("testname");
                if(name==null){
                    %>

            <%
                }
                else{
                String questions="";
                String Options="";
                float totalmarks=0;
                ResultSet rs3;
                     conn = DriverManager.getConnection("jdbc:mysql://localhost/eduquer", "root", "");
                    PreparedStatement st1 = (PreparedStatement) conn.prepareStatement("Select * from tests where TestName=?");
                    st1.setString(1,name);

                    ResultSet rs1 = st1.executeQuery();
                    int id=0;
                    while (rs1.next()) {
                        totalmarks = (float)rs1.getInt("Marks");
                        id=rs1.getInt("TestID");
                        PreparedStatement st2 = (PreparedStatement) conn.prepareStatement("Select * from  report where TestID=? and UserID=?");
                        st2.setInt(1,id);
                        st2.setInt(2,uid);
                        ResultSet rs2 = st2.executeQuery();

                        while (rs2.next()) {
                             questions=rs2.getString("Questions");
                             Options=rs2.getString("Options");
                             marks= (float)rs2.getInt("Marks");
                        }
                        float Percentage =Math.round((marks*100))/totalmarks;
                        st2 = (PreparedStatement)conn.prepareStatement("update report set Percentage =? where TestID=? and UserID=?");
                        st2.setFloat(1,Percentage);
                        st2.setInt(2,id);
                        st2.setInt(3,uid);
                        st2.executeUpdate();
                    %>

            <b>Marks: </b><%=marks%><br>
            <b>Total Marks:</b> <%=totalmarks%><br>
            <b>Percentage: </b><%=Percentage%><br>  <br>
            <%
                    }
                    String[] optionarray=Options.split(",");
                    String[] quesarray=questions.split(",");
                    int []questionarray= new int[quesarray.length];
                    for(int j=0;j<quesarray.length;j++){
                        questionarray[j]=Integer.parseInt(quesarray[j]);
                        PreparedStatement st3 = (PreparedStatement) conn.prepareStatement("Select * from  test_questions where QuestionID=?");
                        st3.setInt(1,questionarray[j]);
                         rs3=st3.executeQuery();
                         String chosenanswer=optionarray[j];

                            while(rs3.next()){
                        %>
                        <tr id="question<%=count%>">
                            <td>
                             <span><p class="question"><%=count%>. <%=rs3.getString("Question")%></p>
                        <ol class="quest-options">
                           <li><%=rs3.getString("Option A")%></li>
                           <li><%=rs3.getString("Option B")%></li>
                           <li><%=rs3.getString("Option C")%></li>
                           <li><%=rs3.getString("Option D")%></li>
                        </ol>
                                 <p id="choosenanswer<%=count%>"> Your Answer: <%=rs3.getString(chosenanswer)%>
                                    <%if(chosenanswer.compareToIgnoreCase(rs3.getString("Answer"))==0){
                                        %>
                                 <span style="color: green;"><i class="fas fa-check "></i></span>
                                 <%
                                    }else{
                                        %>
                                 <span style="color: red;"><i class="fas fa-times red"></i></span>
                                 <%   }%>
                                 </p>  <p id="answer<%=count%>" hidden>Answer: <%=rs3.getString("Answer")%> </p>
                        <button type="button" class="btn btn-primary" onclick="show('<%=count%>')">View Answer</button>

                            </span>
                                <br>
                                <br>
                            </td>
                        </tr>

                        <%
                                count++;
                            }
                            }

                            PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select No_of_questions from tests where TestID=?");
                            pst.setInt(1,id);
                    ResultSet rt= pst.executeQuery();
                            while(rt.next()){
                                noq= rt.getInt("No_of_questions");

                        nop= noq/ 5 ;
                        if( (nop* 5 )< noq)
                            nop++;
                        System.out.println(nop+ "  "+ noq);
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
                                            for(int i = 1; i <=nop;i ++){
                        if( i==1 ){
                            %>

                                        <li class="page-item active" id='page<%=i%>'
                            ><a class="page-link" onclick="changepage(this.parentElement.id)"><%=i%></a></li>
                                        <% } else {%>
                                        <li class="page-item" id='page<%=i%>'
                            ><a class="page-link" onclick="changepage(this.parentElement.id)"><%=i%></a></li>

                                        <%
                                                        }
                                            }
                                        }
                                        } catch(Exception e){
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
</div>

<script>
    loadDomain();

    function show(i){
        var x= document.getElementById("answer"+i);
        if(x.hidden===true){
            x.hidden=false;
        }
        else {
            x.hidden=true;
        }
    }

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
        var testid='<%=testid%>'
        var results_box =document.getElementById("test_name");

        var hr=new XMLHttpRequest();
        var sendingdata= "testid="+testid;

        hr.open("GET","ReportSideBar?"+sendingdata,true);
        hr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        hr.onreadystatechange = function(){
            if(hr.readyState==4 && hr.status==200){
                var data= (hr.responseText).toString();
                console.log(data);
                var dataArray=data.split("|");
                var i;
                var parent;
                for(i=0;i< dataArray.length-1;i++){

                    var testname=dataArray[i];
                    var test_link='report.jsp?testname='+dataArray[i];

                    var parent= document.createElement("li");
                    parent.setAttribute("class","active content1");

                    var para = document.createElement("p");
                    para.setAttribute("class","domain");

                    var link= document.createElement("a");
                    link.setAttribute("href",test_link);

                    var textvalue=document.createTextNode(testname);
                    link.appendChild(textvalue);
                    para.appendChild(link);

                    parent.appendChild(para);

                    results_box.appendChild(parent);

                }


            }

        }

        hr.send(sendingdata);
    }




</script>


</body>
</html>