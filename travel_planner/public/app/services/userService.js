(function() {
  angular.module('TravePlannerApp').factory('UserService', function() {
    return store.getNamespacedStore('auth0');
  });

}).call(this);
