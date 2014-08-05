define [
  'dojo/Evented'
  './CoffeeMix'
  'dijit/_TemplatedMixin'
  'dijit/_WidgetBase'
  'dojo/json'
  'dojo/request/xhr'
  'dojo/text!./templates/CreateNewTaskTemplate.html'
], (Evented, CoffeeMix, _TemplatedMixin, _WidgetBase, JSON, xhr, CreateNewTaskTemplate) ->
  class CreateNewTaskView extends CoffeeMix(_WidgetBase, _TemplatedMixin, Evented)

    ##
    # The template for the create form
    ##
    templateString: CreateNewTaskTemplate

    ##
    # The html form node attach point
    ##
    _textField: undefined

    ##
    # The action button
    ##
    _button: undefined

    _data: undefined

    setData: (data) ->
      @_data = data
      @_button.innerHTML = "Save"
      @_textField.value = data.description

    clearData: () ->
      @_data = undefined
      @_button.innerHTML = "Create"


    ##
    # The create button handler
    ##
    onCreateClicked: () ->
      if(@_data)
        @_updateTask()
      else
        @_createTask()

    _updateTask: () ->
      text = @_textField.value
      if(text)
        @_data.description = text
        xhr.put("/api/tasks/" + @_data.id, {
            handleAs: "json"
            headers : { "Content-Type": "application/json" }
            data: JSON.stringify(@_data)
        }).then(@_onSuccessfullyUpdated)

    _createTask: () ->
      console.log("Create button clicked")
      text = @_textField.value
      console.log("Creating with text: ", text)

      if(text)
        xhr.post("/api/tasks", {
          handleAs: "json"
          headers : { "Content-Type": "application/json" }
          data : JSON.stringify(description: text)
        }).then(@_onSuccessfullyCreated)

    ##
    # Invoked when the task has been successfully created on the server
    ##
    _onSuccessfullyCreated: (data) =>
      console.log("Success: ", data)
      @emit("new-task", data)
      @_textField.value = ""

    _onSuccessfullyUpdated: (data) =>
      @_onSuccessfullyCreated(data)
      @clearData()


