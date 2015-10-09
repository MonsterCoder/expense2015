(function() {
  angular.module("TravePlannerApp").controller("signupController", [
    '$state', '$scope', '$http', function($state, $scope, $http) {
      $scope.data = {};
      $scope.isValid = function() {
        return !!($scope.data.firstname && $scope.data.lastname && $scope.data.username && $scope.data.password && $scope.data.password_confirmation && $scope.data.email && ($scope.data.password === $scope.data.password_confirmation));
      };
      return $scope.signup = function() {
        return $http.post('/users', {
          username: $scope.data.username,
          password: $scope.data.password,
          password_confirmation: $scope.data.password_confirmation,
          firstname: $scope.data.firstname,
          lastname: $scope.data.lastname,
          email: $scope.data.email
        }).then(function(result) {
          return $state.go("login");
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
