(function() {
  angular.module("TravePlannerApp.contorller.adminController", ['720kb.datepicker']).controller("adminController", [
    '$scope', 'users', '$state', 'usersService', '$mdDialog', function($scope, data, $state, usersService, $mdDialog) {
      $scope.users = data.users;
      return console.log($scope.users);
    }
  ]);

}).call(this);
