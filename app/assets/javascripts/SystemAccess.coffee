define [
  './CoffeeMix'
  'dijit/_WidgetsInTemplateMixin'
  'dijit/_TemplatedMixin'
  'dijit/_WidgetBase'
  'dojo/dom-construct'
  'dojo/store/Memory'
  './ProfessionData'
  'dojo/text!./templates/SystemAccessTemplate.html'
  'dojo/text!./templates/SystemAccessItemTemplate.html'

  # used by template
  'dijit/form/FilteringSelect'
], (CoffeeMix,_WidgetsInTemplateMixin, _TemplatedMixin, _WidgetBase, DomConstruct, Memory, ProfessionData, SystemAccessTemplate, SystemAccessItemTemplate) ->

  class SystemAccessRow extends CoffeeMix(_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin)

    ##
    # The template string
    ##
    templateString: SystemAccessItemTemplate

    ##
    # The data
    ##
    data: undefined

    _onDelete: () -> @destroy()


  class SystemAccess extends CoffeeMix(_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin)
    ##
    # The template string
    ##
    templateString: SystemAccessTemplate

    ##
    # The list of system accesses
    ##
    _systemsListNode: undefined

    ##
    # The add new system drop down
    ##
    _addNewSystemWidget: undefined

    postCreate: () ->
      @_addAllRequests()

      # set the list of all available roles
      @_addNewSystemWidget.set("store", new Memory({
        data: ProfessionData.systems()
      }))
      @_addNewSystemWidget.set("placeholder", "Add system request...")

      @_addNewSystemWidget.watch "item", (name, oldValue, newValue) =>
        console.log("Add New Access", name, oldValue, newValue)
        newValue.status = "Pending"
        @_addNewSystem(newValue)


    _addAllRequests: () ->
      for request in ProfessionData.roles().CCP
        @_addNewSystem(request)

    ##
    # Add a new system request
    ##
    _addNewSystem: (request) ->
      row = new SystemAccessRow({
        data: request
      })
      row.startup()
      DomConstruct.place(row.domNode, @_systemsListNode, "last")


