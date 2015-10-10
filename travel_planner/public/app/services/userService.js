(function() {
  angular.module('TravePlannerApp.service.serProfileService', ['angular-storage']).factory('UserProfileService', function($rootScope, aiStorage) {
    var _token;
    _token = null;
    return {
      setToken: function(token) {
        _token = token;
        return aiStorage.set("currentUser", _token);
      },
      isLoggedIn: function() {
        return !!this.token();
      },
      logout: function() {
        aiStorage.remove("currentUser");
        return _token = null;
      },
      token: function() {
        return _token || aiStorage.get("currentUser");
      }
    };
  });

}).call(this);
