describe "expensesController", ->
  expenses = []
  $scope = {}
  $httpBackend = {}
  expensesService = {}
  
  beforeEach module "TravePlannerApp"
  beforeEach inject (_$rootScope_, _$controller_, _$httpBackend_, _expensesService_, $templateCache) ->
    $templateCache.put "app/views/login.html", ""
    $templateCache.put "app/views/signup.html", ""
    $templateCache.put "app/views/welcome.html", ""
    $templateCache.put "app/views/expenses/expenses.html", ""
    expensesService = _expensesService_
    $httpBackend = _$httpBackend_
    expenses = [
      { id: 1, destination: 'city1', startDate: "Sun Oct 11 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 12 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 1'},
      { id: 2, destination: 'city2', startDate: "Sun Oct 13 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 14 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 2'}
    ]
    _$controller_("expensesController", {$scope: $scope, expenses: {expenses: expenses}})
    
  it " has a list of expenses", ->
    expect($scope.expenses.length).toEqual(expenses.length)
  
  xit " removes a expense to list", -> 
    count = $scope.expenses.length
    $httpBackend.whenDELETE('/expenses/1').respond(200, {message: "expense deleted" })
    $scope.delete(0)
    $httpBackend.flush()
    expect($scope.expenses.length).toEqual(count - 1)
    
  it " adds an empty expense", ->
    $scope.edit_expense = {  destination: 'city3', startDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", endDate: "Sun Oct 15 2015 14:16:02 GMT-0500 (CDT)", comment: 'comment 3'}
    $scope.add()
    expect($scope.edit_expense).toEqual({})
    
     