(function() {
  angular.module('TravePlannerApp.service.usersService', ['ngResource']).factory('usersService', [
    '$resource', function($resource) {
      return $resource('/users/:id', {
        id: '@id'
      }, {
        'update': {
          method: 'PUT'
        }
      });
    }
  ]);

}).call(this);
