 angular.module("TravePlannerApp", ['ngMdIcons','angular.filter', 'ui.router','720kb.datepicker','TravePlannerApp.interceptor', 'TravePlannerApp.service.UserProfileService', 'TravePlannerApp.service.usersService', 'TravePlannerApp.service.expensesService','TravePlannerApp.contorllers','ngMaterial'])
 .config(['$urlRouterProvider','$stateProvider','$httpProvider', '$mdThemingProvider', ($urlRouterProvider, $stateProvider, $httpProvider, $mdThemingProvider) ->
    $urlRouterProvider.when("/expenses", "/expenses/list")
    $urlRouterProvider.when("/admin", "/admin/list")
    $urlRouterProvider.otherwise("/welcome")
    
    $stateProvider
    .state('welcome',
      url : '/welcome',
      templateUrl : 'app/views/welcome.html'
    )
    .state('login',
      url : '/login?message',
      templateUrl : 'app/views/login.html'
      controller : 'loginController'
    )
    .state('signup',
      url : '/signup?call_back',
      templateUrl : 'app/views/signup.html',
      resolve: {
        users: ->
          []
      }
      controller : 'signupController'
    )
    .state('expenses', 
      url : '/expenses'
      templateUrl: 'app/views/expenses/expenses.html'
      data:
        login: true
      resolve: 
        expenses: [ 'expensesService', (expensesService) ->
          expensesService.get().$promise
        ]   
    )
    .state('expenses.list',
      url : '/'
      templateUrl: 'app/views/expenses/list.html'
      data:
        login: true
      controller: 'expensesController'
    )
    .state('expenses.new_expense',
      url : '/new'
      data:
        login: true
      templateUrl: 'app/views/expenses/new_expense.html'
      controller: 'newExpenseController'
    )
    .state('expenses.edit_expense',
      url : '/edit/:idx'
      data:
        login: true
      templateUrl: 'app/views/expenses/new_expense.html'
      controller: 'editExpenseController'
    )
    .state('admin',
      url : '/admin'
      data:
        admin: true
      templateUrl: 'app/views/admin/dashboard.html',
      resolve:
        users: ['usersService', (usersService) ->
          usersService.get().$promise
        ]
    )
    .state('admin.list',
      url : '/'
      templateUrl: 'app/views/admin/list.html'
      data:
        admin: true
      controller: 'adminController'
    )
    .state('admin.edit_user',
      url : '/edit/:idx?call_back'
      data:
        admin: true
      templateUrl : 'app/views/signup.html',
      controller: 'signupController'
    )
    $httpProvider.interceptors.push('tokenHttpInterceptor')

 ])
 .directive('googleplace', () ->
         require : 'ngModel',
         link : (scope, element, attrs, model) ->
            options = {
                 types : ['(cities)'],
            }
            attrs.$set('placeholder',"")
            scope.gPlace = new google.maps.places.Autocomplete(element[0], options);

            google.maps.event.addListener(scope.gPlace, 'place_changed',
                     () ->
                         scope.$apply( () ->
                             model.$setViewValue(element.val());
                         )
                    )
         
 )
 .run(['$rootScope', '$state','UserProfileService', ($rootScope, $state, UserProfileService) ->
    $rootScope.$on('$stateChangeStart', (event, toState) ->
      if toState.data and toState.data.login==true and !UserProfileService.isLoggedIn()
         event.preventDefault()
         $state.go('login')
      if toState.data and toState.data.admin==true and !UserProfileService.isAdmin()
        event.preventDefault()
        $state.go('login')
    )
    $rootScope.UserProfileService = UserProfileService
    $rootScope.title = UserProfileService.isLoggedIn()
    $rootScope.state = $state
    
    $rootScope.logout = () ->
      UserProfileService.logout()
      $state.go("welcome")

    true
 ])