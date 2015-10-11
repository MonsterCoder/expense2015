angular.module("TravePlannerApp.contorller.signupController",[])
.controller("signupController", ['$state', '$scope', '$http', ($state, $scope, $http)->
  $scope.data = {}
  $scope.isValid = ->
    !!($scope.data.firstname and $scope.data.lastname and $scope.data.username and $scope.data.password and $scope.data.password_confirmation and $scope.data.email and ($scope.data.password == $scope.data.password_confirmation))
  $scope.signup = ->
    $http
    .post '/users', { user: $scope.data }
    .then (result) ->
          $state.go("login")
    .catch (err)  -> 
          $scope.errors =[err.data.message]
    true
  $scope.match_password = ->
    'ng-invalid-pattern' unless $scope.data.password == $scope.data.password_confirmation
  true
    
])