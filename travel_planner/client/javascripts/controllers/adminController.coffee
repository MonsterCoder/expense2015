angular.module("TravePlannerApp.contorller.adminController", ['720kb.datepicker'])
.controller("adminController", ['$scope', 'users', '$state', 'usersService', '$mdDialog', ($scope, data, $state, usersService, $mdDialog) ->
  $scope.users = data.users
  console.log $scope.users
])