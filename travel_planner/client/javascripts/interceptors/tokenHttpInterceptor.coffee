angular.module("TravePlannerApp.interceptor.tokenHttpInterceptor", ['TravePlannerApp.service.serProfileService'])
.factory('tokenHttpInterceptor', ['UserProfileService', (UserProfileService) ->
        request: (config) ->
            if UserProfileService.isLoggedIn()
                config.headers['Authorization'] = 'Token token="' + UserProfileService.token() + '"';
            
            config;
])