(function() {
  angular.module("TravePlannerApp.contorller.signupController", []).controller("signupController", [
    '$state', '$scope', '$http', '$stateParams', 'users', function($state, $scope, $http, $stateParams, data) {
      var return_state, target;
      $scope.labels = {
        title: "New Account",
        action: "Sign Up!"
      };
      $scope.data = {};
      target = {};
      if ($stateParams.idx) {
        $scope.labels.title = "Edit Account";
        target = data.users[$stateParams.idx];
        $scope.data.username = target.username;
        $scope.data.firstname = target.firstname;
        $scope.data.lastname = target.lastname;
        $scope.data.email = target.email;
        $scope.data.id = target.id;
      }
      return_state = "login";
      if ($stateParams.call_back) {
        return_state = $stateParams.call_back;
        $scope.labels.action = " Save";
      }
      $scope.isValid = function() {
        return !!($scope.data.firstname && $scope.data.lastname && $scope.data.username && $scope.data.password && $scope.data.password_confirmation && $scope.data.email && ($scope.data.password === $scope.data.password_confirmation));
      };
      $scope.signup = function() {
        if ($stateParams.idx) {
          $http.put('/users/' + $scope.data.id, {
            user: $scope.data
          }).then(function(result) {
            target.username = $scope.data.username;
            target.firstname = $scope.data.firstname;
            target.lastname = $scope.data.lastname;
            target.email = $scope.data.email;
            return $state.go(return_state, {
              message: "User account has been updated successfully!"
            });
          })["catch"](function(err) {
            return $scope.errors = [err.data.message];
          });
        } else {
          $http.post('/users', {
            user: $scope.data
          }).then(function(result) {
            return $state.go(return_state, {
              message: "User account has been created successfully!"
            });
          })["catch"](function(err) {
            return $scope.errors = [err.data.message];
          });
        }
        return true;
      };
      $scope.cancel = function() {
        return $state.go($stateParams.call_back || "welcome");
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
