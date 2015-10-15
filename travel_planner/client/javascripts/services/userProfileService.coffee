angular.module('TravePlannerApp.service.UserProfileService', ['angular-storage'])
.factory('UserProfileService', ($rootScope, aiStorage) ->
    _token = null
    setToken: (token) ->
      _token = token
      aiStorage.set("currentUser", _token)
    isLoggedIn: ->
      !!@token()
    isAdmin: ->
      (!!@current_user()) and (@current_user().role == 'admin')
    logout: ->
      aiStorage.remove("currentUser")
      _token = null
    current_user: ->
      _token ||  aiStorage.get("currentUser")
    token: ->
      @current_user().token if @current_user()
)
