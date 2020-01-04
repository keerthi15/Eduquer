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
    <title>Eduquer_OTS</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cloud.tinymce.com/5/tinymce.min.js?apiKey=kdxq0rbn6ap4lg7x4yl74jhxigxlqpe4n7mf5b0e7s4u4q0n"></script>
    <script>tinymce.init({ forced_root_block : "",selector:'textarea' });</script>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

<div class="tab-content">
    <div class="container">
        <form class="col-form-label" action="add_testqun_insert" method="post">
            <div class="row">
                <div class="form-group col-6">
                    <label ><b>Question No. <%=session.getAttribute("count")%></b></label>
                    <input type="hidden" name="count" hidden value="<%=session.getAttribute("count")%>">
                    <input type="hidden" name="noq" hidden value="<%=session.getAttribute("noq")%>">
                    <input type="hidden" name="testId" hidden value="<%=session.getAttribute("testId")%>">

                </div>
                <div class="form-group col-3">
                    <label for="marks"><b>Marks</b></label>
                    <input type="text" class="form-control col-12" id="marks" name="marks">

                </div>
                <div class="form-group col-6">

                    <label for="level"><b>Difficulty Level</b></label>
                    <select class="form-control" id="level" name="d_level">
                        <option>Easy</option>
                        <option>Medium</option>
                        <option>Difficult</option>

                    </select>

                </div>

            </div>
            <br><br>
            <div class="container">
                <h5>Question</h5>
                <div class="form-group col-12">
                    <textarea name="quntext">Enter your question</textarea>
                </div>
                <table>
                    <tbody>
                    <tr id="question">
                        <td>
                            <label><b>Options</b></label>
                            <ol type="A">
                                <li><input type="text" class="form-control col-12" name="option_a"></li>
                                <li><input type="text" class="form-control col-12" name="option_b"></li>
                                <li><input type="text" class="form-control col-12" name="option_c"></li>
                                <li><input type="text" class="form-control col-12" name="option_d"></li>

                            </ol>


                                <label for="answer"><b>Answer</b></label>
                                <select class="form-control col-12" name="Answer" id="Answer">

                                    <option>Option A</option>
                                    <option>Option B</option>
                                    <option>Option C</option>
                                    <option>Option D</option>

                                </select>


                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="form-group text-center col-12">

                    <button type="submit" id="PracticeAdd" class="btn btn-primary"  style="padding-right:80px; padding-left:80px; ">Submit</button>
                </div>

            </div>
        </form>


    </div>
</div>
</body>
</html>