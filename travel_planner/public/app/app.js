(function() {
  angular.module("TravePlannerApp", ['ui.router']).config([
    '$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
      $urlRouterProvider.otherwise("/welcome");
      return $stateProvider.state('welcome', {
        url: '/welcome',
        templateUrl: 'app/views/welcome.html'
      }).state('login', {
        url: '/login',
        templateUrl: 'app/views/login.html'
      }).state('signup', {
        url: '/signup',
        templateUrl: 'app/views/signup.html',
        controller: 'signupController'
      });
    }
  ]);

}).call(this);
