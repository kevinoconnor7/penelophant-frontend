'use strict'

angular.module('penelophantFrontendApp')
  .controller 'AuctionsListCtrl', ($scope, Restangular, $routeParams, $location) ->
    $scope.auctions = Restangular
      .all 'auctions'
      .getList $location.search()
      .$object
    return

angular.module('penelophantFrontendApp')
  .controller 'AuctionsViewCtrl', ($scope, Restangular, $routeParams, $alert) ->

    $scope.auction = Restangular
      .one 'auctions', parseInt($routeParams.id, 10)
      .get()
      .$object

    $scope.postBid = (valid, bid) ->
      return if not valid or not bid
      $scope.auction.post('bid', bid).then (data) ->
        $alert
          title: "Sweet!"
          content: "Your bid for $#{data.price} was entered"
          type: "success"
          container: "#error-container"
        bid.price = null
        $scope.auction = Restangular
          .one 'auctions', parseInt($routeParams.id, 10)
          .get()
          .$object
      , (resp) ->
        $alert
          title: "Oh no!"
          content: resp.data.message
          type: "danger"
          container: "#error-container"
    return
