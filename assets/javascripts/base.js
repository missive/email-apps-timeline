(function() {
  var elem, html, i, j, len, len1, prefix, prefixes, ref;

  html = document.documentElement;

  window.Website = {
    Pages: {}
  };

  Website.IS_TOUCH_DEVICE = window.ontouchend !== void 0;

  Website.HAS_TRANSITIONS = false;

  prefixes = ['webkit', 'Moz', 'Ms', 'O'];

  for (i = 0, len = prefixes.length; i < len; i++) {
    prefix = prefixes[i];
    if (html.style[prefix + "Transition"] !== void 0) {
      html.className += " " + (prefix.toLowerCase());
      Website.HAS_TRANSITIONS = true;
      Website.BROWSER = prefix.toLowerCase();
    }
  }

  Website.HAS_SVG = !!document.createElementNS && !!document.createElementNS('http://www.w3.org/2000/svg', 'svg').createSVGRect;

  Website.IS_RETINA = ('devicePixelRatio' in window && devicePixelRatio > 1) || ('matchMedia' in window && matchMedia("(min-resolution:144dpi)").matches);

  html.className = html.className.replace('no-js', 'js');

  html.className += Website.IS_TOUCH_DEVICE ? ' touch' : ' non-touch';

  html.className += Website.HAS_TRANSITIONS ? ' has-transitions' : '';

  html.className += Website.HAS_SVG ? ' has-svg' : '';

  html.className += Website.IS_RETINA ? ' retina' : '';

  if (/\bipad\b/i.test(navigator.userAgent)) {
    html.className += ' ios ipad';
  }

  if (/\biphone\b/i.test(navigator.userAgent)) {
    html.className += ' ios iphone';
  }

  if (/safari/i.test(navigator.userAgent)) {
    if (/version\/8/i.test(navigator.userAgent)) {
      html.className += ' safari-8';
    }
    if (/version\/9/i.test(navigator.userAgent)) {
      html.className += ' safari-9';
    }
  }

  if (/firefox\/3/i.test(navigator.userAgent)) {
    html.className += ' firefox-3';
  }

  if (/Chrome/.test(navigator.userAgent)) {
    html.className += ' chrome';
  }

  ref = ['article', 'aside', 'canvas', 'details', 'figcaption', 'figure', 'footer', 'header', 'hgroup', 'mark', 'menu', 'nav', 'section', 'summary', 'time'];
  for (j = 0, len1 = ref.length; j < len1; j++) {
    elem = ref[j];
    document.createElement(elem);
  }

}).call(this);
