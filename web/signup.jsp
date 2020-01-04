<%--
  Created by IntelliJ IDEA.
  User: welcome
  Date: 25-12-2018
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
            padding-top: 26px;
        }
        @media (min-width: 992px) {
            body {
                padding-top: 56px;
            }
        }
        form{
            height:90%;
            width: 90%;
            margin: auto;
        }
        #SignupForm{
            border-style:solid;
            border-width:1px;
            border-color:grey;
        }
        .form-control:focus {
            border-color: #859f57;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.075) inset, 0px 0px 10px rgba(133, 159, 87, 0.5);
        }



    </style>

    <script>

        function validatePassword(password) {

            // Do not show anything when the length of password is zero.

            // Create an array and push all possible values that you want in password
            var matchedCase = new Array();
            matchedCase.push("[$@$!%*#?&]"); // Special Charector
            matchedCase.push("[A-Z]");      // Uppercase Alpabates
            matchedCase.push("[0-9]");      // Numbers
            matchedCase.push("[a-z]");     // Lowercase Alphabates

            // Check the conditions
            var ctr = 0;
            for (var i = 0; i < matchedCase.length; i++) {
                if (new RegExp(matchedCase[i]).test(password)) {
                    ctr++;
                }
            }
            // Display it
            var color = "";
            var strength = "";
            switch (ctr) {
                case 0:
                case 1:
                case 2:
                    strength = "Very Weak";
                    color = "red";
                    break;
                case 3:
                    strength = "Medium";
                    color = "orange";
                    break;
                case 4:
                    strength = "Strong";
                    color = "green";
                    break;
            }
            document.getElementById("passdemo").innerHTML = "Your password is "+strength;
            document.getElementById("passdemo").style.color = color;
            check();
        }
        function check(){
            if (document.getElementById('password').value == document.getElementById('confirmpass').value) {
                document.getElementById('confirmpassdemo').style.color = 'green';
                document.getElementById('confirmpassdemo').innerHTML = 'Password matched';
            } else {
                document.getElementById('confirmpassdemo').style.color = 'red';
                document.getElementById('confirmpassdemo').innerHTML = 'Password does not match';
            }

        }
        function validateEmail(inputText)
        {
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            if(inputText.match(mailformat))
            {
                document.getElementById("emaildemo").style.color ='green';
                document.getElementById("emaildemo").innerHTML = 'Email is valid';
            }
            else
            {
                document.getElementById("emaildemo").style.color ='green';
                document.getElementById("emaildemo").innerHTML = 'Invalid Email Address';

            }
        }
        function validatePhonenumber(inputtxt)
        {
            var phoneno = /^\d{10}$/;
            if(inputtxt.match(phoneno))
            {
                document.getElementById("phonedemo").style.color ='green';
                document.getElementById("phonedemo").innerHTML = 'Phone Number is valid';
            }
            else
            {
                document.getElementById("phonedemo").style.color ='green';
                document.getElementById("phonedemo").innerHTML = 'Invalid Phone number';
            }
        }


    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">

    <h1>   <a class="navbar-brand" href="student_home2.jsp"><h5><b>EDUQUER</b></h5></a></h1>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">

            <li class="nav-item active">
                <a class="nav-link"  href="index.html"><b> Login <span style="color:#ffffff;padding-right:65px;"><i class="fa fa-sign-in-alt"></i></span></b></a>
            </li>
        </ul>
    </div>

</nav>
<br>
<div class="container col-6" style="padding:15px;">
    <div class="container well border shadow p-3 mb-5 bg-white rounded" id="SignupForm">

        <form class="col-9" action="DBInsert" method="post">
            <h2 class="mt-5 text-center " style="color:#5cb85c;"><b >Sign Up</b></h2><br>
            <div class="container">

                <div class="form-group">
                    <label for="username"><b>Username:</b></label>
                    <input type="text" class="form-control" id="username" name="username" required>

                </div>
                <div class="form-group">
                    <label for="email"><b>Email:</b></label>
                    <input type="text" class="form-control" name="email" id="email" required onkeyup="validateEmail(this.value)";>
                    <p id="emaildemo"></p>
                </div>

                <div class="form-group">
                    <label for="phonenumber"><b>Phone Number</b></label>
                    <input type="text" class="form-control" name="phonenumber" id="phonenumber" onkeyup="validatePhonenumber(this.value)";>
                    <p id="phonedemo"></p>
                </div>

                <div class="form-group">
                    <label for="password"><b>Password:</b></label>
                    <input type="password" class="form-control" id="password" name="password" required onkeyup="validatePassword(this.value);">
                    <p id="passdemo"></p>
                </div>
                <div class="form-group">
                    <label for="confirmpass"><b>Confirm Password:</b></label>
                    <input type="password" class="form-control" id="confirmpass" name="confirmpass" required onkeyup="check();">
                    <p id="confirmpassdemo"></p>
                </div>
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-success shadow-lg rounded" style="padding-right:80px; padding-left:80px;"><b> Create an Account</b></button>
                </div>

            </div>
        </form>
    </div>

</div>
</body>
</html>
