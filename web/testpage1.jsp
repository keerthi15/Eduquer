<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 20-02-2019
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.Eduquer.testLoad1,java.sql.*,java.io.*"%>
<html>
<head>
    <title>Eduquer</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="vendor1/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">


    <style>
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


        .navbar{
            margin-top:auto;
            margin-bottom:auto;
        }
        .form-check-label{
            padding-bottom:5px;
        }
        p{
            font-weight:bold;

            word-wrap: break-word ;
            white-space: normal;
        }


        a{
            color:white;
        }
        a:hover{
            color:#5cb85c;
        }

        .main-content{
            margin-right:auto;
            margin-left:100px;
            margin-top:80px;
            width:1100px;

        }
        #timer{
            padding-left:10px;
            font-weight: bold;

        }
    </style>
    <script>
        var days=0,hours=0,minutes=0,seconds=0;

        function timer(seconds){
            if(sessionStorage.getItem('seconds')!=null)
                seconds = sessionStorage.getItem('seconds');
            var t=seconds;
            var x=setInterval(function(){

                days=Math.floor(t/(1000*60*60*24));
                hours=Math.floor((t%(1000*60*60*24))/(1000*60*60));
                minutes=Math.floor((t%(1000*60*60))/(1000*60));
                seconds=Math.floor((t%(1000*60))/1000);
                document.getElementById('demo').innerHTML=days+ " d "+ hours+" h "+minutes+" m "+seconds+" s";
                t=t-1000;
                sessionStorage.setItem('seconds',t);
                if(t<0){
                    window.location.href ="student_home2.jsp";
                }
            },1000);
            loadquestion(1);
        }

    </script>
</head>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    int testid = Integer.parseInt(request.getParameter("testid"));

    System.out.println(testid);
    int complexity=(Integer)session.getAttribute("complexity");
    Connection conn=null;
    ResultSet r1 = null;
    String url="jdbc:mysql://localhost/";
    String dbName="eduquer";
    String driver="com.mysql.jdbc.Driver";
    String testname="";
    int count=0,noq=0,duration=0,uid=0;
    try{
        uid= (Integer)session.getAttribute("userid");
        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection(url+dbName,"root", "");
        testLoad1 t = new testLoad1(conn,url,dbName,driver);
        t.getConn();


        PreparedStatement st1=(PreparedStatement)conn.prepareStatement("select * from tests where TestID=?");
        st1.setInt(1,testid);
        ResultSet r = st1.executeQuery();

        while(r.next()){
            testname=r.getString("TestName");
            duration=r.getInt("Duration");
        }



%>

<%if(session.getAttribute("uname")==null){
    response.sendRedirect("index.jsp");
}
%>

<body onload="timer(parseInt('<%=duration%>')*1000)">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

    <h1>   <a class="navbar-brand" href="student_home.jsp" ><h5><b>EDUQUER</b></h5></a></h1>

</nav>
<div class="container main-content border border-light">
    <div id="timer" >
        <table id="buttons" width="100%">
            <tbody>
            <tr>
                <td>
                    <div class="float-left">
                        Time remaining: <p id="demo" > </p>
                    </div>
                </td>
                <td>
                    <div style="margin-right: 33%; margin-left: 20%;"><h3><%=testname%></h3></div>
                </td>
                <td>
                    <div class="float-right"><button type="button" class="btn btn-danger" onclick=getConfirmation() >End Test</button></div>
                </td>
            </tr>
            </tbody>
        </table>



    </div>

    <div id="questions">

        <br>
        <form name="myForm" method="post" action="SaveAnswer1">
            <table class="questdisplay" id="question_display" width="100%">
                <input type="hidden" hidden name="userid" value='<%=uid%>'>
                <input type="hidden" hidden name="testid" value='<%=testid%>'>
                <input type="hidden" hidden name="complexity" value='<%=complexity%>'>
                <tbody>

                <%
                    r1=  t.getQues(testid,uid,complexity);
                    count =(Integer)session.getAttribute("count");
                        while(r1.next()){
                            System.out.println(r1.getInt("QuestionID"));

                %>

                <tr>
                    <td id="<%=count%>">

                        <input type=" hidden" name="QuestionID" value='<%=r1.getInt("QuestionID")%>' hidden>
                        <p id="question_no">Question No: <%=count%>.</p>
                        <p id="question"><%=r1.getString("Question")%></p>
                        <div class="form-check">
                            <label class="form-check-label" for="a">
                                <input type="radio" class="form-check-input" id="a" name="optradio<%=r1.getInt("QuestionID")%>" value='Option A' ><%=r1.getString("Option A")%>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label" for="b">
                                <input type="radio" class="form-check-input" id="b" name="optradio<%=r1.getInt("QuestionID")%>" value='Option B'><%=r1.getString("Option B")%>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label" for="c">
                                <input type="radio" class="form-check-input" id="c" name="optradio<%=r1.getInt("QuestionID")%>" value='Option C'> <%=r1.getString("Option C")%>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">

                                <input type="radio" class="form-check-input" id="d" name="optradio<%=r1.getInt("QuestionID")%>" value='Option D'><%=r1.getString("Option D")%>
                        </div>
                        <br><br>
                        <table width="100%">
                            <tbody>
                            <tr>
                                <%--<td>--%>
                                    <%--<div class="float-left"><a class="previous"> <button type="button" id ="previous" class="btn btn-success" onclick="loadquestion(parseInt('<%=count%>')-1)"><span><i class="fas fa-arrow-left"></i></span> Previous</button></a></div>--%>
                                <%--</td>--%>

                                <td id="submit">
                                    <div style="margin-right: 33%; margin-left: 20%;"><button type="submit" id="submit-button" class="btn btn-primary" >Submit</button></div>
                                </td>

                                <%--<td>--%>
                                    <%--<div class="float-right"> <a class="next"><button type="button" id="next"  class="btn btn-success" onclick="loadquestion(parseInt('<%=count%>')+1)">Next <span><i class="fas fa-arrow-right"></i></span></button></a></div>--%>
                                <%--</td>--%>
                            </tr>
                            </tbody>
                        </table>


                        </p>
                    </td>
                </tr>

                <%
                        }

                    }catch(Exception e){
                    e.printStackTrace();
                    }
                %>

                </tbody>
            </table>
        </form>
        <br><br>

    </div>
</div>

</body>
<script>


    var totalquestions = parseInt('<%=noq%>');


    function loadquestion(id) {
        var prev = document.getElementById("previous");
        var next = document.getElementById("next");
        var submit =document.getElementById("submit-button");

        if(id<=0){
            id=1;
        }
        if(id>=totalquestions){
            id=totalquestions;
            submit.disabled=false;
        }
        else{

            submit.disabled = true;
        }

        for (var i = 1; i <= totalquestions; i++) {
            if (i == id) {
                var question = document.getElementById(id);
                question.hidden = false;
            } else {
                var question = document.getElementById(i);
                question.hidden = true;

            }

        }

    }

    function getConfirmation() {
        var retVal = confirm("Do you want to end the test ?");
        if( retVal == true ) {
            window.location.href="student_home2.jsp";
            return true;
        }

    }


</script>
</body>
</html>