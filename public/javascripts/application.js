$(function() {
  if($('#first-focus').length > 0) {
    $('#first-focus').focus();
  } else {
    $("form:not(.filter) :input:visible:enabled:first").focus();
  }
});

var Strappy = function() {
  return {
    updateSortables: function(parent) {
      var elems = $(parent + ' ul li .position'), i = 1
      elems.each(function() {
        this.value = i++
      })
    },

    sizeTehToolbars: function() {
      $('.textile-toolbar').each(function() {
        box_id = this.id.replace('textile-toolbar-', '')
        $(this).css('width', $('#' + box_id).css('width'))
      })
    },

    load_gat: function(code) {
      if (code) {
        var host = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
        jQuery.getScript(host + "google-analytics.com/ga.js", function(){
          var tracker = _gat._getTracker(code);
          tracker._initData();
          tracker._trackPageview();
        });
      }
    }
  };
}();
