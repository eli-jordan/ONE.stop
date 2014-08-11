define [
  './CoffeeMix'
  'dijit/_WidgetsInTemplateMixin'
  'dijit/_TemplatedMixin'
  'dijit/_WidgetBase'
  'dojo/store/Memory'
  'dojo/dom-class'
  'dojo/dom-style'
  './ProfessionData'
  'dojo/text!./templates/ProfessionalDetailsTemplate.html'

  # required by template
  'dijit/form/FilteringSelect'
], (CoffeeMix, _WidgetsInTemplateMixin, _TemplatedMixin, _WidgetBase, Memory, DomClass, DomStyle, ProfessionData, ProfessionalDetailsTemplate) ->
  class ProfessionalDetails extends CoffeeMix(_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin)

    ##
    # The widget template
    ##
    templateString: ProfessionalDetailsTemplate

    ##
    # The cost center input field
    ##
    _costCenterInput: undefined

    ##
    # The job title input field
    ##
    _jobTitleInput: undefined

    ##
    # The checkbox indicating if the defaults should be used
    ##
    _defaultsCheckBox: undefined

    ##
    # Search manager select
    ##
    _searchManager: undefined

    ##
    # The message box showing that the fields were auto-populated
    ##
    _messageBox: undefined

    ##
    # Toggle whether to use the default values
    ##
    _toggleUseDefaults: () ->
      console.log("Toggling use default details", arguments)
      if @_defaultsCheckBox.checked
        @_setEnablement(false)
      else
        @_setEnablement(true)

    ##
    # Configure the event handlers
    ##
    postCreate: () ->
      @_setupManagerSearch()

      # set the defaults checkbox and the enablement of the fields
      @_defaultsCheckBox.checked = true
      @_setEnablement(false)

    _setupManagerSearch: () ->
      # set properties on the search for manager field
      @_searchManager.set("hasDownArrow", false)
      @_searchManager.set("placeholder", "Search for the employees manager")
      @_searchManager.set("store", new Memory({
        data: ProfessionData.getManagers()
      }))

      @_searchManager.watch "item", (name, oldValue, newValue) =>
        console.log("Manager Changed", name, oldValue, newValue)

        costCenter = ProfessionData.getCostCenter(newValue.id).name
        jobTitles = new Memory({
          data: ProfessionData.getJobTitles(newValue.id)
        })

        @_costCenterInput.value = costCenter
        @_jobTitleInput.set("store", jobTitles)
        @_jobTitleInput.set("item", jobTitles.query()[0])
        DomStyle.set(@_messageBox, display: '')

    ##
    # Callback for when the search button is clicked
    ##
    _searchClicked: () ->
      console.log("Search clicked", arguments)
      @_searchManager.toggleDropDown()

    ##
    # Set the whether the details fields can be edited
    ##
    _setEnablement: (enabled) ->
     @_costCenterInput.disabled = not enabled
     @_jobTitleInput.set("disabled", not enabled)

     if not enabled
       DomClass.add(@_costCenterInput, "disabled")
       DomClass.add(@_jobTitleInput.domNode, "disabled")
     else
       DomClass.remove(@_costCenterInput, "disabled")
       DomClass.remove(@_jobTitleInput.domNode, "disabled")