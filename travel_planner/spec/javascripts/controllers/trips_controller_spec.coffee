describe "tripsController", ->
  trips = []
  $scope = {}
  $httpBackend = {}
  tripsService = {}
  
  beforeEach module "TravePlannerApp"
  beforeEach inject (_$rootScope_, _$controller_, _$httpBackend_, _tripsService_, $templateCache) ->
    $templateCache.put "app/views/login.html", ""
    $templateCache.put "app/views/signup.html", ""
    $templateCache.put "app/views/welcome.html", ""
    $templateCache.put "app/views/trips/trips.html", ""
    tripsService = _tripsService_
    $httpBackend = _$httpBackend_
    trips = [
      new tripsService { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
      new tripsService { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 14 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'},
    ]
    _$controller_("tripsController", {$scope: $scope, trips: trips})
    
  it " has a list of trips", ->
    expect($scope.trips.length).toEqual(trips.length)
  
  it " removes a trip to list", -> 
    count = $scope.trips.length
    $httpBackend.whenDELETE('/trips/1').respond(200, {message: "trip deleted" })
    $scope.delete(0)
    $httpBackend.flush()
    expect($scope.trips.length).toEqual(count - 1)
    
  it " save a  trip", ->
    count = $scope.trips.length
    $scope.edit_trip = {  destination: 'city3', startDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 3'}
    $httpBackend.whenPOST('/trips').respond(200, {message: "trip created", trip_id: 9 })
    $scope.save()
    $httpBackend.flush()
    expect($scope.trips.length).toEqual(count + 1)
    expect($scope.trips[count].id).toEqual(9)
    
  it " adds an empty trip", ->
    $scope.edit_trip = {  destination: 'city3', startDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 3'}
    $scope.add()
    expect($scope.edit_trip).toEqual({})
    
  it " edits a trip to edit", ->
    count = $scope.trips.length
    $httpBackend.whenPUT('/trips/1').respond(200, {message: "trip updated"})
    $scope.edit(0)
    $scope.edit_trip.destination = 'abcedefe'
    $scope.save()
    $httpBackend.flush()
    expect($scope.trips.length).toEqual(count)
    expect($scope.trips[0].destination).toEqual('abcedefe')
    
     