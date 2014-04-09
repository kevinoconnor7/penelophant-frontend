'use strict'

angular.module 'penelophantFrontendApp'
 .controller 'PwdAuthCtrl', ($scope, Restangular, $alert, AuthService, $location) ->
  return $location.path '/' if AuthService.isLoggedIn()
  loginError = null

  showError = () ->
    if loginError
      loginError.destroy()
    loginError = $alert
      title: "Ruh-roh"
      content: "We were not able to validate these credentials"
      type: "danger"
      container: "#login-alert-container"

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


