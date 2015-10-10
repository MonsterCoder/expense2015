angular.module('TravePlannerApp')
.factory('UserService', (store) ->
   store.getNamespacedStore('auth0')
)
