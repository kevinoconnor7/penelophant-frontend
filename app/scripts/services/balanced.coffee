'use strict'

angular.module('penelophantFrontendApp')
  .service 'Balanced', ($q) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    handleResponse: (response, defer) ->
      if response.status_code != 201
        return defer.resolve
          errors: response.errors
      return defer.resolve
        card: response.cards[0]

    getCardType: (cc_number) ->
      balanced.card.cardType cc_number

    isCardNumberValid: (cc_number) ->
      balanced.card.isCardNumberValid cc_number

    isCVVValid: (cc_number, cc_ccv) ->
      balanced.card.isCVVValid cc_number, cc_ccv

    isExpiryValid: (cc_ex_month, cc_ex_year) ->
      balanced.card.isExpiryValid cc_ex_month, cc_ex_year

    validateCC: (payload) ->
      balanced.card.validate payload

    isRoutingNumberValid: (routing_number) ->
      balanced.bankAccount.isRoutingNumberValid routing_number

    validateBA: (payload) ->
      balanced.bankAccount.validateBA payload

    createCard: (payload) ->
      defer = $q.defer()
      defer.reject() if not payload
      balanced.card.create payload, (response) =>
        this.handleResponse(response, defer)
      defer.promise

    createBankAccount: (payload) ->
      defer = $q.defer()
      defer.reject() if not payload
      balanced.bankAccount.create payload, (response) =>
        this.handleResponse(response, defer)
      defer.promise

