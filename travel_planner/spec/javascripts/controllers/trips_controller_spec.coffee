describe "tripsController", ->
  trips = [
    { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
    { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 14 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'},
  ]
  $scope = {}
  $httpBackend = {}
  
  beforeEach module "TravePlannerApp"
  beforeEach inject (_$rootScope_, _$controller_, _$httpBackend_, $templateCache) ->
    $templateCache.put "app/views/login.html", ""
    $templateCache.put "app/views/signup.html", ""
    $templateCache.put "app/views/welcome.html", ""
    $templateCache.put "app/views/trips.html", ""
    _$controller_("tripsController", {$scope: $scope, trips: trips})
    $httpBackend = _$httpBackend_
    
  it " has a list of trips", ->
    expect($scope.trips.length).toEqual(trips.length)
  
  it " removes a trip to list", -> 
    $httpBackend.whenDELETE('/trips/1').respond(200, {message: "trip deleted" })
    $scope.delete(0)
    $httpBackend.flush()
    expect($scope.trips.length).toEqual(trips.length - 1)
    
  xit " adds a trip to list", ->
    new_trip = {  destination: 'city3', startDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 3'}
    $httpBackend.whenPOST('/trips', new_trip).respond(200, {message: "trip created", trip_id: 9 })
    expect($scope.trips.length).toEqual(trips.length + 1)
    #expect($scope.trips[3].id).toEqual(9))
    
     