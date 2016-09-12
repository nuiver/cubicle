$(document).ready(function() {
  viewFilter();
});


function viewFilter() {

  $('#filter_button_link').click(function(e) {
    e.preventDefault();
    console.log("Function called");
    $('#filterbox').slideToggle();
  });

};
