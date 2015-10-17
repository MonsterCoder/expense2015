(function() {
  angular.module("TravePlannerApp.contorller.tripsController").controller("newTripController", [
    '$scope', 'trips', 'tripsService', '$state', function($scope, data, tripsService, $state) {
      $scope.trips = data.trips;
      $scope.edit_trip = {};
      $scope.onStartDateChanged = function() {
        var sdate;
        sdate = moment($scope.edit_trip.startDate);
        if (sdate.isValid() && !$scope.edit_trip.endDate) {
          return $scope.edit_trip.endDate = $scope.edit_trip.startDate;
        }
      };
      $scope.dateValidate = function() {
        return $scope.edit_trip.endDate < $scope.edit_trip.startDateDate;
      };
      return $scope.save = function() {
        var t;
        t = new tripsService($scope.edit_trip);
        return t.$save().then(function(result) {
          t.id = result.trip_id;
          t.destination = $scope.edit_trip.destination;
          t.startDate = $scope.edit_trip.startDate;
          t.endDate = $scope.edit_trip.endDate;
          t.comment = $scope.edit_trip.comment;
          data.trips.push(t);
          return $state.go('trips.list');
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
