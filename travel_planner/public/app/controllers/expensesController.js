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
              $scope.print.description = $scope.print.description + ' till ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD');
              if (expense.startDate > $scope.custom_filter.endDate) {
                rt = false;
              }
            }
            if ($scope.custom_filter.amount) {
              $scope.print.description = $scope.print.description + ' amount more than ' + $scope.custom_filter.amount;
              if (expense.amount < $scope.custom_filter.amount) {
                rt = false;
              }
            }
            return rt;
          default:
            return false;
        }
      };
      $scope.getWeekTotal = function(week) {
        var i, j, len, ref, total;
        total = 0;
        ref = $scope.expenses;
        for (j = 0, len = ref.length; j < len; j++) {
          i = ref[j];
          if (i.getWeek() == week) {
            total = total + parseFloat(i.amount);
          }
        }
        return total;
      };
      $scope.getDaliyAverage = function(week) {
        return $scope.getWeekTotal(week) / 7;
      };
      $scope.reverse = false;
      $scope.order = function(predicate) {
        $scope.reverse = $scope.predicate === predicate ? !$scope.reverse : false;
        return $scope.predicate = predicate;
      };
      $scope["delete"] = function(item) {
        var confirm, t;
        t = new expensesService(item);
        console.log(item);
        confirm = $mdDialog.confirm(ev).title('Are you sure to delete this expense?').content('').ariaLabel('Delete expense').targetEvent(ev).ok('Confirm!').cancel('Cancel');
        return $mdDialog.show(confirm).then(function() {
          return t.$delete().then(function() {
            var p;
            p = $scope.expenses.indexOf(item);
            $scope.expenses.splice(p, 1);
            data.expenses.splice(p, 1);
            return $state.go("expenses.list", {}, {
              reload: 'expenses'
            });
          });
        });
      };
      $scope.add = function() {
        return $scope.edit_expense = {};
      };
      return $scope.edit = function(item) {
        return $state.go("expenses.edit_expense", {
          idx: item.id
        });
      };
    }
  ]);

}).call(this);
