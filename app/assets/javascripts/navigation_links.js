window.NAVIGATION_LINKS = function() {}
NAVIGATION_LINKS.prototype = {

  path: null,

  init: function(path)
  {
    this.path = path;
    this.retrieve_links();

    $(window).scroll(function() 
    {
     if($(window).scrollTop() + $(window).height() > $(document).height() - 100) 
     {
      $('.previous').show('fade');
      $('.next').show('fade');
      // $(window).unbind('scroll');
     }
     else
     {
      $('.previous').hide('fade');
      $('.next').hide('fade');       
     }
    });
  },

  retrieve_links: function()
  {
    $.get(this.path, function(data)
    {
      $('.navigation_buttons').html(data);
    });
  }  
}