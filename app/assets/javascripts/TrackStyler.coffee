window.App ||= {}
class window.App.TrackStyler
  constructor: ->
    # Style the track of a range input with a different lower and
    # an upper color. Fixed missing -ms-fill-upper and -ms-fill-lower
    # on webkit and firefox
    r = document.querySelectorAll('input[type=range]')
    prefs = [
      'webkit-slider-runnable'
      'moz-range'
    ]
    styles = []
    l = prefs.length
    n = r.length

    getTrackStyleStr = (el, j) ->
      str = ''
      min = el.min or 0
      perc = if el.max then ~~(100 * (el.value - min) / (el.max - min)) else el.value
      val = perc + '%'
      id = el.id
      i = 0
      while i < l
        str += '#' + id + '::-' + prefs[i] + '-track{ background: linear-gradient(90deg, #5cbdb1 ' + val + ', #DDD ' + val + ');} '
        i++
      str

    setDragStyleStr = (evt) ->
      trackStyle = getTrackStyleStr(evt.target, this + 1)
      styles[this].textContent = trackStyle
      return

    i = 0
    while i < n
      s = document.createElement('style')
      document.body.appendChild s
      styles.push s
      r[i].addEventListener 'input', setDragStyleStr.bind(i), false
      i++
    return