'use strict'

describe 'Service: Balanced', () ->

  # load the service's module
  beforeEach module 'penelophantFrontendApp'

  # instantiate service
  Balanced = {}
  beforeEach inject (_Balanced_) ->
    Balanced = _Balanced_

  it 'should do something', () ->
    expect(!!Balanced).toBe true
