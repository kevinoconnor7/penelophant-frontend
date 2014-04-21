'use strict'

describe 'Directive: validator/creditCardNumber', () ->

  # load the directive's module
  beforeEach module 'penelophantFrontendApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<validator/credit-card-number></validator/credit-card-number>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the validator/creditCardNumber directive'
