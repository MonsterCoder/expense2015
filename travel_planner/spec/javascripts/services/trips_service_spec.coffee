describe 'tripsService', ->
    $httpBackend = {}
    tripsService = {}
    trips = []
    trip_objs = []
    
    beforeEach(module("TravePlannerApp"))
    beforeEach inject (_$httpBackend_, _tripsService_) ->
      $httpBackend = _$httpBackend_
      tripsService = _tripsService_
      trips = [
        { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
        { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 16 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'}
      ]
      trips_objs = tripsService.buildFromArray trips

      

