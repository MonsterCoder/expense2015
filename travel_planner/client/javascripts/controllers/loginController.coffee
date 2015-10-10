angular.module("TravePlannerApp")
.controller("loginController",['$scope', '$http', 'userservice', ($scope, $http, UserService) ->
  $scope.title ="User Login"
  
  $scope.login = ->
    $http
    .post('/auth', {username: $scope.username, password: $scope.password})
    .then (result) ->
      UserService.setToken result.data.token
    .catch (err) ->
      $scope.errors = [err.data.message]
])