'use strict'

angular.module 'penelophantFrontendApp'
 .controller 'PwdAuthCtrl', ($scope, Restangular, AuthService, $location) ->
  return $location.path '/' if AuthService.isLoggedIn()
  loginError = null

  showError = () ->
    $scope.alert =
      type: "danger"
      msg: "We were not able to validate these credentials"

  $scope.auth = (valid, user) ->
    if not valid
      return showError()
    Restangular.all("auth").customPOST(
      email: user.email
      password: user.password
    , "password")
    .then (data) ->
      $scope.current_user = AuthService
      $scope.current_user.setUser data

      # Redirect back to home
      $location.path '/'
    , () ->
      showError()


