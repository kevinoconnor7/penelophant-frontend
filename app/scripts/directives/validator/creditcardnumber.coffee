'use strict'

angular.module 'penelophantFrontendApp'
  .directive 'creditCardNumber', (Balanced) ->
    restrict: 'A'
    require: 'ngModel'
    link: (scope, element, attrs, ngModel) ->
      validate = (val) ->
        ngModel.$setValidity 'creditCardNumber', Balanced.isCardNumberValid(val)
      scope.$watch () ->
        ngModel.$viewValue
      , validate
