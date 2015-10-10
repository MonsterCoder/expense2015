(function() {
  angular.module("TravePlannerApp").controller("loginController", [
    '$scope', '$http', '$state', 'UserProfileService', function($scope, $http, $state, UserProfileService) {
      $scope.title = "User Login";
      return $scope.login = function() {
        return $http.post('/auth', {
          username: $scope.username,
          password: $scope.password
        }).then(function(result) {
          UserProfileService.setToken(result.data.token);
          return $state.go("trips");
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
