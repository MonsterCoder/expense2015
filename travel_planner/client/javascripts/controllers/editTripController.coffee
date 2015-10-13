angular.module("TravePlannerApp.contorller.tripsController")
.controller("editTripController", ['$scope', 'trips', 'tripsService', '$stateParams','$state', ($scope, data, tripsService,$stateParams, $state) ->
  $scope.trips = data.trips
  idx =$stateParams.idx
  t = $scope.trips[idx]
  $scope.edit_trip = {
    id: t.id
    destination: t.destination
    startDate: t.startDate
    endDate: t.endDate
    comment: t.comment
  }
  
  $scope.save = ->
    u = new tripsService($scope.edit_trip)
    u.$update()
    .then ->
      t.destination = $scope.edit_trip.destination
      t.startDate = $scope.edit_trip.startDate
      t.endDate = $scope.edit_trip.endDate
      t.comment = $scope.edit_trip.comment
      $state.go('trips.list')
])
   