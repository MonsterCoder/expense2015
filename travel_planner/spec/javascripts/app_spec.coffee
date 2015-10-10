describe "travel planner app",  ->
    $state = {}
    $rootScope = {}
    beforeEach module "TravePlannerApp"
    
    beforeEach inject (_$state_, _$rootScope_, $templateCache) ->
        $templateCache.put "app/views/welcome.html", ""
        $state = _$state_
        $rootScope = _$rootScope_
        $rootScope.$apply()
    
    it " defaults to login state", ->
      expect($state.current.name).toBe('welcome')
    
