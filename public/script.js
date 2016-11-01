
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
          console.log("deleted")
        }
       });
       window.location.replace("/bookmarks");

   });

   $('#add_form').on('submit',function(e){
      e.preventDefault();
      var url_data = $('#url').val();
      var title_data = $('#title').val();

      $.ajax({
        type:'POST',
        url:'/bookmarks',
        data: {url:url_data,title:title_data},
        success:function(data){
          console.log('added')
          alert(title_data+" deleted!");
        }
      });

  });
});