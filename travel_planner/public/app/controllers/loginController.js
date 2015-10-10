(function() {
  angular.module("TravePlannerApp").controller("loginController", [
    '$scope', '$http', '$state', 'userservice', function($scope, $http, $state, UserService) {
      $scope.title = "User Login";
      return $scope.login = function() {
        return $http.post('/auth', {
          username: $scope.username,
          password: $scope.password
        }).then(function(result) {
          UserService.setToken(result.data.token);
          return $state.go("trips");
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
