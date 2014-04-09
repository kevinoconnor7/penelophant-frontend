'use strict'

angular.module('penelophantFrontendApp')
  .controller 'RegisterCtrl', ($scope, $alert, AuthService, Restangular, $location) ->
    return $location.path '/' if AuthService.isLoggedIn()
    registerError = null
    showError = () ->
      if registerError
        registerError.destroy()
      registerError = $alert
        title: "Ruh-roh"
        content: "We weren't able to create you an account. Do you already have an account?"
        type: "danger"
        container: "#login-alert-container"

    $scope.register = (valid, user) ->
      return showError() if not valid

      Restangular.all 'users'
        .post user
        .then (data) ->
          AuthService.setUser
            token: data.token
            user: data.user
          Restangular.all 'auth'
            .customOperation 'put', 'password', null, null, user
            .then (data) ->
              $location.path '/'
            , (data) ->
              console.log 'oh shit!'
              showError()
        , (data) ->
          showError()
