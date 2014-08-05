define [
  './CoffeeMix'
  'dijit/_TemplatedMixin'
  'dijit/_WidgetBase'
  './TaskListView'
  './CreateNewTaskView'
  "dojo/text!./templates/TaskManagerTemplate.html"
], (CoffeeMix, _TemplatedMixin, _WidgetBase, TaskListView, CreateNewTaskView, TaskManagerTemplate) ->
  class TaskManagerPresenter extends CoffeeMix(_WidgetBase, _TemplatedMixin)
    ##
    # The widget template
    ##
    templateString: TaskManagerTemplate

    ##
    # The node where the list of tasks is displayed
    ##
    _tasksListNode: undefined

    ##
    # The node where the create new task 'form' is
    ##
    _createTaskNode: undefined

    ##
    # Wire up all the widgets
    ##
    postCreate: () ->
      # create the list view
      @taskList = new TaskListView()
      @taskList.bind(@_tasksListNode)

      # create the new task form
      @newTaskWidget = new CreateNewTaskView()
      @newTaskWidget.placeAt(@_createTaskNode)

      # wire up the event listeners
      @newTaskWidget.on "new-task", @_onNewTask
      @taskList.on "mark-task-complete", @_onCompleteTask
      @taskList.on "edit-task", @_onEditTask

    ##
    # Handles the new task event
    ##
    _onNewTask: (task) =>
      console.log("Presenter New Task: ", task)
      @taskList.addTask(task)

    ##
    # Handles when a task is checked of as done
    ##
    _onCompleteTask: (task) =>
      console.log("Presenter Mark Complete: ", task)

    ##
    # Handles when a task is edited
    ##
    _onEditTask: (task) =>
      console.log("Presenter Edit Task: ", task)
      @newTaskWidget.setData(task)
      @taskList.removeTask(task)



