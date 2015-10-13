(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', '$state', 'tripsService', function($scope, data, $state, tripsService) {
      $scope.trips = data.trips;
      $scope["delete"] = function(idx) {
        var t;
        t = new tripsService($scope.trips[idx]);
        console.log(t);
        return t.$delete().then(function() {
          return $scope.trips.splice(idx, 1);
        });
      };
      $scope.add = function() {
        return $scope.edit_trip = {};
      };
      return $scope.edit = function(idx) {
        return $state.go("trips.edit_trip", {
          idx: idx
        });
      };
    }
  ]);

}).call(this);
