angular.module("TravePlannerApp")
.controller("loginController",['$scope', '$http', '$state', 'userservice', ($scope, $http, $state, UserService) ->
  $scope.title ="User Login"
  
  $scope.login = ->
    $http
    .post('/auth', {username: $scope.username, password: $scope.password})
    .then (result) ->
      UserService.setToken result.data.token
      $state.go("trips")
    .catch (err) ->
      $scope.errors = [err.data.message]
])