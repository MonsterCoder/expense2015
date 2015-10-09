describe("travel planner app", function() {
    var $state, $rootScope;
    
    beforeEach(module("TravePlannerApp"));
    beforeEach(inject(function(_$state_, _$rootScope_) {
        $state = _$state_;
        $rootScope = _$rootScope_;
        $rootScope.$apply();
    }));
    
    it(" defaults to login state", function() {
      expect($state.current.name).toBe('login')
    })
})