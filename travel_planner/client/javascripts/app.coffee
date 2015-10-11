 angular.module("TravePlannerApp", ['ui.router','TravePlannerApp.service.serProfileService','TravePlannerApp.service.tripsService','TravePlannerApp.interceptor.tokenHttpInterceptor'])
 .config(['$urlRouterProvider','$stateProvider','$httpProvider', ($urlRouterProvider, $stateProvider, $httpProvider) ->
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
    .state('trips', 
      url : '/trips'
      templateUrl: 'app/views/trips.html'
      data:
        login: true
    )
    
    $httpProvider.interceptors.push('tokenHttpInterceptor')
 ])
 .run(['$rootScope', '$state','UserProfileService', ($rootScope, $state, UserProfileService) ->
    $rootScope.$on('$stateChangeStart', (event, toState) ->
      if toState.data and toState.data.login==true and !UserProfileService.isLoggedIn()
         event.preventDefault()
         $state.go('login')
    )
    
    true
 ])