'use strict'

describe 'Directive: accessLevel', () ->

  # load the directive's module
  beforeEach module 'penelophantFrontendApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<access-level></access-level>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the accessLevel directive'
