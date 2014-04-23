'use strict'

angular.module('penelophantFrontendApp')
  .controller 'AuctionsListCtrl', ($scope, Restangular, $location) ->
    $scope.auctions = Restangular
      .all 'auctions'
      .getList $location.search()
      .$object
    return

angular.module('penelophantFrontendApp')
  .controller 'AuctionsAddCtrl', ($scope, Restangular, $routeParams, $location) ->
    $scope.auction =
      start_time: moment().toString()
      end_time: moment().add('days', 7).toString()
      start_price: 0
      reserve: 0
    $scope.auctionTypes = Restangular
      .all 'auctions/types'
      .getList()
      .$object
    $scope.checkAuctionType = ($valid, auction) ->
      return false if not $valid or not auction.type

      for auctionType in $scope.auctionTypes
        return true if auctionType.type == auction.type

      return false

    $scope.addAuction = (auction) ->
      createdAuction = Restangular
        .all('auctions')
        .post(
          type: auction.type
          title: auction.title
          start_price: auction.start_price
          reserve: auction.reserve
          start_time: moment.utc(auction.start_time).unix()
          end_time: moment.utc(auction.end_time).unix()
        ).then (data) ->
          $location.path '/auctions/' + data.id
        , (resp) ->
          $alert
            title: "Oh no!"
            content: resp.data.message
            type: "danger"
            container: "#error-container"
    return

angular.module('penelophantFrontendApp')
  .controller 'AuctionsViewCtrl', ($scope, Restangular, $routeParams, AuthService) ->

    getAuction = () ->
      $scope.auction = Restangular
        .one 'auctions', parseInt($routeParams.id, 10)
        .get()
        .$object

    getAuction()

    $scope.alerts = []

    $scope.formatTime = (time) ->
      moment(time).format('MMMM Do YYYY, h:mm:ss a')

    $scope.postBid = (valid, bid) ->
      return if not AuthService.isLoggedIn()
      return if not valid or not bid
      $scope.auction.post('bid', bid).then (data) ->
        $scope.alerts = []
        $scope.alerts.push 
          title: "Sweet!"
          msg: "Your bid for $#{data.price} was entered"
          type: "success"
        bid.price = null
        getAuction()
      , (resp) ->
        $scope.alerts = []
        $scope.alerts.push 
          title: "Oh no!"
          msg: resp.data.message
          type: "danger"
    return
