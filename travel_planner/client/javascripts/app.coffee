 angular.module("TravePlannerApp", ['ui.router','angular-storage'])
 .config(['$urlRouterProvider','$stateProvider', ($urlRouterProvider, $stateProvider) ->
    $urlRouterProvider.otherwise("/welcome")
    
    $stateProvider
    .state('welcome',
      url : '/welcome',
      templateUrl : 'app/views/welcome.html'
    )
    .state('login',
      url : '/login',
      templateUrl : 'app/views/login.html'
      controller : 'loginController'
    )
    .state('signup',
      url : '/signup',
      templateUrl : 'app/views/signup.html',
      controller : 'signupController'
    )
 ])