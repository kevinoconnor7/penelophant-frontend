'use strict'

describe 'Controller: InvoicesCtrl', () ->

  # load the controller's module
  beforeEach module 'penelophantFrontendApp'

  InvoicesCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    InvoicesCtrl = $controller 'InvoicesCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
