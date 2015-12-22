angular.module("TravePlannerApp.contorller.loginController",[])
.controller("loginController",['$scope', '$http', '$state', 'UserProfileService','$stateParams', ($scope, $http, $state, UserProfileService, $stateParams) ->
  $scope.title ="User Login"
  $scope.message = $stateParams.message 
  $scope.login = ->
    $http
    .post('/auth', {username: $scope.username, password: $scope.password})
    .then (result) ->
      UserProfileService.setToken result.data
      if UserProfileService.isAdmin()
        $state.go("admin.list")
      else
        $state.go("expenses.list")
    .catch (err) ->
      console.log "!!!!"
      console.log err
      message =  if err.data then err.data.message else err.message
      $scope.errors = [message]
])