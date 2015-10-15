(function() {
  angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker']).controller("tripsController", [
    '$scope', 'trips', '$state', 'tripsService', '$mdDialog', function($scope, data, $state, tripsService, $mdDialog) {
      var ev;
      $scope.trips = tripsService.buildFromArray(data.trips);
      ev = {};
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
