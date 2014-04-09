'use strict'

angular.module 'penelophantFrontendApp'
 .service 'AuthService', (Restangular, $window) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    loggedIn: false
    user: null
    token: null
    logout: () ->
      this.loggedIn = false
      this.user = null
      this.token = null
      $window.sessionStorage.removeItem 'token'
    isLoggedIn: () ->
      this.loggedIn
    setUser: (data) ->
      this.token = data.token
      this.loggedIn = true
      this.user = data.user
      $window.sessionStorage.token = data.token

      Restangular.addFullRequestInterceptor (element, operation, what, url) =>
        headers:
          Authorization: 'Bearer ' + this.getToken()
    getToken: () ->
      if not this.token and $window.sessionStorage.token
        return $window.sessionStorage.token
      else
        return this.token
    verifyToken: (token) ->
      Restangular
        .one "token"
        .get()
        .then (data) =>
          this.setUser data
        , () ->
          $window.sessionStorage.removeItem 'token'
    loadToken: () ->
      if $window.sessionStorage.token
        this.verifyToken $window.sessionStorage.token
