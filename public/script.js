
$(document).ready(function(){
  console.log('js loaded');

  $('.remove').on('click',function(e){
      var mark = $(this).attr("id")
       console.log(mark);
      var path = "/bookmarks/"+mark;
       $.ajax({
        type:'DELETE',
        url: path,
        success:function(data){
          window.location.href="./bookmarks";
        }
       });
  });
});