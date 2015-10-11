(function() {
  angular.module("TravePlannerApp.interceptor.tokenHttpInterceptor", ['TravePlannerApp.service.serProfileService']).factory('tokenHttpInterceptor', [
    'UserProfileService', function(UserProfileService) {
      return {
        request: function(config) {
          if (UserProfileService.isLoggedIn()) {
            config.headers['Authorization'] = 'Token token="' + UserProfileService.token() + '"';
          }
          return config;
        }
      };
    }
  ]);

}).call(this);
