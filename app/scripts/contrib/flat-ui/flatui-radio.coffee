"use strict"

angular.module 'flatui.radioButton', []

angular.module('flatui.radioButton').controller "FlatUIRadioButtonController", ($scope) ->
    console.log $scope
    $scope.checked = ->
      $scope.value is $scope.model


angular.module('flatui.radioButton')
  .directive "flatuiradiobutton", () ->
    restrict: "E"
    replace: true
    transclude: true
    scope:
      model: "="
      label: "="
      value: "="
      required: "="
      name: "="
    templateUrl: "views/contrib/flat-ui/flatui-radio-button-template.html"
    controller: "FlatUIRadioButtonController"
    # controller: ["$scope", ($scope) ->
    #   $scope.checked = ->
    #     console.log $scope
    #     $scope.value is $scope.model
    # ]
