angular.module('TravePlannerApp.service.tripsService', ['ngResource'])
.factory('tripsService', ['$resource', ($resource) ->
  $resource('/trips')
])