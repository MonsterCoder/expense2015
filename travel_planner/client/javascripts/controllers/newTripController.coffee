angular.module("TravePlannerApp.contorller.tripsController")
.controller("newTripController", ['$scope', 'trips', 'tripsService', '$state', ($scope, trips, tripsService, $state) ->
  $scope.trips = trips
  $scope.edit_trip = {}
  $scope.save = ->
    t = new tripsService($scope.edit_trip)
    t.$save()
    .then (result)->
      t.id = result.trip_id
      $scope.trips.push t
      $state.go('trips')
    .catch  (err) ->
      console.log "!!!!"
      console.log(err)
])