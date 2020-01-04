<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 25-12-2018
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
  <%
    session.setAttribute("uname", null);
    session.setAttribute("admin", null);
    session.setAttribute("userid", null);

  %>
  <meta charset="UTF-8">
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
    }
    @media (min-width: 992px) {
      body {
        padding-top: 56px;
      }
    }
    .carousel-inner img {
      width: 100%;
      height: 100%;
    }

    .form-login {
      background-color: #EDEDED;
      padding-top: 10px;
      padding-bottom: 20px;
      padding-left: 20px;
      padding-right: 20px;
      border-radius:20px;
      border-color:#d2d2d2;
      border-width: 5px;

    }
    .form-control {

    }

    .glyph{
      vertical-margin:middle;
      padding:35px;
      border-radius: 50%;
      border-color:#d2d2d2;
      border-width: 5px;
    }

    .glyph1{
      vertical-margin:middle;
      padding:60px 30px 30px 30px;

    }
    .detail{
      text-align:center;
      padding:10px;
    }
    input{
      font-family:"Courier";

    }
  </style>

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

  <h1>   <a class="navbar-brand" href="student_home2.jsp"><h5><b>EDUQUER</b></h5></a></h1>

</nav>

<br>
<br>
<br>
<div class="container">
  <div class="row" >

    <div class="container col-9">
      <table>
        <tbody>
        <tr>
          <td>
            <div class="glyph">
              <span><i class="fas fa-book-reader fa-7x" style="color:red;"></i></span>
            </div>
          </td>
          <td>
            <div class="glyph1">
              <span><i class="fas fa-angle-double-right fa-3x"></i></span>
            </div>
          </td>
          <td>
            <div class="glyph">
              <span ><i class="fas fa-user-edit fa-7x" style="color:red;"></i></span>
            </div>
          </td>
          <td>
            <div class="glyph1">
              <span><i class="fas fa-angle-double-right fa-3x"></i></span>
            </div>
          </td>
          <td>
            <div class="img">
              <img src="evaluate.png" alt="Evaluate" style="width:150px; border-radius:50%; height:150px;">
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div class="detail">
              <b>Learn</b>
            </div>
          </td>
          <td></td>
          <td>
            <div class="detail">
              <b>Test</b>
            </div>
          </td>
          <td></td>
          <td>
            <div class="detail">
              <b>Evaluate</b>
            </div>
          </td>
        </tr>
        </tbody>
      </table>
    </div>

    <div class="col-3 form-login border shadow p-3 mb-5 bg-grey rounded" id="login">
      <h3 class="text-center"><b>Login</b></h3><br>
      <div class="container well" id="LoginForm">
        <form action="Login" method="post">
          <div class="container">

            <div class="form-group">
              <label for="username"><b>Username</b></label>
              <input type="text" class="form-control" name="username" id="username" placeholder="username">
            </div>
            <div class="form-group">
              <label for="password"><b>Password</b></label>
              <input type="password" class="form-control" name="password" id="password" placeholder="password">
            </div>

            <div class="form-group text-center" style="padding-top:10px;">

              <button type="submit" class="btn btn-success" onclick=""><span class="glyphicon glyphicon-send"></span><b>Login</b></button>
              <a href="signup.jsp" style="padding-left:20px;"><button type="button" class="btn btn-outline-success"><span class="glyphicon glyphicon-send"></span><b>Sign up</b></button></a>


            </div>

          </div>
        </form>
      </div>
    </div>


  </div>

</div>

</body>
</html>