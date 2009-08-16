(function() {

  e = document.createElement('div');
  e.setAttribute('id', 'monkey_bookmarklet');
  e.style.position = "absolute";
  e.style.top = scrollPos().y + "px";
  e.style.border = "1px solid"
  e.style.width = "400px";
  e.style.height = "200px";
  e.style.backgroundColor = "#ffffff";
  e.style.zIndex = 10000;
  e.innerHTML = "<iframe frameborder='0' src='http://localhost:3000/bookmarklet' style='width:100%;height:100%;'></iframe>"
  document.body.appendChild(e);

  function scrollPos() {
    if (self.pageYOffset !== undefined) {
      return {
        x: self.pageXOffset,
        y: self.pageYOffset
      };
    }
    var d = document.documentElement;
    return {
      x: d.scrollLeft,
      y: d.scrollTop
    };
  }



  // new Ajax.Request('http://localhost:3000/bookmarklet', {method:'get', onSuccess:function(transport) {
  //     $('monkey_bookmarklet').update(transport.responseText);
  //   }
  // });

})();
