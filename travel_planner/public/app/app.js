(function() {
  angular.module("TravePlannerApp", ['ui.router']).config([
    '$urlRouterProvider', '$stateProvider', function($urlRouterProvider, $stateProvider) {
      $urlRouterProvider.otherwise("/login");
      $stateProvider.state('login', {
        'url': '/login'
      });
    }
  ]);

}).call(this);
