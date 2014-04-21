'use strict'

angular.module('penelophantFrontendApp')
  .controller 'InvoicesListCtrl', ($scope, Restangular) ->
    $scope.invoices = Restangular
      .all 'invoices'
      .getList()
      .$object

angular.module('penelophantFrontendApp')
  .controller 'InvoicesViewCtrl', ($scope, Restangular, $routeParams, Balanced) ->
    $scope.alerts = []

    getInvoice = () ->
      $scope.invoice = Restangular
        .one 'invoices', parseInt($routeParams.id, 10)
        .get()
        .$object

    getInvoice()

    $scope.closeAlert = (index) ->
      $scope.alerts.splice index, 1

    $scope.balanced = Balanced

    $scope.payCC = (formData) ->
      formData = {} if not formData
      payload =
        number: formData['number'] || 0
        name: formData.name || ""
        expiration_month: formData.expiration_month || 0
        expiration_year: formData.expiration_year || 0
        security_code: formData.security_code || 0
      $scope.alerts = []
      errors = Balanced.validateCC payload
      if errors.length > 0
        for error in errors
          $scope.alerts.push
            type: "danger"
            msg: error.description.split(" - ", 2)[1]
        return
      Balanced.createCard payload
        .then (response) ->
          if response.errors
            for error in response.error
              $scope.alerts.push
                msg: error.description
                type: "danger"
          else if response.card
            $scope.invoice.put
              #ccPath: response.card.href
              ccId: response.card.id
            .then (rep) ->
              $scope.invoice = rep
          else
            $scope.alerts.push
              msg: "Ruh-roh. Something went wrong. You might want to try again."
              type: "danger"

