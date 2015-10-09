describe 'signup_controller', ->
  $scope = {}
  $rootScope = {}
  $sut = {}
  beforeEach module "TravePlannerApp"
  
  beforeEach inject (_$rootScope_, _$controller_) ->
      $scope = _$rootScope_.$new()
      $rootScope = _$rootScope_
      $sut = _$controller_("signupController", { $scope : $scope })
      $rootScope.$apply()
    
      
  describe ' validation ', ->
    beforeEach ->
      $scope.data.username = 'abc'
      $scope.data.firstname = 'fname'
      $scope.data.lastname = 'lname'
      $scope.data.password = '123'
      $scope.data.password_confirmation = '123'
      $scope.data.email ="m@gmail.com"
      
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