'use strict'

app = angular.module('penelophantFrontendApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'mgcrea.ngStrap',
  'restangular'
])

app.config ($routeProvider, RestangularProvider) ->
    RestangularProvider.setBaseUrl 'http://localhost:5000/api'
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/login',
        templateUrl: 'views/login.html'
        controller: 'PwdAuthCtrl'
      .when '/auctions',
        templateUrl: 'views/auctions/index.html'
        controller: 'AuctionsListCtrl'
        method: 'index'
      .when '/auctions/:id',
        templateUrl: 'views/auctions/view.html'
        controller: 'AuctionsViewCtrl'
        method: 'view'
      .when '/logout',
        templateUrl: 'views/logout.html'
        controller: 'LogoutCtrl'
      .otherwise
        redirectTo: '/'

app.run ($rootScope, Restangular, AuthService) ->

  Restangular.addFullRequestInterceptor (element, operation, what, url) ->
    headers:
      Authorization: 'Bearer ' + AuthService.getToken()

  AuthService.loadToken()

  $rootScope.$on '$routeChangeSuccess', (ev,data) ->
    if data.$$route and data.$$route.controller
      $rootScope.controller = data.$$route.controller
