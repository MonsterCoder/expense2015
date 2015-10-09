angular.module("TravePlannerApp")
.controller("signupController", ['$state', '$scope', '$http', ($state, $scope, $http)->
  $scope.data = {}
  $scope.isValid = ->
    !!($scope.data.firstname and $scope.data.lastname and $scope.data.username and $scope.data.password and $scope.data.password_confirmation and $scope.data.email and ($scope.data.password == $scope.data.password_confirmation))
  $scope.signup = ->
    $http
    .post '/users', 
        username: $scope.data.username
        password: $scope.data.password
        password_confirmation: $scope.data.password_confirmation
        firstname: $scope.data.firstname
        lastname: $scope.data.lastname
        email: $scope.data.email
    .then (result) ->
          $state.go("login")
    .catch (err)  -> 
          $scope.errors =[err.data.message]
    
])