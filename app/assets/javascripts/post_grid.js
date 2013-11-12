window.POST_GRID = function(){}
POST_GRID.prototype = {

  container: null,

  masonry_object: null,

  init: function()
  {
    this.container = $('.index_grid');
    var current_inst = this;
    
    $('.post').on('click', function(data)
    {
      current_inst.load_post_url($(this));
    });
    this.initialize_masonry_grid();
    this.initialize_infinite_scroll();
  },

  initialize_masonry_grid: function()
  {
    this.masonry_object = this.container.masonry(
    {
      itemSelector: '.post', 
      columnWidth: '.post'});
    $('.remove_me').remove();
    $('.index_grid').css({'visibility': 'visible'});
  }, 

  initialize_infinite_scroll: function()
  {
    var current_inst = this;
    this.container.infinitescroll(
    {
      navSelector  : '#page-nav',    // selector for the paged navigation 
      nextSelector : 'a#page-nav',   // selector for the NEXT link (to page 2)
      itemSelector : '.post',        // selector for all items you'll retrieve
      loading: 
      {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/6RMhx.gif'
      }
    },  function( newElements ) 
        {
          // trigger Masonry as a callback
          var $newElems = $( newElements );
          current_inst.container.masonry( 'appended', $newElems );

          $newElems.on('click', function(data)
            {
              current_inst.load_post_url($(this));
            });

          $('img', newElements).on('load', function(data)
            {
              current_inst.initialize_masonry_grid();
            });
        });        
  },

  load_post_url: function(elem)
  {
    window.location.href = elem.data()['url'];
  }
}
