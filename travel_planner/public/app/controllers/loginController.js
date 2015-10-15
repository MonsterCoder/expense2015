(function() {
  angular.module("TravePlannerApp.contorller.loginController", []).controller("loginController", [
    '$scope', '$http', '$state', 'UserProfileService', '$stateParams', function($scope, $http, $state, UserProfileService, $stateParams) {
      $scope.title = "User Login";
      $scope.message = $stateParams.message;
      return $scope.login = function() {
        return $http.post('/auth', {
          username: $scope.username,
          password: $scope.password
        }).then(function(result) {
          UserProfileService.setToken(result.data.token);
          return $state.go("trips.list");
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
