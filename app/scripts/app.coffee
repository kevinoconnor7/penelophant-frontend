'use strict'

app = angular.module('penelophantFrontendApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'restangular',
  'mgo-angular-wizard',
  'flatui.radioButton',
  'ui.bootstrap.datetimepicker',
  'angularMoment',
  'ui.bootstrap',
  'btford.markdown'
])

app.config ($routeProvider, RestangularProvider) ->
    RestangularProvider.setBaseUrl '/api'
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
      .when '/auctions/add',
        templateUrl: 'views/auctions/add.html'
        controller: 'AuctionsAddCtrl'
        loggedIn: true
      .when '/auctions/:id',
        templateUrl: 'views/auctions/view.html'
        controller: 'AuctionsViewCtrl'
      .when '/logout',
        templateUrl: 'views/logout.html'
        controller: 'LogoutCtrl'
        loggedIn: true
      .when '/register',
        templateUrl: 'views/register.html'
        controller: 'RegisterCtrl'
      .when '/invoices',
        templateUrl: 'views/invoices/index.html'
        controller: 'InvoicesListCtrl'
      .when '/invoices/:id',
        templateUrl: 'views/invoices/view.html'
        controller: 'InvoicesViewCtrl'
      .otherwise
        redirectTo: '/'

app.run ($rootScope, Restangular, AuthService, $location, $q) ->

  Restangular.addFullRequestInterceptor (element, operation, what, url) ->
    headers:
      Authorization: 'Bearer ' + AuthService.getToken()

  AuthService.loadToken()

  $rootScope.current_user = AuthService

  $rootScope.$on '$routeChangeSuccess', (ev,data) ->
    if data.$$route and data.$$route.controller
      $rootScope.controller = data.$$route.controller

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    next.resolve = angular.extend next.resolve || {},
      _auth_: () ->
        defer = $q.defer()
        AuthService.resolve().then () ->
          defer.resolve AuthService
        , () ->
          if next.loggedIn is true and not AuthService.isLoggedIn()
            $location.path '/login'
          defer.resolve AuthService

        defer.promise
