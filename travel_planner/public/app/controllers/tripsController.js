(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', 'tripsService', function($scope, trips, tripsService) {
      $scope.trips = trips;
      $scope["delete"] = function(idx) {
        var t;
        t = $scope.trips[idx];
        return t.$delete().then(function() {
          return $scope.trips.splice(idx, 1);
        });
      };
      $scope.add = function() {
        return $scope.edit_trip = {};
      };
      $scope.edit = function(idx) {
        var t;
        t = $scope.trips[idx];
        return $scope.edit_trip = {
          id: t.id,
          destination: t.destination,
          startDate: t.startDate,
          endDate: t.endDate,
          comment: t.comment,
          idx: idx
        };
      };
      return $scope.save = function() {
        var a, t;
        t = new tripsService($scope.edit_trip);
        a = $scope.trips[$scope.edit_trip.idx];
        if (t.id) {
          return t.$update().then(function() {
            a.destination = $scope.edit_trip.destination;
            a.startDate = $scope.edit_trip.startDate;
            a.endDate = $scope.edit_trip.endDate;
            return a.comment = $scope.edit_trip.comment;
          });
        } else {
          return t.$save().then(function(result) {
            t.id = result.trip_id;
            return $scope.trips.push(t);
          })["catch"](function(err) {
            console.log("!!!!");
            return console.log(err);
          });
        }
      };
    }
  ]);

}).call(this);
