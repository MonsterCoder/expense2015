describe("UserService", function() {
    var userProfileService, aiStorage
    beforeEach(module("TravePlannerApp"));
    beforeEach(inject(function(UserProfileService, _aiStorage_) {
        userProfileService = UserProfileService
        aiStorage =_aiStorage_;
    }));
    
    afterEach(function() {
        userProfileService.logout();
    })
    
    it(" has user service", function() {
        expect(userProfileService).toBeDefined();
    })
    
    it( "not logged initially", function() {
        expect(userProfileService.isLoggedIn()).toBeFalsy();
    })
    
    describe("login", function() {
        beforeEach(function() {
            userProfileService.setToken("abcdefg");
        })
        
        it ("returns correct token", function() {
            expect(userProfileService.token()).toEqual('abcdefg')
        })
        
        it (" is logged in", function() {
            expect(userProfileService.isLoggedIn()).toBe(true)
        })
        
        describe( " logout", function() {
            beforeEach(function(){
                userProfileService.logout();
            })
            
            it ("returns no token", function() {
                expect(userProfileService.token()).toBeNull()
            })

            it (" is logged in", function() {
                expect(userProfileService.isLoggedIn()).toBe(false)
            })
        })
    })
    
    describe("persisitence", function() {
        beforeEach(function() {
            aiStorage.set("currentUser", "abc");
        })
        
        it ("returns correct token", function() {
            expect(userProfileService.token()).toEqual('abc')
        })
        
        it (" is logged in", function() {
            expect(userProfileService.isLoggedIn()).toBe(true)
        })
    })
    

})