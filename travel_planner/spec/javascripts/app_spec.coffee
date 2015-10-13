describe "travel planner app",  ->
    $state = {}
    $rootScope = {}
    beforeEach module "TravePlannerApp"
    
    beforeEach inject (_$state_, _$rootScope_, $templateCache) ->
        $templateCache.put "app/views/welcome.html", ""
        $templateCache.put "app/views/trips/trips.html", ""
        $templateCache.put "app/views/login.html", ""
        $state = _$state_
        $rootScope = _$rootScope_
        $rootScope.$apply()
    
    it " defaults to login state", ->
      expect($state.current.name).toBe('welcome')
    
    it " checks login restriction when swiching to trips state",  ->
          $rootScope.$apply(() ->
              $state.go("trips"))
              
          expect($state.current.name).toEqual("login")
          
    it " checks login restriction when swiching to trips.list state",  ->
          $rootScope.$apply(() ->
              $state.go("trips.list"))
    
          expect($state.current.name).toEqual("login")
    it " checks login restriction when swiching to trips.new_trip state",  ->
          $rootScope.$apply(() ->
              $state.go("trips.new_trip"))
  
          expect($state.current.name).toEqual("login")