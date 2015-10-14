angular.module('TravePlannerApp.service.tripsService', ['ngResource'])
.factory('tripsService', ['$resource', ($resource) ->
  build = (a) ->
    unless a.getDays
      a.getDays = () ->
        moment.duration(moment(@.endDate) - moment(@.startDate)).asDays()
    a
  s = $resource('/trips/:id', {id: '@id'},{'update': { method:'PUT' }})
  s.buildFromArray = (arr)->
    rt = []
    (rt.push build i for i in arr)
    rt
  s

])