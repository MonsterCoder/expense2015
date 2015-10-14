(function() {
  angular.module("TravePlannerApp", ['ui.router', '720kb.datepicker', 'TravePlannerApp.interceptor', 'TravePlannerApp.service.UserProfileService', 'TravePlannerApp.service.tripsService', 'TravePlannerApp.contorllers']).config([
    '$urlRouterProvider', '$stateProvider', '$httpProvider', function($urlRouterProvider, $stateProvider, $httpProvider) {
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
