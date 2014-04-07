'use strict'

angular.module('penelophantFrontendApp')
  .controller 'NavCtrl', ($scope, AuthService) ->
    $scope.current_user = AuthService.user
