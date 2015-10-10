(function() {
  angular.module("TravePlannerApp").controller("loginController", [
    '$scope', '$http', 'userservice', function($scope, $http, userservice) {
      $scope.title = "User Login";
      return $scope.login = function() {
        return $http.post('/auth', {
          username: $scope.username,
          password: $scope.password
        }).then(function(result) {
          return userservice.setToken(result.data.token);
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
