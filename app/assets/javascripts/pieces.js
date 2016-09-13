$(document).ready(function() {
  viewFilter();
  starPiece();
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


function starPiece() {

  $("[id^=star-]").click(function(e) {
    e.preventDefault();

    heartId = this.id.match(/[^star-]+/)[0];
    userid = getCookie('userid')

    if ($('#'+this.id).hasClass('fa-star-o')) {
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
        type: "DELETE",
        url: "/hearts/" + heartId + ".json",
        data: JSON.stringify({
            heart: { user_ids: [userid] }
        }),
        contentType: "application/json",
        dataType: "json"})
    };

    $('#'+this.id).toggleClass('fa-star-o');
    $('#'+this.id).toggleClass('fa-star');

  });

};
