 angular.module("TravePlannerApp", ['ui.router','TravePlannerApp.interceptor', 'TravePlannerApp.service.UserProfileService', 'TravePlannerApp.service.tripsService','TravePlannerApp.contorllers'])
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
      templateUrl: 'app/views/trips/trips.html'
      data:
        login: true
      resolve: 
        trips: [ 'tripsService', (tripsService) ->
          tripsService.get().$promise
        ]   
    )
    .state('trips.list',
      url : '/'
      templateUrl: 'app/views/trips/list.html'
    )
    .state('trips.new_trip',
      url : '/new'
      templateUrl: 'app/views/trips/new_trip.html'
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