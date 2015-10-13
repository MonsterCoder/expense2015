(function() {
  angular.module("TravePlannerApp.contorller.tripsController").controller("newTripController", [
    '$scope', 'trips', 'tripsService', '$state', function($scope, trips, tripsService, $state) {
      $scope.trips = trips;
      $scope.edit_trip = {};
      return $scope.save = function() {
        var t;
        t = new tripsService($scope.edit_trip);
        return t.$save().then(function(result) {
          t.id = result.trip_id;
          $scope.trips.push(t);
          return $state.go('trips');
        })["catch"](function(err) {
          console.log("!!!!");
          return console.log(err);
        });
      };
    }
  ]);

}).call(this);
