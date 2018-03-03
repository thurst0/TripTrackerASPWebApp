<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page1.aspx.cs" Inherits="TripTrackerASPWebApp.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trip Tracker</title>
    <meta name="viewport" content="width=device-width, height=device-height initial-scale=1"/>
    <!--meta name="viewport" content='width=700'/-->
    <style>
        ul > li, a {
            cursor: pointer;
        }
    input, label, button {
    display:block;
    max-width: 100%;
    font-family: Arial
      
}
        </style>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    
    <script src="Scripts/angular.js"></script>
    <script src="Scripts/Script.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="Scripts/jquery-3.1.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            PopulateTeachers(); // Usually we would be passing in school here.. so forget about fixing on initial load
        });
    </script>
</head>
<body id ="service" ng-app="myModule">>
	<div id="divMessage" class="errordisplay" style="display: none">
	</div>
	<form id="form1" runat="server">
            <asp:ScriptManager runat="server">
                <Services>
                    <asp:ServiceReference Path="~/TripTracker.asmx" />
                </Services>
            </asp:ScriptManager>
	<h1>Trip Tracker </h1>
    <div class="list-group" ng-controller="myController">
		<label for="select-teacher">Select a teacher </label>
		<select id="select-teacher" ng-model="teacher" onchange="UpdateTeacher(this.value)"></select>
	</div>
	<div class="list-group">
		<label for="select-student">Select a student e </label>
		<select id="select-student" onchange="UpdateStudent(this.value)"></select>
	</div>
	</form>

     <div data-role="main" class="ui-content">
         <!--input type="button" class="ui-btn" id="btnSubmit" value="Track" onclick="NextPage()"/-->
         <button class="ui-btn" id="btnSubmit" value="Track" onclick="NextPage()">Track</button>
     </div>

    <div ng-controller="myController">
    <div class="container">
        <br />
        <div class="row">
            <div class="col-md-2">PageSize:
                <select ng-model="entryLimit" class="form-control">
                    <option selected ="selected">5</option>
                    <option>10</option>
                    <option>20</option>
                    <option>50</option>
                    <option>100</option>
                </select>
            </div>
            <div class="col-md-3">Filter:
                <input type="text" ng-model="search" ng-change="filter()" placeholder="Filter" class="form-control" />
            </div>
            <div class="col-md-4">
                <h5>Filtered {{ filtered.length }} of {{totalItems}} total records</h5>
            </div>
        </div>
        <br />
        <div class="row">
                <div class="col-md-12" ng-show="filteredItems > 0">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>First Name&nbsp;<a ng-click="sort_by('FistName');"><i class="glyphicon glyphicon-sort"></i></a></th>
                                <th>Last Name&nbsp;<a ng-click="sort_by('LastName');"><i class="glyphicon glyphicon-sort"></i></a></th>
                                <th>ID&nbsp;<a ng-click="sort_by('ID');"><i class="glyphicon glyphicon-sort"></i></a></th>
                                </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="data in filtered = (students | filter:{ search } | orderBy : predicate :reverse) | startFrom:(currentPage-1)*entryLimit | limitTo:entryLimit">
                                <td>{{data.FirstName}}</td>
                                <td>{{data.LastName}}</td>
                                <td>{{data.ID}}</td>
                               
                            </tr>
                        </tbody>
                    </table>
                    </div>
                    <div class="col-md-12" ng-show="filteredItems == 0">
                        <div class="col-md-12">
                            <h4>No students found</h4>
                        </div>
                    </div>
                    <div class="col-md-12" ng-show="filteredItems > 0">
                           PUT PAGES HERE MISSING angular.min.js
                        <span>
                            <svg width="250" height="250" style="border: solid 1px gray">
                                <rect x="0" y="0" fill ="black"width="100" height="30"/>

                            </svg>
                        </span>
                        <div pagination="" page="currentPage" on-select-page="setPage(page)" boundary-links="true" total-items="filteredItems" items-per-page="entryLimit" class="pagination-small" previous-text="&laquo;" next-text="&raquo;"></div>
                    </div>
                </div>
       </div>
    </div>
</body>
</html>
