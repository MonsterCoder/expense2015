(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', 'tripsService', function($scope, data, tripsService) {
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
    }
  ]);

}).call(this);
