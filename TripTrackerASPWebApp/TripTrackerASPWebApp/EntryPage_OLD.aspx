<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntryPage_OLD.aspx.cs" Inherits="TripTrackerASPWebApp.EntryPage_OLD" %>
<%@ PreviousPageType VirtualPath="~/Page1_OLD.aspx" %> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trip Tracker</title>
        <meta name="viewport" content="width=device-width, height=device-height initial-scale=1"/>
    <style>
    input, label, button {
    max-width: 100%;
    font-family: Arial
    }
     </style>
      <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="Scripts/jquery-3.1.0.min.js" type="text/javascript"></script>
  <script type="text/javascript">
        $(document).ready(function () {
            OnLoad();
        });
        var ID;
        var TripType;
        var isteacher;
        function OnLoad() {
            var str = window.location.href;
       
            theleft = str.indexOf("=") + 1;
                theright = str.lastIndexOf("&");
                ID = str.substring(theleft, str.length);
                console.log(ID);
                if (str.includes("teacherid")) {
                    isteacher = true;
                    PopulateStudents(ID);
                }
            //document.write("Student ID is " + delineate(text));
            //ID = fullURL.substring(fullURL.indexOf('&') + 6, fullURL.length - 2)

        }
        
        function UpdateDistance() {
            var distance = document.getElementById('distance');
            var radios = document.getElementsByName('triptype');
            for (var i = 0, length = radios.length; i < length; i++) {
                if (radios[i].value == 7 && radios[i].checked) {
                    console.log(i);
                    distance.disabled = "enabled";
                    distance.disabled = false;
                    document.getElementById('distancediv').setAttribute('style', 'visibility:visible')
                    break;
                } else {
                    distance.disabled = "disabled";
                    distance.disabled = true;
                    document.getElementById('distancediv').setAttribute('style', 'visibility:hidden')
                }
            }
        }
        function PopulateStudents(teacherid) {
            console.log(teacherid);
            TripTrackerASPWebApp.TripTracker.ListStudents(teacherid, function (students) {
                for (var i = 0; i < students.length; i++) {

                    var rdo = document.createElement('input');
                    //radioInput.setAttribute('type', 'triptype');
                    //radioInput.setAttribute('name', students[);
                    rdo.type = "radio";
                    rdo.name = "triptyipe";
                    rdo.value = 1;
                   // opt.value = students[i].StudentID;
                  //  var id = students[i].FirstName + students[i].LastName;
                   // opt.innerHTML = id;
                   // select.appendChild(opt);
                }
              
            });
        }
        function Submit() {
            var radios = document.getElementsByName('triptype');
            var distance = document.getElementById('distance');
            var Dist = distance.value;
            for (var i = 0, length = radios.length; i < length; i++) {
                if (radios[i].checked) {
                    TripType = radios[i].value;
                    break;
                }
            }
            //console.log(Dist);
            if (!TripType) return;
            TripTrackerASPWebApp.TripTracker.Track(ID, TripType, Dist, function (message) {
                if (message > "")alert(message.toString())
                    console.log(message);
            });
        }
  </script>
</head>
<body>
	<div id="divMessage" class="errordisplay" style="display: none">
	</div>
	<form id="form1" runat="server">
            <asp:ScriptManager runat="server">
                <Services>
                    <asp:ServiceReference Path="~/TripTracker.asmx" />
                </Services>
            </asp:ScriptManager>
	<!--h1>Enter Your Trip </!--h1-->
		</form>
    <form>
  <fieldset data-role="controlgroup">
	<legend>How did you get to school today?</legend>
  <input type="radio" name="triptype" value="1" onchange="UpdateDistance()"/> Walk<br/>
  <input type="radio" name="triptype" value="2" onchange="UpdateDistance()"/> Bike<br/>
  <input type="radio" name="triptype" value="3" onchange="UpdateDistance()"/> Skate <br />
  <input type="radio" name="triptype" value="4" onchange="UpdateDistance()"/> Bus<br/>
  <input type="radio" name="triptype" value="5" onchange="UpdateDistance()"/> RTD<br/>
  <input type="radio" name="triptype" value="6" onchange="UpdateDistance()"/> Carpool <br />
  <input type="radio" name="triptype" value="7" onchange="UpdateDistance()"/> Car + Walk <br />
    </fieldset><br />
       <div id ="distancediv" style="visibility:hidden">
  Distance:
  <input type="number" id="distance" name="distance" min="1" max="500" disabled="disabled"/>
   </div>
             </form>
<!--input type="button" id="btnSubmit" value="Track" onclick="Submit()"/-->
    <div data-role="main" class="ui-content">
         <!--input type="button" class="ui-btn" id="btnSubmit" value="Track" onclick="NextPage()"/-->
         <button class="ui-btn" id="btnSubmit" value="Submit" onclick="NextPage()">Submit</button>
     </div>
</body>
</html>
