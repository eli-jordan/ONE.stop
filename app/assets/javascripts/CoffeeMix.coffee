define [
    "dojo/_base/declare",
],
(declare) ->

  ##
  # Provides a helper function that allows CoffeeScript
  # classes to mixin dojo classes
  ##
  (mixins...) -> declare(mixins, {})

