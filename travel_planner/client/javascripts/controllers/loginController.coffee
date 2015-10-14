angular.module("TravePlannerApp.contorller.loginController",[])
.controller("loginController",['$scope', '$http', '$state', 'UserProfileService','$stateParams', ($scope, $http, $state, UserProfileService, $stateParams) ->
  $scope.title ="User Login"
  $scope.message = $stateParams.message 
  $scope.login = ->
    $http
    .post('/auth', {username: $scope.username, password: $scope.password})
    .then (result) ->
      UserProfileService.setToken result.data.token
      $state.go("trips.list")
    .catch (err) ->
      $scope.errors = [err.data.message]
])