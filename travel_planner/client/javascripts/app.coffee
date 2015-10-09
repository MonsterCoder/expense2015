 angular.module("TravePlannerApp", ['ui.router'])
 .config(['$urlRouterProvider','$stateProvider', ($urlRouterProvider, $stateProvider) ->
    $urlRouterProvider.otherwise("/login")
    
    $stateProvider
    .state('login',
      url : '/login',
      templateUrl : 'app/views/login.html'
    )
    .state('signup',
      url : '/signup',
      templateUrl : 'app/views/signup.html'
    )
 ])