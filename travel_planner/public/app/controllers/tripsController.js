(function() {
  angular.module("TravePlannerApp.contorller.tripsController", []).controller("tripsController", [
    '$scope', 'trips', '$http', function($scope, trips, $http) {
      $scope.trips = trips;
      return $scope["delete"] = function(idx) {
        var t;
        return t = $scope.trips[idx];
      };
    }
  ]);

}).call(this);
