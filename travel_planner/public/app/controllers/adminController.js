(function() {
  angular.module("TravePlannerApp.contorller.adminController", ['720kb.datepicker']).controller("adminController", [
    '$scope', 'users', '$state', 'usersService', '$mdDialog', function($scope, data, $state, usersService, $mdDialog) {
      var ev;
      $scope.users = data.users;
      console.log($scope.users);
      ev = {};
      $scope.print = {};
      $scope.print.open = function() {
        return window.print();
      };
      $scope.predicate = 'getDays()';
      $scope.reverse = false;
      $scope.order = function(predicate) {
        $scope.reverse = $scope.predicate === predicate ? !$scope.reverse : false;
        return $scope.predicate = predicate;
      };
      $scope["delete"] = function(idx) {
        var confirm;
        confirm = $mdDialog.confirm(ev).title('Are you sure to delete this account?').content('').ariaLabel('Delete account').targetEvent(ev).ok('Confirm!').cancel('Cancel');
        return $mdDialog.show(confirm).then(function() {
          var t;
          t = new usersService($scope.users[idx]);
          return t.$delete().then(function() {
            $scope.users.splice(idx, 1);
            data.users.splice(idx, 1);
            return $state.go("admin.list", {}, {
              reload: 'users'
            });
          });
        });
      };
      return $scope.edit = function(idx) {
        return $state.go("admin.edit_user", {
          idx: idx
        });
      };
    }
  ]);

}).call(this);
