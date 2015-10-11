(function() {
  angular.module("TravePlannerApp.interceptor", ['TravePlannerApp.service.UserProfileService']).factory('tokenHttpInterceptor', [
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
