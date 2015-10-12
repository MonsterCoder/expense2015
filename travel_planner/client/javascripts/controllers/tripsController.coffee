angular.module("TravePlannerApp.contorller.tripsController", [])
.controller("tripsController", ['$scope', 'trips', 'tripsService', ($scope, trips, tripsService) ->
  $scope.trips = trips
  
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
    }
    
  $scope.save = ->
    t = new tripsService($scope.edit_trip)
    a = $scope.trips[$scope.edit_trip.idx]
    if t.id
      t.$update()
      .then ->
        a.destination = $scope.edit_trip.destination
        a.startDate = $scope.edit_trip.startDate
        a.endDate = $scope.edit_trip.endDate
        a.comment = $scope.edit_trip.comment
    else
      t.$save()
      .then (result)->
        t.id = result.trip_id
        $scope.trips.push t
      .catch  (err) ->
        console.log "!!!!"
        console.log(err)
])    



