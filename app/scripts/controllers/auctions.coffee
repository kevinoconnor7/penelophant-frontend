'use strict'

angular.module('penelophantFrontendApp')
  .controller 'AuctionsListCtrl', ($scope, Restangular, $routeParams) ->
    $scope.auctions = Restangular
      .all 'auctions'
      .getList 'auctions'
      .$object
    return

angular.module('penelophantFrontendApp')
  .controller 'AuctionsViewCtrl', ($scope, Restangular, $routeParams) ->
    $scope.auction = Restangular
      .one 'auctions', parseInt($routeParams.id, 10)
      .get()
      .$object
    return
