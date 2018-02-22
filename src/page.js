import _ from 'lodash';
import cfg from './cfg';
import client from './client';
import screen from './screen';

import {
  roundRect,
  throttle
} from './util';

export let _toJSON = function() {
  return roundRect({
    x: exports.page.x(),
    y: exports.page.y(),
    width: exports.page.width(),
    height: exports.page.height(),

    zoomFactorPercentile: _.round(exports.page.zoomFactor() * 100)
  });
};

// page relative to window (top frame) | in device px
// aka layout viewport, document
export let page = {
  x: function() {
    return client.x() - client.scroll.x();
  },

  y: function() {
    return client.y() - client.scroll.y();
  },

  width: throttle(function() {
    return _.max([ // same as jQuery(document).width
      document.body.scrollWidth,
      document.documentElement.scrollWidth,
      document.body.offsetWidth,
      document.documentElement.offsetWidth,
      document.documentElement.clientWidth
    ]) * screen.osZoomFactor();
  }),

  height: throttle(function() {
    return _.max([ // same as jQuery(document).height
      document.body.scrollHeight,
      document.documentElement.scrollHeight,
      document.body.offsetHeight,
      document.documentElement.offsetHeight,
      document.documentElement.clientHeight
    ]) * screen.osZoomFactor();
  }),

  zoomFactor: function() {
    return cfg.page.zoomFactor;
  },

  toJSON: exports._toJSON
};

export default page;
