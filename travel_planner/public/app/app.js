(function() {
  angular.module("TravePlannerApp", ['ui.router', '720kb.datepicker', 'TravePlannerApp.interceptor', 'TravePlannerApp.service.UserProfileService', 'TravePlannerApp.service.tripsService', 'TravePlannerApp.contorllers', 'ngMaterial']).config([
    '$urlRouterProvider', '$stateProvider', '$httpProvider', '$mdThemingProvider', function($urlRouterProvider, $stateProvider, $httpProvider, $mdThemingProvider) {
      $urlRouterProvider.when("/trips", "/trips/list");
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
        templateUrl: 'app/views/trips/trips.html',
        data: {
          login: true
        },
        resolve: {
          trips: [
            'tripsService', function(tripsService) {
              return tripsService.get().$promise;
            }
          ]
        }
      }).state('trips.list', {
        url: '/',
        templateUrl: 'app/views/trips/list.html',
        data: {
          login: true
        },
        controller: 'tripsController'
      }).state('trips.new_trip', {
        url: '/new',
        data: {
          login: true
        },
        templateUrl: 'app/views/trips/new_trip.html',
        controller: 'newTripController'
      }).state('trips.edit_trip', {
        url: '/edit/:idx',
        data: {
          login: true
        },
        templateUrl: 'app/views/trips/new_trip.html',
        controller: 'editTripController'
      });
      $httpProvider.interceptors.push('tokenHttpInterceptor');
      return $mdThemingProvider.theme('default').primaryPalette('pink').accentPalette('orange');
    }
  ]).run([
    '$rootScope', '$state', 'UserProfileService', function($rootScope, $state, UserProfileService) {
      $rootScope.$on('$stateChangeStart', function(event, toState) {
        if (toState.data && toState.data.login === true && !UserProfileService.isLoggedIn()) {
          event.preventDefault();
          return $state.go('login');
        }
      });
      $rootScope.UserProfileService = UserProfileService;
      $rootScope.title = UserProfileService.isLoggedIn();
      $rootScope.state = $state;
      $rootScope.logout = function() {
        UserProfileService.logout();
        return $state.go("welcome");
      };
      return true;
    }
  ]);

}).call(this);
