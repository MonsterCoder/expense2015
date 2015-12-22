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
          UserProfileService.setToken(result.data);
          if (UserProfileService.isAdmin()) {
            return $state.go("admin.list");
          } else {
            return $state.go("expenses.list");
          }
        })["catch"](function(err) {
          var message;
          console.log("!!!!");
          console.log(err);
          message = err.data ? err.data.message : err.message;
          return $scope.errors = [message];
        });
      };
    }
  ]);

}).call(this);
