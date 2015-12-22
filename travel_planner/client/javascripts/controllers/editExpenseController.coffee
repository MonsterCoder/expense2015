angular.module("TravePlannerApp.contorller.expensesController")
.controller("editExpenseController", ['$scope', 'expenses', 'expensesService', '$stateParams','$state', ($scope, data, expensesService,$stateParams, $state) ->
  $scope.expenses = data.expenses
  idx =$stateParams.idx
  t = (i for i in data.expenses when `i.id == idx`)[0]

  console.log t
  $scope.edit_expense = {
    id: t.id
    destination: t.destination
    startDate: t.startDate
    endDate: new Date(t.endDate)
    comment: t.comment
    amount: parseFloat(t.amount)
  }
  console.log $scope.edit_expense
  
  $scope.save = ->
    u = new expensesService($scope.edit_expense)
    u.$update()
    .then ->
      t.destination = $scope.edit_expense.destination
      t.startDate = $scope.edit_expense.startDate
      t.endDate = $scope.edit_expense.endDate
      t.comment = $scope.edit_expense.comment
      t.amount = $scope.edit_expense.amount
      $state.go('expenses.list')
    .catch  (err) ->
      $scope.errors =[err.data.message]
])
   