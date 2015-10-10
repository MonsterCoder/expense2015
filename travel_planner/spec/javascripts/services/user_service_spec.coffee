describe "user service", ->
  $state = {}
  $scope = {}
  $rootScope = {}
  $httpBackend = {}
  userService = {}
  beforeEach module "TravePlannerApp"
  
  beforeEach inject (_$state_,_$rootScope_, _$controller_, _$httpBackend_, $templateCache) ->
      $templateCache.put "app/views/login.html", ""
      $templateCache.put "app/views/signup.html", ""
      $templateCache.put "app/views/welcome.html", ""
      $state = _$state_
      $scope = _$rootScope_.$new()
      $scope.username = "user1"
      $scope.password = '123'
      $rootScope = _$rootScope_
      $httpBackend = _$httpBackend_
      $rootScope.$apply()
      
  it " has a service ", ->
    expect(userService).not.toEqual({})