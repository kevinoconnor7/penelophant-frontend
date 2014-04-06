# =============================================================
# * flatui-radio v0.0.3
# * ============================================================
not ($) ->

  # RADIO PUBLIC CLASS DEFINITION
  #  * ==============================
  Radio = (element, options) ->
    @init element, options
    return

  Radio:: =
    constructor: Radio
    init: (element, options) ->
      $el = @$element = $(element)
      @options = $.extend({}, $.fn.radio.defaults, options)
      $el.before @options.template
      @setState()
      return

    setState: ->
      $el = @$element
      $parent = $el.closest(".radio")
      $el.prop("disabled") and $parent.addClass("disabled")
      $el.prop("checked") and $parent.addClass("checked")
      return

    toggle: ->
      d = "disabled"
      ch = "checked"
      $el = @$element
      checked = $el.prop(ch)
      $parent = $el.closest(".radio")
      $parentWrap = (if $el.closest("form").length then $el.closest("form") else $el.closest("body"))
      $elemGroup = $parentWrap.find(":radio[name=\"" + $el.attr("name") + "\"]")
      e = $.Event("toggle")
      $elemGroup.not($el).each ->
        $el = $(this)
        $parent = $(this).closest(".radio")
        $parent.removeClass(ch) and $el.removeAttr(ch).trigger("change")  if $el.prop(d) is false
        return

      if $el.prop(d) is false
        $parent.addClass(ch) and $el.prop(ch, true)  if checked is false
        $el.trigger e
        $el.trigger "change"  if checked isnt $el.prop(ch)
      return

    setCheck: (option) ->
      ch = "checked"
      $el = @$element
      $parent = $el.closest(".radio")
      checkAction = (if option is "check" then true else false)
      checked = $el.prop(ch)
      $parentWrap = (if $el.closest("form").length then $el.closest("form") else $el.closest("body"))
      $elemGroup = $parentWrap.find(":radio[name=\"" + $el["attr"]("name") + "\"]")
      e = $.Event(option)
      $elemGroup.not($el).each ->
        $el = $(this)
        $parent = $(this).closest(".radio")
        $parent.removeClass(ch) and $el.removeAttr(ch)
        return

      (if $parent[(if checkAction then "addClass" else "removeClass")](ch) and checkAction then $el.prop(ch, ch) else $el.removeAttr(ch))
      $el.trigger e
      $el.trigger "change"  if checked isnt $el.prop(ch)
      return


  # RADIO PLUGIN DEFINITION
  #  * ========================
  old = $.fn.radio
  $.fn.radio = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("radio")
      options = $.extend({}, $.fn.radio.defaults, $this.data(), typeof option is "object" and option)
      $this.data "radio", (data = new Radio(this, options))  unless data
      data.toggle()  if option is "toggle"
      if option is "check" or option is "uncheck"
        data.setCheck option
      else data.setState()  if option
      return


  $.fn.radio.defaults = template: "<span class=\"icons\"><span class=\"first-icon fui-radio-unchecked\"></span><span class=\"second-icon fui-radio-checked\"></span></span>"

  # RADIO NO CONFLICT
  #  * ==================
  $.fn.radio.noConflict = ->
    $.fn.radio = old
    this


  # RADIO DATA-API
  #  * ===============
  $(document).on "click.radio.data-api", "[data-toggle^=radio], .radio", (e) ->
    $radio = $(e.target)
    e and e.preventDefault() and e.stopPropagation()
    $radio = $radio.closest(".radio")  unless $radio.hasClass("radio")
    $radio.find(":radio").radio "toggle"
    return

  $ ->
    $("[data-toggle=\"radio\"]").each ->
      $radio = $(this)
      $radio.radio()
      return

    return

  return
(window.jQuery)
