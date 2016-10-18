$(document).ready(function() {
  formhelper();
});

function formhelper() {

  function subtypeBra() {
    if ( $('#piece_sub_type').val() == 'bra' ) {
      var subType = 'LING'
      $.ajax({
        url: '/pieces/get_sizelist',
        data: { 'subtype': subType },
        dataType: 'JSON',
        success: function(data) {
          var sizes = $.map(data, function(v) { return v; });
          $("#piece_size").children().remove();
          var $newSizes = sizes.map(function(val){
            return '<option value="'+ val + '">' + val + '</option>';
          });
          $("#piece_size").append($newSizes);
        }
      });
    } else  {
      var subType = 'UK'
      $.ajax({
        url: '/pieces/get_sizelist',
        data: { 'subtype':subType },
        dataType: 'JSON',
        success: function(data) {
          var sizes = $.map(data, function(v) { return v; });
          $("#piece_size").children().remove();
          var $newSizes = sizes.map(function(val){
            return '<option value="'+ val + '">' + val + '</option>';
          });
          $("#piece_size").append($newSizes);
        }
      });
    }
  };

  $("#piece_product_type").change(function() {
    var productType = $("#piece_product_type").val();
    // console.log(productType);
    $.ajax({
      url: '/pieces/get_subtype',
      data: { 'productType':productType },
      dataType: 'JSON',
      success: function(data) {
        var values = $.map(data, function(v) { return v; });
        $("#piece_sub_type").children().remove();
        var $newOptions = values.map(function(val){
          return '<option value="'+ val + '">' + val + '</option>';
        });
        $("#piece_sub_type").append($newOptions);
        subtypeBra();
      }
    });
  }
  );

  $("#piece_sub_type").change( subtypeBra );
}
