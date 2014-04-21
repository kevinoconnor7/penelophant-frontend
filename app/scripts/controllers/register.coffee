'use strict'

angular.module('penelophantFrontendApp')
  .controller 'RegisterCtrl', ($scope, AuthService, Restangular, $location) ->
    return $location.path '/' if AuthService.isLoggedIn()
    $scope.registerAlerts = []
    registerError = null
    showError = () ->
      $scope.registerAlerts = []
      $scope.registerAlerts.push 
        msg: "We weren't able to create you an account. Do you already have an account?"
        title: "Ruh-roh!"
        type: "danger"

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
