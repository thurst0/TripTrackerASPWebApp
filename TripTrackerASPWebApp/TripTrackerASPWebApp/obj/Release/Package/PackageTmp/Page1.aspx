<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="TripTrackerASPWebApp.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trip Tracker</title>
    <meta name="viewport" content="width=device-width, height=device-height initial-scale=1"/>
    <!--meta name="viewport" content='width=700'/-->
    <style>
    input, label, button {
    display:block;
    max-width: 100%;
    font-family: Arial
      
}
        </style>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="Scripts/jquery-3.1.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            PopulateTeachers(); // Usually we would be passing in school here.. so forget about fixing on initial load
        });
        var studentID;

        function PopulateStudents(teacherid) {
            TripTrackerASPWebApp.TripTracker.ListStudents(teacherid, function (students) {
                var selectstudent = $('#select-student');
                select = document.getElementById('select-student');
                selectstudent.empty();
                for (var i = 0; i < students.length; i++) {
                    var opt = document.createElement('option');
                    opt.value = students[i].StudentID;
                    var id = students[i].FirstName + students[i].LastName;
                    opt.innerHTML = id;
                    select.appendChild(opt);
                }
                // add bogus student and select
                var opt = document.createElement('option');
                opt.value = "";
                var id = ""
                opt.innerHTML = "";
                select.appendChild(opt);
                select.selectedIndex = students.length + 1;
                select.size = students.length;
            });
        }
        function UpdateStudent(id) {
            studentID = id;
            //console.log(studentID);
        }
        function NextPage() {
            //Call another aspx
            window.location = "EntryPage.aspx?studentid=" + studentID + "";
            //window.location.href = "SomePage.aspx";
            //window.location.assign("SomePage.aspx");
        }
        function PopulateTeachers() {
            var selectTeacher = $('#select-teacher');
            selectTeacher.empty();
            TripTrackerASPWebApp.TripTracker.ListTeachers(function (teachers) {
     
              select = document.getElementById('select-teacher');

                for (var i = 0; i < teachers.length; i++) {
                    var opt = document.createElement('option');
                    opt.value = teachers[i].FullName;
                    opt.innerHTML = opt.value;
                    select.appendChild(opt);
                    select.size = teachers.length;
                }

            });
        }
    </script>
</head>
<body id ="service">
	<div id="divMessage" class="errordisplay" style="display: none">
	</div>
	<form id="form1" runat="server">
            <asp:ScriptManager runat="server">
                <Services>
                    <asp:ServiceReference Path="~/TripTracker.asmx" />
                </Services>
            </asp:ScriptManager>
	<h1>Trip Tracker </h1>
    <div class="list-group">
		<label for="select-teacher">Select a teacher </label>
		<select id="select-teacher" onchange="PopulateStudents(this.value)"></select>
	</div>
	<div class="list-group">
		<label for="select-student">Select a student </label>
		<select id="select-student" onchange="UpdateStudent(this.value)"></select>
	</div>
	</form>

     <div data-role="main" class="ui-content">
         <!--input type="button" class="ui-btn" id="btnSubmit" value="Track" onclick="NextPage()"/-->
         <button class="ui-btn" id="btnSubmit" value="Track" onclick="NextPage()">Track</button>
     </div>
</body>
</html>
