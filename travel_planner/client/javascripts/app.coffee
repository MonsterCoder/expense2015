 angular.module("TravePlannerApp", ['ui.router'])
 .config(['$urlRouterProvider','$stateProvider', ($urlRouterProvider, $stateProvider) ->
    $urlRouterProvider.otherwise("/login")
    
    $stateProvider
    .state('login',
      'url' : '/login' 
    )
    .state('signup',
      'url' : '/signup'
    )
 ])