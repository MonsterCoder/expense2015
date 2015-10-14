(function() {
  angular.module('TravePlannerApp.service.tripsService', ['ngResource']).factory('tripsService', [
    '$resource', function($resource) {
      var build, s;
      build = function(a) {
        if (!a.getDays) {
          a.getDays = function() {
            return moment.duration(moment(this.startDate) - moment(Date())).asDays();
          };
        }
        return a;
      };
      s = $resource('/trips/:id', {
        id: '@id'
      }, {
        'update': {
          method: 'PUT'
        }
      });
      s.buildFromArray = function(arr) {
        var i, j, len, rt;
        rt = [];
        for (j = 0, len = arr.length; j < len; j++) {
          i = arr[j];
          rt.push(build(i));
        }
        return rt;
      };
      return s;
    }
  ]);

}).call(this);
