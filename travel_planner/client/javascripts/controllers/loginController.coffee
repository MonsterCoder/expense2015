angular.module("TravePlannerApp.contorller.loginController",[])
.controller("loginController",['$scope', '$http', '$state', 'UserProfileService', ($scope, $http, $state, UserProfileService) ->
  $scope.title ="User Login"

  $scope.login = ->
    $http
    .post('/auth', {username: $scope.username, password: $scope.password})
    .then (result) ->
      UserProfileService.setToken result.data.token
      $state.go("trips")
    .catch (err) ->
      $scope.errors = [err.data.message]
])