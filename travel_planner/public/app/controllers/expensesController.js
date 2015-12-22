(function() {
  angular.module("TravePlannerApp.contorller.expensesController", ['720kb.datepicker']).controller("expensesController", [
    '$scope', 'expenses', '$state', 'expensesService', '$mdDialog', function($scope, data, $state, expensesService, $mdDialog) {
      var ev;
      $scope.expenses = expensesService.buildFromArray(data.expenses);
      ev = {};
      $scope.print = {};
      $scope.print.open = function() {
        return window.print();
      };
      $scope.custom_filter = {};
      $scope.filter_by = "all";
      $scope.filters = [
        {
          name: "All Expenses",
          value: "all"
        }, {
          name: "In 30 days",
          value: "30days"
        }, {
          name: "Custom filter",
          value: "custom"
        }
      ];
      $scope.filter_expenses = function(expense) {
        var rt;
        switch ($scope.filter_by) {
          case "all":
            true;
            return $scope.print.description = 'all expenses';
          case '30days':
            $scope.print.description = 'in 30 days';
            return expense.getDays() >= 0 && expense.getDays() <= 30;
          case 'custom':
            rt = true;
            $scope.print.description = 'all expenses';
            if ($scope.custom_filter.destination) {
              $scope.print.description = $scope.print.description + ' to destination ' + $scope.custom_filter.destination;
              if (expense.destination.indexOf($scope.custom_filter.destination) < 0) {
                rt = false;
              }
            }
            if ($scope.custom_filter.startDate) {
              $scope.print.description = $scope.print.description + ' from ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD');
              if (expense.startDate < $scope.custom_filter.startDate) {
                rt = false;
              }
            }
            if ($scope.custom_filter.endDate) {
              $scope.print.description = $scope.print.description + ' ends before ' + new moment($scope.custom_filter.endDate).format('YYYY-MM-DD');
              if (expense.endDate > $scope.custom_filter.endDate) {
                rt = false;
              }
            }
            return rt;
          default:
            return false;
        }
      };
      $scope.predicate = 'getDays()';
      $scope.reverse = false;
      $scope.order = function(predicate) {
        $scope.reverse = $scope.predicate === predicate ? !$scope.reverse : false;
        return $scope.predicate = predicate;
      };
      $scope["delete"] = function(idx) {
        var confirm;
        confirm = $mdDialog.confirm(ev).title('Are you sure to delete this expense?').content('').ariaLabel('Delete expense').targetEvent(ev).ok('Confirm!').cancel('Cancel');
        return $mdDialog.show(confirm).then(function() {
          var t;
          t = new expensesService($scope.expenses[idx]);
          return t.$delete().then(function() {
            $scope.expenses.splice(idx, 1);
            data.expenses.splice(idx, 1);
            return $state.go("expenses.list", {}, {
              reload: 'expenses'
            });
          });
        });
      };
      $scope.add = function() {
        return $scope.edit_expense = {};
      };
      return $scope.edit = function(idx) {
        return $state.go("expenses.edit_expense", {
          idx: idx
        });
      };
    }
  ]);

}).call(this);
