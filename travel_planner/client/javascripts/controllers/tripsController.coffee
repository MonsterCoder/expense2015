angular.module("TravePlannerApp.contorller.tripsController", ['720kb.datepicker'])
.controller("tripsController", ['$scope', 'trips', '$state', 'tripsService', '$mdDialog', ($scope, data, $state, tripsService, $mdDialog) ->
  $scope.trips = tripsService.buildFromArray data.trips
  ev = {}
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



