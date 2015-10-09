(function() {
  angular.module("TravePlannerApp", ['ui.router']).config([
    '$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
      $urlRouterProvider.otherwise("/login");
      return $stateProvider.state('login', {
        url: '/login',
        templateUrl: 'app/views/login.html'
      }).state('signup', {
        url: '/signup',
        templateUrl: 'app/views/signup.html'
      });
    }
  ]);

}).call(this);
