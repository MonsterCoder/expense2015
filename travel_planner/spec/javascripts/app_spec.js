describe("travel planner app", function() {
    var $state;
    
    beforeEach(module("TravePlannerApp"));
    beforeEach(inject(function(_$state_) {
        $state = _$state_;
    }));
    
    it(" defaults to login state", function() {
      expect($state.current.name).toBe('login')
    })
})