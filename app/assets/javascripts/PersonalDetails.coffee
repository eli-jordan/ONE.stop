define [
  'dijit/_WidgetsInTemplateMixin',
  'dojo/store/Memory'
  './CoffeeMix'
  'dijit/_TemplatedMixin'
  'dijit/_WidgetBase'
  'dojo/text!./templates/PersonalDetailsTemplate.html'

  # referenced in template
  'dijit/form/FilteringSelect'
], (_WidgetsInTemplateMixin, Memory, CoffeeMix, _TemplatedMixin, _WidgetBase, PersonalDetailsTemplate) ->

  COUNTRIES = [
    {id: "AU", name: "Australia"},
    {id: "MY", name: "Malaysia"},
    {id: "NA", name: "North America"},
    {id: "SG", name: "Singapore"},
    {id: "UK", name: "United Kingdom"}
  ]

  SITES_BY_COUNTRY = {
    AU: [
      {id: "BRISBANE", name: "Brisbane - Queen Street"},
      {id: "MELBOURNE", name: "Melbourne - Collins Street"},
      {id: "SYDSHELLEY", name: "Sydney - Shelley Street"},
      {id: "SYDATRIUM", name: "Sydney - Atrium"}
    ]
    MY: [
      {id: "KL", name: "Kuala Lumpur - Menara Weld"}
    ]
    NA: [
      {id: "AEDR", name: "Arizona - AEDR"},
      {id: "AESCP", name: "Arizona - AESCP"},
      {id: "TRCW", name: "Arizona - TRCW"}
    ]
    SG: [
      {id: "MAPLETREE", name: "Singapore - Mapletree Business City"},
      {id: "MBFC", name: "Singapore - MBFC"}
    ]
    UK: [
      {id: "AMEXHOUSE", name: "Brighton - Amex House"},
      {id: "TELECOMHOUSE", name: "Brighton - Telecom House"},
      {id: "LONDON", name: "London - Belgrave House"}
    ]
  }

  class PersonalDetails extends CoffeeMix(_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin)
    ##
    # The template for this widget
    ##
    templateString: PersonalDetailsTemplate

    ##
    # The dropdown for the filtering select for countries
    ##
    _countrySelect: undefined

    ##
    # The dropdown for site selection
    ##
    _siteSelect: undefined

    ##
    # Setup the widget
    ##
    postCreate: () ->
      @_setupCountrySelection()


    ##
    # Setup the country selections
    ##
    _setupCountrySelection: () ->
      countries = new Memory({
        data: COUNTRIES
      })
      @_countrySelect.set("store", countries)

      ##
      # Watch for changes to the selected country, and update the available sites
      ##
      @_countrySelect.watch "item", (name, oldValue, newValue) =>
        console.log("Country Chnaged", name, oldValue, newValue)
        sites = SITES_BY_COUNTRY[newValue.id]
        @_siteSelect.set("store", new Memory({
          data: sites
        }))

