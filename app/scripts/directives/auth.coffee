'use strict'

angular.module('penelophantFrontendApp')
  .directive('requireLoggedIn', (AuthService) ->
    restrict: 'A'
    link: ($scope, element, attrs) ->
      prevDisp = element.css 'display'

      $scope.current_user = AuthService
      $scope
        .$watch 'current_user.loggedIn', () ->
          if not $scope.current_user.isLoggedIn()
            element.css 'display', 'none'
          else
            element.css 'display', prevDisp

  )
