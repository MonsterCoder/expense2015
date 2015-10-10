(function() {
  angular.module('TravePlannerApp').factory('UserService', function(store) {
    return store.getNamespacedStore('auth0');
  });

}).call(this);
