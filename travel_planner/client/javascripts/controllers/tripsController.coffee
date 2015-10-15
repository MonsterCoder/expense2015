angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker'])
.controller("tripsController", ['$scope', 'trips', '$state', 'tripsService', '$mdDialog', ($scope, data, $state, tripsService, $mdDialog) ->
  $scope.trips = tripsService.buildFromArray data.trips
  ev = {}
  $scope.custom_filter = {}
  $scope.filter_by = "all"
  $scope.filters = [
    {name: "All Trips",  value: "all"},
    {name: "Past Trips", value: "past"},
    {name: "Future Trips", value: "future"},
    {name: "Start in 30 days", value: "30days"}
    {name: "Custom filter", value: "custom"}
  ]
  
  $scope.filter_trips = (trip) ->
    switch $scope.filter_by 
      when "all" 
        true
      when 'past' 
        trip.getDays() < 0
      when 'future' 
        trip.getDays() >= 0
      when '30days' 
        trip.getDays() >= 0 and trip.getDays() <= 30
      when 'custom' 
        if $scope.custom_filter.destination
          return false if trip.destination.indexOf($scope.custom_filter.destination) < 0
        if $scope.custom_filter.startDate
          return false if trip.startDate < $scope.custom_filter.startDate
        if $scope.custom_filter.endDate
          return false if trip.endDate > $scope.custom_filter.endDate     
        
        true
      else
        false

  $scope.predicate = 'getDays()';
  $scope.reverse = false;
  $scope.order = (predicate) ->
    $scope.reverse = if ($scope.predicate == predicate) then !$scope.reverse  else  false
    $scope.predicate = predicate;
  
  $scope.delete = (idx) ->
    confirm = $mdDialog.confirm(ev)
          .title('Would you like to delete this trip?')
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
        $state.go("trips.list", params, {reload: 'trips'})
        
    )
    

      
  $scope.add = ->
    $scope.edit_trip = {}
    
  $scope.edit = (idx) ->
    $state.go("trips.edit_trip", {idx : idx})
])    



