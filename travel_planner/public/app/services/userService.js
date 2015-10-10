(function() {
  angular.module('TravePlannerApp').factory('UserProfileService', function($rootScope) {
    return {
      setToken: function(token) {
        return this.token = token;
      },
      isLoggedIn: function() {
        return !!this.token;
      },
      logout: function() {
        return this.token = null;
      }
    };
  });

}).call(this);
