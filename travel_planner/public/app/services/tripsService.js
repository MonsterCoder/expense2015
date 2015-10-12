(function() {
  angular.module('TravePlannerApp.service.tripsService', ['ngResource']).factory('tripsService', [
    '$resource', function($resource) {
      return $resource('/trips/:id', {
        id: '@id'
      }, {
        'update': {
          method: 'PUT'
        }
      });
    }
  ]);

}).call(this);
