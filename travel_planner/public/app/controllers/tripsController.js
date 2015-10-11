(function() {
  angular.module("TravePlannerApp.contorller.tripsController", []).controller("tripsController", [
    '$scope', 'trips', function($scope, trips) {
      var Trip, _trips, json;
      Trip = (function() {
        function Trip(json) {
          this.id = json.id;
          this.destination = json.destination;
          this.startDate = moment(json.startDate);
          this.endDate = moment(json.endDate);
          this.comment = json.comment;
        }

        return Trip;

      })();
      _trips = (function() {
        var i, len, results;
        results = [];
        for (i = 0, len = trips.length; i < len; i++) {
          json = trips[i];
          results.push(new Trip(json));
        }
        return results;
      })();
      return $scope.trips = trips;
    }
  ]);

}).call(this);
