angular.module("TravePlannerApp.contorller.tripsController")
.controller("newTripController", ['$scope', 'trips', 'tripsService', '$state', ($scope, data, tripsService, $state) ->
  $scope.trips = data.trips
  $scope.edit_trip = {}
  $scope.save = ->
    t = new tripsService($scope.edit_trip)
    t.$save()
    .then (result)->
      t.id = result.trip_id
      t.destination = $scope.edit_trip.destination
      t.startDate = $scope.edit_trip.startDate
      t.endDate = $scope.edit_trip.endDate
      t.comment = $scope.edit_trip.comment
      $scope.trips.push t
      $state.go('trips.list')
    .catch  (err) ->
      console.log "!!!!"
      console.log(err)
])