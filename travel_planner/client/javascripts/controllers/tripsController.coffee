angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker'])
.controller("tripsController", ['$scope', 'trips', 'tripsService', ($scope, data, tripsService) ->
  $scope.trips = data.trips
  
  $scope.delete = (idx) ->
    t = $scope.trips[idx]
    t.$delete()
    .then () ->
      $scope.trips.splice(idx, 1)
      
  $scope.add = ->
    $scope.edit_trip = {}
    
  $scope.edit = (idx) ->
    t = $scope.trips[idx]
    $scope.edit_trip = {
      id: t.id
      destination: t.destination
      startDate: t.startDate
      endDate: t.endDate
      comment: t.comment
      idx:  idx
])    



