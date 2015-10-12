angular.module('TravePlannerApp.service.tripsService', ['ngResource'])
.factory('tripsService', ['$resource', ($resource) ->
  $resource('/trips/:id', {id: '@id'},{'update': { method:'PUT' }})

])