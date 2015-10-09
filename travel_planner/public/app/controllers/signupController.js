(function() {
  angular.module("TravePlannerApp").controller("signupController", [
    '$scope', function($scope) {
      $scope.data = {};
      return $scope.isValid = function() {
        return !!($scope.data.firstname && $scope.data.lastname && $scope.data.username && $scope.data.password && $scope.data.password_confirmation && $scope.data.email && ($scope.data.password === $scope.data.password_confirmation));
      };
    }
  ]);

}).call(this);
