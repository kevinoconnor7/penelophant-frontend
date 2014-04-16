'use strict'

describe 'Directive: radio', () ->

  # load the directive's module
  beforeEach module 'penelophantFrontendApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<radio></radio>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the radio directive'
