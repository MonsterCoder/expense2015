describe "tripsController", ->
  trips = [
    { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
    { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 14 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'},
  ]
  $scope = {

  }
  beforeEach module "TravePlannerApp"
  beforeEach inject (_$rootScope_, _$controller_) ->
    _$controller_("tripsController", {$scope: $scope, trips: trips})
    
  it " has a list of trips", ->
    expect($scope.trips.length).toEqual(trips.length)
  