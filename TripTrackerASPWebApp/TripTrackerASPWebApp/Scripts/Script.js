var app = angular
    .module("myModule", []);
   // .controller("myController", myController);

    app.filter('startFrom', function () {
    return function(input, start) {
        if(input) {
            start = +start; //parse to int
            return input.slice(start);
        }
        return [];
    }
    });
    app.controller('myController', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
        var vm = this;
        vm.isBusy = true;
        vm.LoadTripSum = function ($scope, $http, $timeout) {
            $http.get("TripTracker.asmx/ListTripSum")
            .then(function (data) {
                $scope.tripsums = data.data;

                console.log("test");
                $scope.list = data.data;
                $scope.currentPage = 1; //current page
                $scope.entryLimit = 5; //max no of items to display in a page
                $scope.filteredItems = $scope.list.length; //Initially for no filter  
                $scope.totalItems = $scope.list.length;
                console.log($scope.list);
            }).finally(function () {
                vm.isBusy = false;
            });
            $scope.setPage = function (pageNo) {
                $scope.currentPage = pageNo;
            };
            $scope.filter = function () {
                $timeout(function () {
                    console.log($scope);
                    $scope.filteredItems = $scope.filtered.length;
                }, 10);
            };
            $scope.sort_by = function (predicate) {
                $scope.predicate = predicate;
                $scope.reverse = !$scope.reverse;
            };
        }
        vm.LoadStudents = function (teacherid) {
            //$http({
              //  url: "TripTracker.asmx/ListStudents",
                //method: "GET"
               // ,data :{vTeacher:teacherid}
                //,params: { vTeacher: teacherid }
            // }) // 
            var data = {
                vTeacher : teacherid
               };
            $http.get("TripTracker.asmx/ListTripSum", data)
       
         .then(function (data) {
             $scope.students = data.data;

             console.log("students");
             //TripTrackerASPWebApp.TripTracker.ListStudents(teacherid, function (students) {

             $scope.list = data.data;
             $scope.currentPage = 1; //current page
             // $scope.entryLimit = 20; //max no of items to display in a page
             $scope.filteredItems = $scope.list.length; //Initially for no filter  
             $scope.totalItems = $scope.list.length;
             console.log($scope.list);
         });
            $scope.setPage = function (pageNo) {
                $scope.currentPage = pageNo;
            };
            $scope.filter = function () {
                $timeout(function () {
                    console.log($scope);
                    $scope.filteredItems = $scope.filtered.length;
                }, 10);
            };
            $scope.sort_by = function (predicate) {
                $scope.predicate = predicate;
                $scope.reverse = !$scope.reverse;
            };
        }
        $scope.$watch('teacher', function (data) {
            $http.get("TripTracker.asmx/ListTripSum", data)
       .then(function (data) {
           $scope.students = data.data;

           console.log("students");
           //TripTrackerASPWebApp.TripTracker.ListStudents(teacherid, function (students) {

           $scope.list = data.data;
           $scope.currentPage = 1; //current page
           // $scope.entryLimit = 20; //max no of items to display in a page
           $scope.filteredItems = $scope.list.length; //Initially for no filter  
           $scope.totalItems = $scope.list.length;
           console.log($scope.list);
       });
        });

    }]);

 //myController.$inject = ['$scope'];
// app.controller('myController', myController);

 //myController.prototype.LoadStudents = function () {
 //  
// }
var studentID;
var teacherID;
function PopulateStudents(teacherid) {
    UpdateTeacher(teacherid);
   (new myController()).LoadStudents(teacherid)
}
function UpdateStudent(id) {
    studentID = id;
    //console.log(studentID);
}
function UpdateTeacher(id) {
    TeacherID = id;
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
        console.log("HI");
        for (var i = 0; i < teachers.length; i++) {
            var opt = document.createElement('option');
            opt.value = teachers[i].FullName;
            opt.innerHTML = opt.value;
            select.appendChild(opt);
            select.size = teachers.length;
        }

    });
}