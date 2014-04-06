'use strict'

describe 'Controller: AuctionsCtrl', () ->

  # load the controller's module
  beforeEach module 'penelophantFrontendApp'

  AuctionsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AuctionsCtrl = $controller 'AuctionsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
