'use strict'

angular.module 'penelophantFrontendApp'
 .service 'AuthService', (Restangular, $window, $timeout, $q) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    loggedIn: false
    user: null
    token: null
    triedToken: false
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
          this.triedToken = true
          this.setUser data
        , () =>
          this.triedToken = true
          $window.sessionStorage.removeItem 'token'

    resolve: () ->
      defer = $q.defer()
      tt = this.triedToken
      this.triedToken = true
      if this.loggedIn
        defer.resolve this
      else if not tt
        Restangular
          .one "token"
          .get()
          .then (data) =>
            this.setUser data
            defer.resolve this
          , () ->
            $window.sessionStorage.removeItem 'token'
            defer.reject()
      else
        defer.reject()
      defer.promise

    loadToken: () ->
      return if this.loggedIn
      if $window.sessionStorage.token
        this.verifyToken $window.sessionStorage.token
