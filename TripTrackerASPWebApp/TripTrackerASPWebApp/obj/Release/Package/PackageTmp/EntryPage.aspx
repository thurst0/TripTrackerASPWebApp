<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntryPage.aspx.cs" Inherits="TripTrackerASPWebApp.EntryPage" %>
<%@ PreviousPageType VirtualPath="~/Page1.aspx" %> 
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
        function OnLoad() {
            var str = window.location.href;
                theleft = str.indexOf("=") + 1;
                theright = str.lastIndexOf("&");
                ID = str.substring(theleft, str.length);
                console.log(ID);
            
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
