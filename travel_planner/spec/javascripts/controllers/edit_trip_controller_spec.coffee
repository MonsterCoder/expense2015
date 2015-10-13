describe "eidtTripController", ->
  trips = []
  $scope = {}
  $httpBackend = {}
  tripsService = {}
  
  beforeEach module "TravePlannerApp"
  beforeEach inject (_$rootScope_, _$controller_, _$httpBackend_, _tripsService_, $templateCache) ->
    $templateCache.put "app/views/login.html", ""
    $templateCache.put "app/views/signup.html", ""
    $templateCache.put "app/views/welcome.html", ""
    $templateCache.put "app/views/trips/new_trip.html", ""
    $templateCache.put "app/views/trips/list.html", ""
    $templateCache.put "app/views/trips/trips.html", ""
    tripsService = _tripsService_
    $httpBackend = _$httpBackend_
    $httpBackend.expectPUT("/trips/2").respond(200)
    trips = [
      { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
      { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 14 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'},
    ]
    _$controller_("editTripController", {$scope: $scope, trips: {trips: trips}, $stateParams: {idx: 1}})
  
  it " edits a trip to edit", ->
    count = $scope.trips.length
    $scope.edit_trip.destination = 'abcedefe'
    $scope.save()
    $httpBackend.flush()
    expect($scope.trips.length).toEqual(count)
    expect($scope.trips[1].destination).toEqual('abcedefe')