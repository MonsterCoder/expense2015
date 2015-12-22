angular.module("TravePlannerApp.contorller.expensesController", ['720kb.datepicker'])
.controller("expensesController", ['$scope', 'expenses', '$state', 'expensesService', '$mdDialog', ($scope, data, $state, expensesService, $mdDialog) ->
  $scope.expenses = expensesService.buildFromArray data.expenses

  ev = {}
  
  $scope.print ={}
  $scope.print.open = () ->
    window.print()
    
  $scope.custom_filter = {}
  $scope.filter_by = "all"
  $scope.filters = [
    {name: "All Expenses",  value: "all"},
    {name: "Custom filter", value: "custom"}
  ]
  
  $scope.filter_expenses = (expense) ->
    switch $scope.filter_by 
      when "all" 
        true
        $scope.print.description = 'all expenses'
      when 'custom' 
        rt = true
        $scope.print.description = 'all expenses'
        if $scope.custom_filter.destination
          $scope.print.description = $scope.print.description+' to destination ' + $scope.custom_filter.destination
          rt = false if expense.destination.indexOf($scope.custom_filter.destination) < 0
        if $scope.custom_filter.startDate
          $scope.print.description = $scope.print.description+' from ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD')
          rt = false if expense.startDate < $scope.custom_filter.startDate
        if $scope.custom_filter.endDate
          $scope.print.description = $scope.print.description+' till ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD')
          rt = false if expense.startDate > $scope.custom_filter.endDate
        if $scope.custom_filter.amount
          $scope.print.description = $scope.print.description+' amount more than ' + $scope.custom_filter.amount
          rt = false if expense.amount < $scope.custom_filter.amount     
        
        rt
      else
        false

 
  

  $scope.predicate = 'getDays()';
  $scope.reverse = false;
  $scope.order = (predicate) ->
    $scope.reverse = if ($scope.predicate == predicate) then !$scope.reverse  else  false
    $scope.predicate = predicate;
  
  $scope.delete = (item) ->
    t = new expensesService(item)
    console.log item

    confirm = $mdDialog.confirm(ev)
          .title('Are you sure to delete this expense?')
          .content('')
          .ariaLabel('Delete expense')
          .targetEvent(ev)
          .ok('Confirm!')
          .cancel('Cancel');

    $mdDialog.show(confirm).then(() ->
      t.$delete()
      .then () ->
        p = $scope.expenses.indexOf item
        $scope.expenses.splice(p, 1)
        data.expenses.splice(p, 1)
        $state.go("expenses.list", {}, {reload: 'expenses'})
        
    )
    

      
  $scope.add = ->
    $scope.edit_expense = {}
    
  $scope.edit = (item) ->
    $state.go("expenses.edit_expense", {idx : item.id})
])    



