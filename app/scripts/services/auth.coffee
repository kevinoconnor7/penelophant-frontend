'use strict'

angular.module 'penelophantFrontendApp'
 .service 'AuthService', (Restangular, $window, $timeout, $q, localStorageService) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    loggedIn: false
    user: null
    token: null
    triedToken: false
    logout: () ->
      this.loggedIn = false
      this.user = null
      this.token = null
      this.destroyToken()
    isLoggedIn: () ->
      this.loggedIn

    setUser: (data) ->
      this.token = data.token
      this.loggedIn = true
      this.user = data.user
      localStorageService.set 'token', data.token

      Restangular.addFullRequestInterceptor (element, operation, what, url) =>
        headers:
          Authorization: 'Bearer ' + this.getToken()
    getToken: () ->
      if not this.token and localStorageService.get 'token'
        return localStorageService.get 'token'
      else
        return this.token
    verifyToken: (token) ->
      return false if not token
      Restangular
        .one "token"
        .get()
        .then (data) =>
          this.triedToken = true
          this.setUser data
        , () =>
          this.triedToken = true
          this.destroyToken()

    destroyToken: () ->
      localStorageService.remove 'token'

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
          , () =>
            this.destroyToken()
            defer.reject()
      else
        defer.reject()
      defer.promise

    loadToken: () ->
      return if this.loggedIn
      this.verifyToken this.getToken()
