angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker'])
.controller("tripsController", ['$scope', 'trips', '$state', 'tripsService', ($scope, data, $state, tripsService) ->
  $scope.trips = tripsService.buildFromArray data.trips
  console.log $scope.trips
  $scope.delete = (idx) ->
    t = new tripsService($scope.trips[idx])
    console.log t
    t.$delete()
    .then () ->
      $scope.trips.splice(idx, 1)
      
  $scope.add = ->
    $scope.edit_trip = {}
    
  $scope.edit = (idx) ->
    $state.go("trips.edit_trip", {idx : idx})
])    



