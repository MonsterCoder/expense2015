angular.module('TravePlannerApp.service.UserProfileService', ['angular-storage'])
.factory('UserProfileService', ($rootScope, aiStorage) ->
    _token = null
    setToken: (token) ->
      _token = token
      aiStorage.set("currentUser", _token)
    isLoggedIn: ->
      !!@token()
    logout: ->
      aiStorage.remove("currentUser")
      _token = null
    token: ->
      _token ||  aiStorage.get("currentUser")
)
