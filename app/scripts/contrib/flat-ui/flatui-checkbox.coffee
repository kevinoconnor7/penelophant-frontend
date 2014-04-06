# =============================================================
# * flatui-checkbox v0.0.3
# * ============================================================
not ($) ->

  # CHECKBOX PUBLIC CLASS DEFINITION
  #  * ==============================
  Checkbox = (element, options) ->
    @init element, options
    return

  Checkbox:: =
    constructor: Checkbox
    init: (element, options) ->
      $el = @$element = $(element)
      @options = $.extend({}, $.fn.checkbox.defaults, options)
      $el.before @options.template
      @setState()
      return

    setState: ->
      $el = @$element
      $parent = $el.closest(".checkbox")
      $el.prop("disabled") and $parent.addClass("disabled")
      $el.prop("checked") and $parent.addClass("checked")
      return

    toggle: ->
      ch = "checked"
      $el = @$element
      $parent = $el.closest(".checkbox")
      checked = $el.prop(ch)
      e = $.Event("toggle")
      if $el.prop("disabled") is false
        (if $parent.toggleClass(ch) and checked then $el.removeAttr(ch) else $el.prop(ch, ch))
        $el.trigger(e).trigger "change"
      return

    setCheck: (option) ->
      d = "disabled"
      ch = "checked"
      $el = @$element
      $parent = $el.closest(".checkbox")
      checkAction = (if option is "check" then true else false)
      e = $.Event(option)
      (if $parent[(if checkAction then "addClass" else "removeClass")](ch) and checkAction then $el.prop(ch, ch) else $el.removeAttr(ch))
      $el.trigger(e).trigger "change"
      return


  # CHECKBOX PLUGIN DEFINITION
  #  * ========================
  old = $.fn.checkbox
  $.fn.checkbox = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("checkbox")
      options = $.extend({}, $.fn.checkbox.defaults, $this.data(), typeof option is "object" and option)
      $this.data "checkbox", (data = new Checkbox(this, options))  unless data
      data.toggle()  if option is "toggle"
      if option is "check" or option is "uncheck"
        data.setCheck option
      else data.setState()  if option
      return


  $.fn.checkbox.defaults = template: "<span class=\"icons\"><span class=\"first-icon fui-checkbox-unchecked\"></span><span class=\"second-icon fui-checkbox-checked\"></span></span>"

  # CHECKBOX NO CONFLICT
  #  * ==================
  $.fn.checkbox.noConflict = ->
    $.fn.checkbox = old
    this


  # CHECKBOX DATA-API
  #  * ===============
  $(document).on "click.checkbox.data-api", "[data-toggle^=checkbox], .checkbox", (e) ->
    $checkbox = $(e.target)
    unless e.target.tagName is "A"
      e and e.preventDefault() and e.stopPropagation()
      $checkbox = $checkbox.closest(".checkbox")  unless $checkbox.hasClass("checkbox")
      $checkbox.find(":checkbox").checkbox "toggle"
    return

  $ ->
    $("[data-toggle=\"checkbox\"]").each ->
      $checkbox = $(this)
      $checkbox.checkbox()
      return

    return

  return
(window.jQuery)
