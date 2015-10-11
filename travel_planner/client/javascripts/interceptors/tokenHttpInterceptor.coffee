angular.module("TravePlannerApp.interceptor", ['TravePlannerApp.service.UserProfileService'])
.factory('tokenHttpInterceptor', ['UserProfileService', (UserProfileService) ->
        request: (config) ->
            if UserProfileService.isLoggedIn()
                config.headers['Authorization'] = 'Token token="' + UserProfileService.token() + '"';
            
            config;
])