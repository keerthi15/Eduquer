<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 11-03-2019
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.io.*,java.util.*,java.sql.*"%>
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
            width:900px;
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
                    <a tabindex="-4" class="dropdown-item" href="#">View User Profile</a>
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
    int testid= Integer.parseInt(request.getParameter("TestID"));
    int noq=0,nop=0;
    try{
        Class.forName(driver);
        conn = DriverManager.getConnection(url+dbName, "root","");
        PreparedStatement stm =(PreparedStatement)conn.prepareStatement("Select TestName from tests where TestID=?");
        stm.setInt(1,testid);
        ResultSet r =stm.executeQuery();
        PreparedStatement pst = (PreparedStatement)conn.prepareStatement("Select * from test_questions where TestID=?");
        pst.setInt(1,testid);
        ResultSet rs = pst.executeQuery();
        %>
<div class="container">
    <%
        while(r.next()){
    %>
    <h4 class="text-center"><%=r.getString("TestName")%></h4></center>
    <%
        }
    %>
    <div class="row">
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
                                int level = rs.getInt("Complexity");
                                String difficulty="";
                                switch(level){
                                    case 1:
                                        difficulty="Easy";
                                        break;
                                    case 2:
                                        difficulty="Medium";
                                        break;
                                    case 3:
                                        difficulty="Hard";
                                        break;
                                }

                        %>
                        <form action="EditTestQuestion" method="post">
                        <input type="hidden" name="TestID" value="<%=testid%>"/>
                        <input type="hidden" name ="QuestionID" value="<%=rs.getInt("QuestionID")%>"/>
                        <tr id="question<%=count%>">
                            <td>
                             <span>
                                 <p class="question">
                                     <%=count%>.
                                     <textarea  name="Question" >
                                        <%=rs.getString("Question")%>
                                     </textarea>
                                </p>

                                <ol class="quest-options">
                                    <li><input type="text" class="form-control col-6" name="Option A"  value="<%=rs.getString("Option A")%>"></li>
                                    <li><input type="text" class="form-control col-6" name="Option B"  value="<%=rs.getString("Option B")%>"></li>
                                    <li><input type="text" class="form-control col-6" name="Option C"  value="<%=rs.getString("Option C")%>"></li>
                                    <li><input type="text" class="form-control col-6" name="Option D"  value="<%=rs.getString("Option D")%>"></li>
                                </ol>
                                <p>Answer:
                                 <select class="form-control col-12" name="Answer">
                                     <%if((rs.getString("Answer")).equals("Option A")){%>
                                     <option selected>Option A</option>
                                     <%}else{%>
                                     <option>Option A</option>
                                     <%}%>
                                     <%if((rs.getString("Answer")).equals("Option B")){%>
                                     <option selected>Option B</option>
                                     <%}else{%>
                                     <option>Option B</option>
                                     <%}%>
                                     <%if((rs.getString("Answer")).equals("Option C")){%>
                                     <option selected>Option C</option>
                                     <%}else{%>
                                     <option>Option C</option>
                                     <%}%>
                                     <%if((rs.getString("Answer")).equals("Option D")){%>
                                     <option selected>Option D</option>
                                     <%}else{%>
                                     <option>Option D</option>
                                     <%}%>
                                     </select>

                                </p>
                                <p>Marks:
                                    <input type="text" class="form-control col-3" name="Marks" value="<%=rs.getInt("Marks")%>">
                                </p>
                                <p>Difficulty:
                                     <select class="form-control col-12" name="Difficulty">
                                     <%if(difficulty.equals("Easy")){%>
                                     <option selected>Easy</option>
                                     <%}else{%>
                                     <option>Easy</option>
                                     <%}%>
                                     <%if((difficulty).equals("Medium")){%>
                                     <option selected>Medium</option>
                                     <%}else{%>
                                     <option>Medium</option>
                                     <%}%>
                                     <%if(difficulty.equals("Hard")){%>
                                     <option selected>Hard</option>
                                     <%}else{%>
                                     <option>Hard</option>
                                     <%}%>
                                     </select>
                                    <%--<input type="text" class="form-control col-3" name="Difficulty" value="<%=difficulty%>">--%>
                                </p>
                                <button type="submit" class="btn btn-success">Save Changes</button>
                            </span>
                            <br>
                            <br>
                            </td>
                        </tr>
                        </form>
                        <%
                                count++;
                            }
                            PreparedStatement st = (PreparedStatement)conn.prepareStatement("Select count(*) from test_questions where TestID=?");
                            st.setInt(1,testid);
                            ResultSet rt= st.executeQuery();
                            while(rt.next()){
                                noq=(Integer)rt.getInt(1);

                                nop=noq/5;
                                if((nop*5)<noq)
                                    nop++;

                            }

                        %>
                        <script>
                            showquestions(<%=noq%>);
                        </script>
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
    function showquestions(noq){
        var i;
        for(i=1;i<=noq;i++){
            if(i<=5){
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

</script>
</html>
