(function() {
  angular.module("TravePlannerApp", ['ui.router', 'TravePlannerApp.service.serProfileService', 'TravePlannerApp.service.tripsService', 'TravePlannerApp.interceptor.tokenHttpInterceptor']).config([
    '$urlRouterProvider', '$stateProvider', '$httpProvider', function($urlRouterProvider, $stateProvider, $httpProvider) {
      $urlRouterProvider.otherwise("/welcome");
      $stateProvider.state('welcome', {
        url: '/welcome',
        templateUrl: 'app/views/welcome.html'
      }).state('login', {
        url: '/login',
        templateUrl: 'app/views/login.html',
        controller: 'loginController'
      }).state('signup', {
        url: '/signup',
        templateUrl: 'app/views/signup.html',
        controller: 'signupController'
      }).state('trips', {
        url: '/trips',
        templateUrl: 'app/views/trips.html',
        data: {
          login: true
        }
      });
      return $httpProvider.interceptors.push('tokenHttpInterceptor');
    }
  ]).run([
    '$rootScope', '$state', 'UserProfileService', function($rootScope, $state, UserProfileService) {
      $rootScope.$on('$stateChangeStart', function(event, toState) {
        if (toState.data && toState.data.login === true && !UserProfileService.isLoggedIn()) {
          event.preventDefault();
          return $state.go('login');
        }
      });
      return true;
    }
  ]);

}).call(this);
