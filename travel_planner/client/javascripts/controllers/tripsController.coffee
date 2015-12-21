angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker'])
.controller("tripsController", ['$scope', 'trips', '$state', 'tripsService', '$mdDialog', ($scope, data, $state, tripsService, $mdDialog) ->
  $scope.trips = tripsService.buildFromArray data.trips
  ev = {}
  
  $scope.print ={}
  $scope.print.open = () ->
    window.print()
    
  $scope.custom_filter = {}
  $scope.filter_by = "all"
  $scope.filters = [
    {name: "All Expenses",  value: "all"},
    {name: "In 30 days", value: "30days"}
    {name: "Custom filter", value: "custom"}
  ]
  
  $scope.filter_trips = (trip) ->
    switch $scope.filter_by 
      when "all" 
        true
        $scope.print.description = 'all trips'
      when '30days' 
        $scope.print.description = 'in 30 days'
        trip.getDays() >= 0 and trip.getDays() <= 30
      when 'custom' 
        rt = true
        $scope.print.description = 'all expenses'
        if $scope.custom_filter.destination
          $scope.print.description = $scope.print.description+' to destination ' + $scope.custom_filter.destination
          rt = false if trip.destination.indexOf($scope.custom_filter.destination) < 0
        if $scope.custom_filter.startDate
          $scope.print.description = $scope.print.description+' from ' + new moment($scope.custom_filter.startDate).format('YYYY-MM-DD')
          rt = false if trip.startDate < $scope.custom_filter.startDate
        if $scope.custom_filter.endDate
          $scope.print.description = $scope.print.description+' ends before ' + new moment($scope.custom_filter.endDate).format('YYYY-MM-DD')
          rt = false if trip.endDate > $scope.custom_filter.endDate     
        
        rt
      else
        false

 
  

  $scope.predicate = 'getDays()';
  $scope.reverse = false;
  $scope.order = (predicate) ->
    $scope.reverse = if ($scope.predicate == predicate) then !$scope.reverse  else  false
    $scope.predicate = predicate;
  
  $scope.delete = (idx) ->
    confirm = $mdDialog.confirm(ev)
          .title('Are you sure to delete this trip?')
          .content('')
          .ariaLabel('Delete trip')
          .targetEvent(ev)
          .ok('Confirm!')
          .cancel('Cancel');

    $mdDialog.show(confirm).then(() ->
      t = new tripsService($scope.trips[idx])
      t.$delete()
      .then () ->
        $scope.trips.splice(idx, 1)
        data.trips.splice(idx, 1)
        $state.go("trips.list", {}, {reload: 'trips'})
        
    )
    

      
  $scope.add = ->
    $scope.edit_trip = {}
    
  $scope.edit = (idx) ->
    $state.go("trips.edit_trip", {idx : idx})
])    



