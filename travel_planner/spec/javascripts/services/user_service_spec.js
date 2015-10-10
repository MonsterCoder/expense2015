describe("UserService", function() {
    var userProfileService
    beforeEach(module("TravePlannerApp"));
    beforeEach(inject(function(UserProfileService) {
        userProfileService = UserProfileService
    }));
    
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
            expect(userProfileService.token).toEqual('abcdefg')
        })
        
        it (" is logged in", function() {
            expect(userProfileService.isLoggedIn()).toBe(true)
        })
        
        describe( " logout", function() {
            beforeEach(function(){
                userProfileService.logout();
            })
            
            it ("returns no token", function() {
                expect(userProfileService.token).toBeNull()
            })

            it (" is logged in", function() {
                expect(userProfileService.isLoggedIn()).toBe(false)
            })
        })
    })
})