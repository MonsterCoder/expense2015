angular.module('TravePlannerApp')
.factory('UserProfileService', ($rootScope) ->
    setToken: (token) ->
      @token = token
    isLoggedIn: ->
      !!@token
    logout: ->
      @token = null
)
