angular.module("TravePlannerApp")
.controller("signupController", ['$scope', ($scope)->
  $scope.data = {}
  $scope.isValid = ->
    !!($scope.data.firstname and $scope.data.lastname and $scope.data.username and $scope.data.password and $scope.data.password_confirmation and $scope.data.email and ($scope.data.password == $scope.data.password_confirmation))
])