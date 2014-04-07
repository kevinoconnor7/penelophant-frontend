'use strict'

angular.module('penelophantFrontendApp')
  .controller 'LogoutCtrl', ($scope, AuthService, $location) ->
    AuthService.logout()
    $location.path '/'
