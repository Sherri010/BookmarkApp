
$(document).ready(function(){
  console.log('js loaded');

  $('.remove').on('click',function(e){
      var path = "/bookmarks/"+ $(this).attr("id");
       $.ajax({
        type:'DELETE',
        url: path,
        success:function(data){
          console.log("deleted")
        }
       });
       window.location.replace("/bookmarks");

   });
});