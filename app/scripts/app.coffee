'use strict'

angular.module('penelophantFrontendApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mgcrea.ngStrap',
  'restangular'
])
  .config ($routeProvider, RestangularProvider) ->
    RestangularProvider.setBaseUrl('http://localhost:5000/api');
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/login',
        templateUrl: 'views/login.html'
        controller: 'LoginCtrl'
      .when '/auctions',
        templateUrl: 'views/auctions/index.html'
        controller: 'AuctionsListCtrl'
        method: 'index'
      .when '/auctions/:id',
        templateUrl: 'views/auctions/view.html'
        controller: 'AuctionsViewCtrl'
        method: 'view'
      .otherwise
        redirectTo: '/'
