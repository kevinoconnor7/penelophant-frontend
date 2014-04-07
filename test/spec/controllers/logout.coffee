'use strict'

describe 'Controller: LogoutCtrl', () ->

  # load the controller's module
  beforeEach module 'penelophantFrontendApp'

  LogoutCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LogoutCtrl = $controller 'LogoutCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
