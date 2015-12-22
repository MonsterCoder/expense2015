angular.module('TravePlannerApp.service.expensesService', ['ngResource'])
.factory('expensesService', ['$resource', ($resource) ->
  build = (a) ->
    unless a.getWeek
      a.getWeek = () ->
        moment(@.startDate).week()
    a
  s = $resource('/expenses/:id', {id: '@id'},{'update': { method:'PUT' }})
  s.buildFromArray = (arr)->
    rt = []
    (rt.push build i for i in arr)
    rt
  s

])