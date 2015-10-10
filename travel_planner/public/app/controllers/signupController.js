(function() {
  angular.module("TravePlannerApp").controller("signupController", [
    '$state', '$scope', '$http', function($state, $scope, $http) {
      $scope.data = {};
      $scope.isValid = function() {
        return !!($scope.data.firstname && $scope.data.lastname && $scope.data.username && $scope.data.password && $scope.data.password_confirmation && $scope.data.email && ($scope.data.password === $scope.data.password_confirmation));
      };
      $scope.signup = function() {
        console.log("*******");
        console.log($scope.data);
        $http.post('/users', {
          user: $scope.data
        }).then(function(result) {
          return $state.go("login");
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
        return true;
      };
      $scope.match_password = function() {
        if ($scope.data.password !== $scope.data.password_confirmation) {
          return 'ng-invalid-pattern';
        }
      };
      return true;
    }
  ]);

}).call(this);
