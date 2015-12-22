(function() {
  angular.module("TravePlannerApp.contorller.expensesController").controller("editExpenseController", [
    '$scope', 'expenses', 'expensesService', '$stateParams', '$state', function($scope, data, expensesService, $stateParams, $state) {
      var i, idx, t;
      $scope.expenses = data.expenses;
      idx = $stateParams.idx;
      t = ((function() {
        var j, len, ref, results;
        ref = data.expenses;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          i = ref[j];
          if (i.id == idx) {
            results.push(i);
          }
        }
        return results;
      })())[0];
      console.log(t);
      $scope.edit_expense = {
        id: t.id,
        destination: t.destination,
        startDate: t.startDate,
        endDate: new Date(t.endDate),
        comment: t.comment,
        amount: parseFloat(t.amount)
      };
      console.log($scope.edit_expense);
      return $scope.save = function() {
        var u;
        u = new expensesService($scope.edit_expense);
        return u.$update().then(function() {
          t.destination = $scope.edit_expense.destination;
          t.startDate = $scope.edit_expense.startDate;
          t.endDate = $scope.edit_expense.endDate;
          t.comment = $scope.edit_expense.comment;
          t.amount = $scope.edit_expense.amount;
          return $state.go('expenses.list');
        })["catch"](function(err) {
          return $scope.errors = [err.data.message];
        });
      };
    }
  ]);

}).call(this);
