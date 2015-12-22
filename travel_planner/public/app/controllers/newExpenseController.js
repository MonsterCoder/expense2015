(function() {
  angular.module("TravePlannerApp.contorller.expensesController").controller("newExpenseController", [
    '$scope', 'expenses', 'expensesService', '$state', function($scope, data, expensesService, $state) {
      $scope.expenses = data.expenses;
      $scope.edit_expense = {};
      $scope.onStartDateChanged = function() {
        var sdate;
        sdate = moment($scope.edit_expense.startDate);
        if (sdate.isValid() && !$scope.edit_expense.endDate) {
          return $scope.edit_expense.endDate = $scope.edit_expense.startDate;
        }
      };
      $scope.dateValidate = function() {
        return $scope.edit_expense.endDate < $scope.edit_expense.startDateDate;
      };
      return $scope.save = function() {
        var t;
        t = new expensesService($scope.edit_expense);
        return t.$save().then(function(result) {
          t.id = result.expense_id;
          t.destination = $scope.edit_expense.destination;
          t.startDate = $scope.edit_expense.startDate;
          t.endDate = $scope.edit_expense.endDate;
          t.comment = $scope.edit_expense.comment;
          data.expenses.push(t);
          return $state.go('expenses.list');
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
