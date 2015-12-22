angular.module("TravePlannerApp.contorller.expensesController")
.controller("newExpenseController", ['$scope', 'expenses', 'expensesService', '$state', ($scope, data, expensesService, $state) ->
  $scope.expenses = data.expenses
  $scope.edit_expense = {}
  $scope.onStartDateChanged = () ->
    sdate = moment($scope.edit_expense.startDate)
    if sdate.isValid() and !$scope.edit_expense.endDate
      $scope.edit_expense.endDate = $scope.edit_expense.startDate
      
  $scope.dateValidate = () ->
    $scope.edit_expense.endDate < $scope.edit_expense.startDateDate
  $scope.save = ->
    t = new expensesService($scope.edit_expense)
    t.$save()
    .then (result)->
      t.id = result.expense_id
      t.destination = $scope.edit_expense.destination
      t.startDate = $scope.edit_expense.startDate
      t.endDate = $scope.edit_expense.endDate
      t.comment = $scope.edit_expense.comment
      data.expenses.push t
      $state.go('expenses.list')
    .catch  (err) ->
       $scope.errors =[err.data.message]
])