angular.module('TravePlannerApp')
.factory('UserService', () ->
   store.getNamespacedStore('auth0')
)
