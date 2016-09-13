$(document).ready(function() {
  viewFilter();
  heartPiece();
});


function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i <ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') {
          c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
          return c.substring(name.length,c.length);
      }
  }
  return "";
}

function viewFilter() {

  $('#filter_button_link').click(function(e) {
    e.preventDefault();
    $('#filterbox').slideToggle();
  });

};


function heartPiece() {

  $("[id^=heart-]").click(function(e) {
    e.preventDefault();

    heartId = this.id.match(/[^heart-]+/)[0];
    userid = getCookie('userid')

    if ($('#'+this.id).hasClass('fa-heart-o')) {
      $.ajax({
        type: "PUT",
        url:  "/hearts/" + heartId + ".json",
        data: JSON.stringify({
            heart: { user_ids: [userid] }
        }),
        contentType: "application/json",
        dataType: "json"
      });
    } else {
      $.ajax({
        type: "PUT",
        url: "/hearts/" + heartId + ".json",
        data: JSON.stringify({
            heart: { user_ids: [] }
        }),
        contentType: "application/json",
        dataType: "json"})
    };

    $('#'+this.id).toggleClass('fa-heart-o');
    $('#'+this.id).toggleClass('fa-heart');

  });

};
