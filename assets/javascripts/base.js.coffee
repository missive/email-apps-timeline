html = document.documentElement

# Global namespace
window.Website = {
  Pages: {}
}

# Touch
Website.IS_TOUCH_DEVICE = window.ontouchend != undefined

# Transitions
Website.HAS_TRANSITIONS = false
prefixes = ['webkit', 'Moz', 'Ms', 'O']
for prefix in prefixes
  if html.style["#{prefix}Transition"] != undefined
    html.className += " #{prefix.toLowerCase()}"
    Website.HAS_TRANSITIONS = true
    Website.BROWSER = prefix.toLowerCase()

# SVG
Website.HAS_SVG = !!document.createElementNS && !!document.createElementNS('http://www.w3.org/2000/svg', 'svg').createSVGRect

# Retina
Website.IS_RETINA = `('devicePixelRatio' in window && devicePixelRatio > 1) || ('matchMedia' in window && matchMedia("(min-resolution:144dpi)").matches)`

# HTML classes
html.className = html.className.replace 'no-js', 'js'
html.className += if Website.IS_TOUCH_DEVICE then ' touch' else ' non-touch'
html.className += if Website.HAS_TRANSITIONS then ' has-transitions' else ''
html.className += if Website.HAS_SVG then ' has-svg' else ''
html.className += if Website.IS_RETINA then ' retina' else ''
html.className += ' ios ipad'   if /\bipad\b/i.test navigator.userAgent
html.className += ' ios iphone' if /\biphone\b/i.test navigator.userAgent
if /safari/i.test navigator.userAgent
  html.className += ' safari-8' if /version\/8/i.test navigator.userAgent
  html.className += ' safari-9' if /version\/9/i.test navigator.userAgent
html.className += ' firefox-3' if /firefox\/3/i.test navigator.userAgent
html.className += ' chrome' if /Chrome/.test navigator.userAgent

# HTML5 Shiv
for elem in ['article', 'aside', 'canvas', 'details', 'figcaption', 'figure', 'footer', 'header', 'hgroup', 'mark', 'menu', 'nav', 'section', 'summary', 'time']
  document.createElement elem
