angular.module("TravePlannerApp.contorller.expensesController")
.controller("editExpenseController", ['$scope', 'expenses', 'expensesService', '$stateParams','$state', ($scope, data, expensesService,$stateParams, $state) ->
  $scope.expenses = data.expenses
  idx =$stateParams.idx
  t = data.expenses[idx]
  $scope.edit_expense = {
    id: t.id
    destination: t.destination
    startDate: t.startDate
    endDate: t.endDate
    comment: t.comment
  }
  
  $scope.save = ->
    u = new expensesService($scope.edit_expense)
    u.$update()
    .then ->
      t.destination = $scope.edit_expense.destination
      t.startDate = $scope.edit_expense.startDate
      t.endDate = $scope.edit_expense.endDate
      t.comment = $scope.edit_expense.comment
      $state.go('expenses.list')
    .catch  (err) ->
      $scope.errors =[err.data.message]
])
   