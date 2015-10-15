(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', '$state', 'tripsService', '$mdDialog', function($scope, data, $state, tripsService, $mdDialog) {
      var ev;
      $scope.trips = tripsService.buildFromArray(data.trips);
      ev = {};
      $scope.custom_filter = {};
      $scope.filter_by = "all";
      $scope.filters = [
        {
          name: "All Trips",
          value: "all"
        }, {
          name: "Past Trips",
          value: "past"
        }, {
          name: "Future Trips",
          value: "future"
        }, {
          name: "Start in 30 days",
          value: "30days"
        }, {
          name: "Custom filter",
          value: "custom"
        }
      ];
      $scope.filter_trips = function(trip) {
        switch ($scope.filter_by) {
          case "all":
            return true;
          case 'past':
            return trip.getDays() < 0;
          case 'future':
            return trip.getDays() >= 0;
          case '30days':
            return trip.getDays() >= 0 && trip.getDays() <= 30;
          case 'custom':
            if ($scope.custom_filter.destination) {
              if (trip.destination.indexOf($scope.custom_filter.destination) < 0) {
                return false;
              }
            }
            if ($scope.custom_filter.startDate) {
              if (trip.startDate < $scope.custom_filter.startDate) {
                return false;
              }
            }
            if ($scope.custom_filter.endDate) {
              if (trip.endDate > $scope.custom_filter.endDate) {
                return false;
              }
            }
            return true;
          default:
            return false;
        }
      };
      $scope.predicate = 'getDays()';
      $scope.reverse = false;
      $scope.order = function(predicate) {
        $scope.reverse = $scope.predicate === predicate ? !$scope.reverse : false;
        return $scope.predicate = predicate;
      };
      $scope["delete"] = function(idx) {
        var confirm;
        confirm = $mdDialog.confirm(ev).title('Would you like to delete this trip?').content('').ariaLabel('Delete trip').targetEvent(ev).ok('Confirm!').cancel('Cancel');
        return $mdDialog.show(confirm).then(function() {
          var t;
          t = new tripsService($scope.trips[idx]);
          return t.$delete().then(function() {
            $scope.trips.splice(idx, 1);
            data.trips.splice(idx, 1);
            return $state.go("trips.list", params, {
              reload: 'trips'
            });
          });
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
