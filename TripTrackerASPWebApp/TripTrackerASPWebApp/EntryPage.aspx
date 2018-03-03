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
        var isteacher;
        var TripType;
        var isteacher;
        function OnLoad() {
            var str = window.location.href;

            theleft = str.indexOf("=") + 1;
            theright = str.lastIndexOf("&");
            ID = str.substring(theleft, str.length);
            ID = ID.replace("%20", " ");
            ID = ID.replace("%20", " "); //TODO why is this needed twice.
            console.log(ID);
            if (str.includes("teacherid")) {
                isteacher = true;
                PopulateStudents(ID);
                document.getElementById("singleform").style.display = "none"; //make this work
            }
            //document.write("Student ID is " + delineate(text));
            //ID = fullURL.substring(fullURL.indexOf('&') + 6, fullURL.length - 2)

        }
        function createRadioElement(id, value, text, name) {
            var fieldset;
            if (value == 1) {
                fieldset = document.createElement("fieldset");
                fieldset.name = id;
                fieldset.id = id;
                fieldset.legend = "How did " + name + " get to school today?";
                fieldset.datarole = "controlgroup";
                var legend = document.createElement("legend");
                legend.textContent = "How did " + name + " get to school today?";
                fieldset.appendChild(legend);
                //if (value = 1) {
                //   '<fieldset data-role="controlgroup"> <legend>How did' + id + ' get to school today?</legend>';
                //}
            }
            else {
               var fieldsets = document.getElementsByName(id);
               fieldset = fieldsets[0];
            }
            console.log(fieldset);
            var radio_home = document.getElementById("radio_home");
            var labelstudent = document.createElement("label");
            var label = document.createElement("label");
            var radio = document.createElement("input");
            radio.type = "radio";
            radio.name = "triptype";
            radio.value = value
            radio.onchange = "UpdateDistance()";
            label.appendChild(radio);
            label.appendChild(document.createTextNode(text));
            fieldset.appendChild(label);
            return fieldset;
            //return label;
        }
        function createRadioElements(id, name) { //TODO : allow one selection per line.
            var new_radio;
            console.log(name);
            new_radio = createRadioElement(id, 1, "Walk", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 2, "Bike", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 3, "Skate", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 4, "Bus", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 5, "RTD", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 6, "Carpool", name);
            radio_home.appendChild(new_radio);
            new_radio = createRadioElement(id, 7, "Car + Walk", name);
            radio_home.appendChild(new_radio);
           // var radioHtml = '<input type="radio" name="' + name + '"';
          //  radioHtml += '/> Walk<br/>';

         //   var radioFragment = document.createElement('div');
         //   radioFragment.innerHTML = radioHtml;
         //   console.log(radioHtml);
         //   return radioFragment.firstChild;
        }
        function PopulateStudents(teacherid) {
            
            var radio_home = document.getElementById("radio_home");
            var new_radio;
            TripTrackerASPWebApp.TripTracker.ListStudents(teacherid, function (students) {
                for (var i = 0; i < students.length; i++) {
                    //var rdo = document.createElement('input');
                    //radioInput.setAttribute('type', 'triptype');
                    //radioInput.setAttribute('name', students[);
                   // rdo.type = "radio";
                    //rdo.name = "triptyipe";
                    //rdo.value = 1;
                    //createRadioElement("triptype", 1);

                    createRadioElements(students[i].StudentID,students[i].FirstName + students[i].LastName);
                    // opt.value = students[i].StudentID;
                    //  var id = students[i].FirstName + students[i].LastName;
                    // opt.innerHTML = id;
                    // select.appendChild(opt);
                }

            });
        }
        function UpdateDistance() {
            //TODO just run through current fieldset
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
            var fieldsets = document.getElementsByTagName('fieldset');
            var radios, distance, Dist, id;

            console.log(fieldsets);
            for (var i = 0, length = fieldsets.length; i < length; i++) {
                id = fieldsets[i].name;
                console.log(id);
                radios = document.getElementById(id).getElementsByTagName('input');
                console.log(radios);
               // distance = document.getElementById('distance');
               // Dist = distance.value; //TODO distance
                for (var cnt = 0, rdolength = radios.length; cnt < rdolength; cnt++) {
                    if (radios[cnt].checked) {
                        console.log(radios[cnt].value)
                        TripType = radios[cnt].value;
                       break;
                    }
                }
                //console.log(Dist);
                if (TripType) {
                    console.log(id); 
                    console.log(TripType); //TODO debug why this is always on
                    TripTrackerASPWebApp.TripTracker.Track(id, TripType, Dist, function (message) { //TODO : Flip connection
                        if (message > "") alert(message.toString())
                        console.log(message);

                    });
                }
            }
        }
  </script>
</head>
<body>
	<div id="divMessage" class="errordisplay" style="display: none">
	</div>
    <div id="radio_home"> </div>

	<form id="form1" runat="server">
            <asp:ScriptManager runat="server">
                <Services>
                    <asp:ServiceReference Path="~/TripTracker.asmx" />
                </Services>
            </asp:ScriptManager>
	<!--h1>Enter Your Trip </!--h1-->
		</form>
    <form id ="singleform">
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
         <button class="ui-btn" id="btnSubmit" value="Submit" onclick="Submit()">Submit</button>
     </div>
</body>
</html>
