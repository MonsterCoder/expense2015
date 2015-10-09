describe 'signup_controller', ->
  $state = {}
  $scope = {}
  $rootScope = {}
  $httpBackend = {}
  $sut = {}
  beforeEach module "TravePlannerApp"
  
  beforeEach inject (_$state_,_$rootScope_, _$controller_, _$httpBackend_) ->
      $state = _$state_;
      $scope = _$rootScope_.$new()
      $rootScope = _$rootScope_
      $httpBackend = _$httpBackend_
      $sut = _$controller_("signupController", { $scope : $scope })
      $rootScope.$apply()
      
  beforeEach ->
    $state.go('signup')
    $scope.data.username = 'abc'
    $scope.data.firstname = 'fname'
    $scope.data.lastname = 'lname'
    $scope.data.password = '123'
    $scope.data.password_confirmation = '123'
    $scope.data.email ="m@gmail.com"
    $rootScope.$apply()
    
  describe ' validation ', ->
    it " is  invalid when empty", ->
      $scope.data = {}
      expect($scope.isValid()).toBe(false)
    
    it " is  valid when all fields filled", ->
        expect($scope.isValid()).toBe(true)
    
    it " requires username", ->
        $scope.data.username = ''
        expect($scope.isValid()).toBe(false)
        
    it " requires email", ->
        $scope.data.email = ''
        expect($scope.isValid()).toBe(false)

    it " requires password", ->
        $scope.data.password = ''
        expect($scope.isValid()).toBe(false) 
           
    it " requires password confirmation to match with password", ->
        $scope.data.password_confirmation = '1234'
        expect($scope.isValid()).toBe(false)
        
  describe 'signup failed', ->
    beforeEach ->
      $httpBackend.whenPOST("/users", $scope.data, (headers) ->
        expect(headers['Content-Type']).toContain('application/json')
        true
      ).respond(400,  {message: "signup failed"})
      $scope.signup()
      $httpBackend.flush()
      $rootScope.$apply()

      
    it " stay signup state", ->
      expect($state.current.name).toBe 'signup'
    
    it " have correct error message", ->
      expect($scope.errors).toEqual ["signup failed"]
      
  describe "signup succeed", ->
    beforeEach ->
      $httpBackend.whenPOST("/users", $scope.data, (headers) ->
        expect(headers['Content-Type']).toContain('application/json')
        true
      ).respond(200,  {message: "signup successful"})
      $scope.signup()
      $httpBackend.flush()
      $rootScope.$apply()
      
    it " goes to login state", ->
      expect($state.current.name).toBe 'login'
  