(function() {
  angular.module("TravePlannerApp.contorller.expensesController").controller("editExpenseController", [
    '$scope', 'expenses', 'expensesService', '$stateParams', '$state', function($scope, data, expensesService, $stateParams, $state) {
      var idx, t;
      $scope.expenses = data.expenses;
      idx = $stateParams.idx;
      t = data.expenses[idx];
      $scope.edit_expense = {
        id: t.id,
        destination: t.destination,
        startDate: t.startDate,
        endDate: t.endDate,
        comment: t.comment
      };
      return $scope.save = function() {
        var u;
        u = new expensesService($scope.edit_expense);
        return u.$update().then(function() {
          t.destination = $scope.edit_expense.destination;
          t.startDate = $scope.edit_expense.startDate;
          t.endDate = $scope.edit_expense.endDate;
          t.comment = $scope.edit_expense.comment;
          return $state.go('expenses.list');
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
