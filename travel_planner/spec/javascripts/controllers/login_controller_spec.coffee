describe "loginController", ->
  $state = {}
  $scope = {}
  $rootScope = {}
  $httpBackend = {}
  userService = {}
  $sut = {}
  beforeEach module "TravePlannerApp"
  
  beforeEach inject (_$state_,_$rootScope_, _$controller_, _$httpBackend_, $templateCache, UserProfileService) ->
      $templateCache.put "app/views/login.html", ""
      $templateCache.put "app/views/signup.html", ""
      $templateCache.put "app/views/welcome.html", ""
      $templateCache.put "app/views/trips/trips.html", ""
      $templateCache.put "app/views/trips/new_trip.html", ""
      $templateCache.put "app/views/trips/list.html", ""
      $state = _$state_
      $scope = _$rootScope_.$new()
      $scope.username = "user1"
      $scope.password = '123'
      $rootScope = _$rootScope_
      $httpBackend = _$httpBackend_
      $state.go('login')
      userService = UserProfileService
      $sut = _$controller_("loginController", {$scope: $scope, UserProfileService: userService, $stateParams: {message: 'account created'}})
      $rootScope.$apply()
  
  describe ' login failed ', ->
    beforeEach () ->
      $httpBackend.expectPOST('/auth', {username: 'user1', password: '123'}).respond(401, {message: "username password not match"})
      $scope.login()
      $httpBackend.flush()
      $rootScope.$apply()
      
    afterEach () ->
      $httpBackend.verifyNoOutstandingRequest()
      
    it " stays login page", ->
      expect($state.current.name).toBe('login')

    it " has correct error messages", ->
      expect($scope.errors).toEqual(['username password not match'])
      
  describe ' login succeed ', ->
    beforeEach () ->
      $httpBackend.expectPOST('/auth', {username: 'user1', password: '123'}).respond(200, {token: "abcdefg123456"})
      $httpBackend.expectGET('/trips').respond(200)
      $scope.login()
      $httpBackend.flush()
      $rootScope.$apply()
      
    it " saves returned token", ->
      expect(userService.token()).toEqual("abcdefg123456")
      
    it " goes to trips state", ->
      expect($state.current.name).toEqual("trips.list")
    