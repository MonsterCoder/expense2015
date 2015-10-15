(function() {
  angular.module('TravePlannerApp.service.UserProfileService', ['angular-storage']).factory('UserProfileService', function($rootScope, aiStorage) {
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
      isAdmin: function() {
        return (!!this.current_user()) && (this.current_user().role === 'admin');
      },
      logout: function() {
        aiStorage.remove("currentUser");
        return _token = null;
      },
      current_user: function() {
        return _token || aiStorage.get("currentUser");
      },
      token: function() {
        if (this.current_user()) {
          return this.current_user().token;
        }
      }
    };
  });

}).call(this);
