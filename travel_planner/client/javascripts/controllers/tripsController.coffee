angular.module("TravePlannerApp.contorller.tripsController", [])
.controller("tripsController", ['$scope', 'trips', '$http', ($scope, trips, $http) ->
  $scope.trips = trips
  
  $scope.delete = (idx) ->
    t = $scope.trips[idx]
])



