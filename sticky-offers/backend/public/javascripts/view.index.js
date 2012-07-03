var indexController = (function() {

  var parseLinks = $(document).ready(function() {
    $('li a').click(function() {
      var name = $(this).text();
      $.get('/showdiscount/' + name, function(data) {
        $('#image').append("<img src='" + data + "'/>");
      }); 
    });
  });

  return {
    parseLinks: parseLinks
  }

})();

indexController.parseLinks();