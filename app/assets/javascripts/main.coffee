define [
    "bootstrap/bootstrap.min"
    "dojo/domReady!"
],
() ->
  class TaskListApplication
    init: () ->
      console.log("Initializing...")

  # return the module
  new TaskListApplication()

