angular.module('TravePlannerApp.service.usersService', ['ngResource'])
.factory('usersService', ['$resource', ($resource) ->
  $resource('/users/:id', {id: '@id'},{'update': { method:'PUT' }})

])