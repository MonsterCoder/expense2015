(function() {
  angular.module("TravePlannerApp", ['ui.router', 'angular-storage']).config([
    '$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
      $urlRouterProvider.otherwise("/welcome");
      return $stateProvider.state('welcome', {
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
      });
    }
  ]);

}).call(this);
