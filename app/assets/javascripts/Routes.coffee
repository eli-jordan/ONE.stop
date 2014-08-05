define [
  'dojo/router'
], (Router) ->

  console.log("Registering routes...")

  Router.register "!/test/views/:id", (event) ->
    console.log("test/views/id", event.params, event.oldPath, event.newPath)

  Router.register "!/test/views/foo", (event) ->
    console.log("test/views/foo", event.params, event.oldPath, event.newPath)

  Router.startup()
  Router.go("!/test/views/123456789")