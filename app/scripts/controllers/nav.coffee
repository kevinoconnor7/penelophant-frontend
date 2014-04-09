'use strict'

angular.module('penelophantFrontendApp')
  .controller 'NavCtrl', ($scope, AuthService, $location, $rootScope) ->
    $scope.current_user = AuthService.user

    $rootScope.$on '$routeChangeSuccess', (ev,data) ->
      return if data.$$route and data.$$route.controller and data.$$route.controller == "AuctionsListCtrl"
      $scope.q.query = null if $scope.q and $scope.q.query

    $scope.search = (q) ->
      $location.path '/auctions'
        .search q
