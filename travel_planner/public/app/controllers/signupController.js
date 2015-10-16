(function() {
  angular.module("TravePlannerApp.contorller.signupController", []).controller("signupController", [
    '$state', '$scope', '$http', '$stateParams', 'users', function($state, $scope, $http, $stateParams, data) {
      var target;
      $scope.data = {};
      target = {};
      if ($stateParams.idx) {
        target = data.users[$stateParams.idx];
        $scope.data.username = target.username;
        $scope.data.firstname = target.firstname;
        $scope.data.lastname = target.lastname;
        $scope.data.email = target.email;
        $scope.data.id = target.id;
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
            return $state.go($stateParams.call_back || "login", {
              message: "User account has been updated successfully!"
            });
          })["catch"](function(err) {
            return $scope.errors = [err.data.message];
          });
        } else {
          $http.post('/users', {
            user: $scope.data
          }).then(function(result) {
            return $state.go($stateParams.call_back || "login", {
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
