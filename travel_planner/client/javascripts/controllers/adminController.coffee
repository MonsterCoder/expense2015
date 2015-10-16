angular.module("TravePlannerApp.contorller.adminController", ['720kb.datepicker'])
.controller("adminController", ['$scope', 'users', '$state', 'usersService', '$mdDialog', ($scope, data, $state, usersService, $mdDialog) ->
  $scope.users = data.users
  console.log $scope.users
  ev ={}
  
  $scope.print ={}
  $scope.print.open = () ->
    window.print()
  $scope.predicate = 'getDays()';
  $scope.reverse = false;
  $scope.order = (predicate) ->
    $scope.reverse = if ($scope.predicate == predicate) then !$scope.reverse  else  false
    $scope.predicate = predicate;

  $scope.delete = (idx) ->
    confirm = $mdDialog.confirm(ev)
          .title('Are you sure to delete this account?')
          .content('')
          .ariaLabel('Delete account')
          .targetEvent(ev)
          .ok('Confirm!')
          .cancel('Cancel');

    $mdDialog.show(confirm).then(() ->
      t = new usersService($scope.users[idx])
      t.$delete()
      .then () ->
        $scope.users.splice(idx, 1)
        data.users.splice(idx, 1)
        $state.go("admin.list", {}, {reload: 'users'})

    )
  $scope.edit = (idx) ->
    $state.go("admin.edit_user", {idx : idx})

])