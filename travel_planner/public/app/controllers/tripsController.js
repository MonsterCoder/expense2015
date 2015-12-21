(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', '$state', 'tripsService', '$mdDialog', function($scope, data, $state, tripsService, $mdDialog) {
      var ev;
      $scope.trips = tripsService.buildFromArray(data.trips);
      ev = {};
      $scope.print = {};
      $scope.print.open = function() {
        return window.print();
      };
      $scope.custom_filter = {};
      $scope.filter_by = "all";
      $scope.filters = [
        {
          name: "All Expenses",
          value: "all"
        }, {
          name: "In 30 days",
          value: "30days"
        }, {
          name: "Custom filter",
          value: "custom"
        }
      ];
      $scope.filter_trips = function(trip) {
        var rt;
        switch ($scope.filter_by) {
          case "all":
            true;
            return $scope.print.description = 'all trips';
          case 'past':
            $scope.print.description = 'past trips';
            return trip.getDays() < 0;
          case 'future':
            $scope.print.description = 'future trips';
            return trip.getDays() >= 0;
          case '30days':
            $scope.print.description = 'trips in 30 days';
            return trip.getDays() >= 0 && trip.getDays() <= 30;
          case 'custom':
            rt = true;
            $scope.print.description = 'all trips';
            if ($scope.custom_filter.destination) {
              $scope.print.description = $scope.print.description + ' to destination ' + $scope.custom_filter.destination;
              if (trip.destination.indexOf($scope.custom_filter.destination) < 0) {
                rt = false;
              }
            }
            if ($scope.custom_filter.startDate) {
              $scope.print.description = $scope.print.description + ' from ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD');
              if (trip.startDate < $scope.custom_filter.startDate) {
                rt = false;
              }
            }
            if ($scope.custom_filter.endDate) {
              $scope.print.description = $scope.print.description + ' ends before ' + new moment($scope.custom_filter.endDate).format('YYYY-MM-DD');
              if (trip.endDate > $scope.custom_filter.endDate) {
                rt = false;
              }
            }
            return rt;
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
        confirm = $mdDialog.confirm(ev).title('Are you sure to delete this trip?').content('').ariaLabel('Delete trip').targetEvent(ev).ok('Confirm!').cancel('Cancel');
        return $mdDialog.show(confirm).then(function() {
          var t;
          t = new tripsService($scope.trips[idx]);
          return t.$delete().then(function() {
            $scope.trips.splice(idx, 1);
            data.trips.splice(idx, 1);
            return $state.go("trips.list", {}, {
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
