angular.module("TravePlannerApp.contorller.tripsController", [])
.controller("tripsController", ['$scope', 'trips', ($scope, trips) ->
  _trips = (new Trip(json) for json in trips)
  $scope.trips = trips
])

class Trip
  constructor: (json) ->
    @id = json.id
    @destination = json.destination
    @startDate = moment(json.startDate)
    @endDate = moment(json.endDate)
    @comment = json.comment


