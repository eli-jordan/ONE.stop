define [
  'dojo/Evented'
  "./CoffeeMix",
  "dijit/_TemplatedMixin"
  "dijit/_WidgetBase"
  "dojo/request/xhr"
  "dojo/dom-construct"
  "dojo/text!todo/templates/TaskListItemTemplate.html"
], (Evented, CoffeeMix, _TemplatedMixin, _WidgetBase, xhr, DomConstruct, TaskListItemTemplate) ->

  class TaskItem extends CoffeeMix(_WidgetBase, _TemplatedMixin)

    ##
    # The template
    ##
    templateString: TaskListItemTemplate

    ##
    # The data for the represented item
    ##
    taskData: undefined

    ##
    # The list widget this list item belongs to
    ##
    parent: undefined

    _onMarkComplete: () ->
      console.log("Mark compltete", @taskData)
      @parent.emit("mark-task-complete", @taskData)

    _onEdit: () ->
      console.log("Edit", @taskData)
      @parent.emit("edit-task", @taskData)

    ##
    # Delete the item, and remove from the screen
    ##
    _onDelete: () ->
      console.log("Delete", @taskData)
      xhr.del("/api/tasks/" + @taskData.id).then () =>
        @destroy()
        @parent.emit("delete-task", @taskData)


  class TaskList extends Evented

    ##
    # The element the list is attached to
    ##
    element: undefined

    _items: undefined

    ##
    # Bind the list to the node identified by the given ID
    ##
    bind: (element) ->
      @_items = []
      @element = element
      success = (data) =>
        @_onServerSuccess(data)

      xhr("/api/tasks", {
        handleAs: "json"
      }).then(success)

    ##
    # Add a new task
    ##
    addTask: (data) ->
      # instantiate the template, and place it in the dom
      taskItem = new TaskItem({
        taskData: data
        parent: @
      })
      taskItem.startup()
      @_items.push(taskItem)
      DomConstruct.place(taskItem.domNode, @element, "last")

    removeTask: (data) ->
      for task, index in @_items
        if data.id == task.taskData.id
          task.destroy()
          @_items.splice(index, 1) # remove the item from the array

    ##
    # Invoked with the result of querying for tasks
    ##
    _onServerSuccess: (tasks) ->
      console.log("tasks: ", tasks)
      for task in tasks
        @addTask(task)

    ##
    # Called if an error occurs
    ##
    _onServerError: (error) -> console.log("Error:", error)



