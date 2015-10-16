describe("tokenHttpIntercepter", function() {
    var $httpProvider, $httpBackend, UserProfileService, tripsService;
    beforeEach(module('TravePlannerApp', function(_$httpProvider_) {
         $httpProvider = _$httpProvider_;
    }))

    beforeEach(inject(function(_UserProfileService_, _$httpBackend_, $templateCache, _tripsService_){
        $templateCache.put("app/views/welcome.html", "")
        $templateCache.put("app/views/trips.html", "")
        $templateCache.put("app/views/login.html", "")
        UserProfileService = _UserProfileService_;
        $httpBackend =_$httpBackend_;
        tripsService = _tripsService_;
    }))
    
    it (" registers token http interceptor ", function() {
        expect($httpProvider.interceptors).toContain("tokenHttpInterceptor");
    })
    
    it ("  not places token in request header if no stored token", function() {
        UserProfileService.logout();
        $httpBackend.when('GET', /trips/, null, function(header) {
            expect(header.Authentication).toBeUndefined();
            return true
        }).respond(401,'');
        tripsService.get()
        $httpBackend.flush();
    })
    
    it (" sets token in request header if a stored token exists", function() {
        UserProfileService.setToken({role: 'user', token: 123456});

        $httpBackend.when('GET', /trips/, null, function(headers) {
             expect(headers.Authorization).toEqual("Token token=\"123456\"");
             return true;
        }).respond(200,'');
        tripsService.get()
        $httpBackend.flush();
    })
})