window.ADD_COMMENT_BOX = function() {}
ADD_COMMENT_BOX.prototype = {

  expanded: false,

  init: function()
  {
    this.initialize_focus_events();
    this.initialize_submit();
  },

  initialize_focus_events: function()
  {
    var current_inst = this;
    $('.comment_text').on('focus', function()
    {
      var $this = $(this);
      $('.comment_field').removeClass('hidden');
      if (!current_inst.expanded)
      {
        $this.animate({height:'+=32px'}, 'linear');
        current_inst.expanded = true;
      }
      
    });

    $('.comment_text').on('blur', function()
    {
      var $this = $(this);
      if ($this.val().length <= 0)
      {
        $this.animate({height:'-=32px'}, 'linear');
        current_inst.expanded = false;
      }
    });
  },

  initialize_submit: function()
  {

    $("form.simple_form").submit(function(event) 
    {

      if (!$('#human_checkbox').is(':checked'))
      {
        event.preventDefault();
        alert('Please verify that you are a human by clicking on the checkbox. Thank you!');
        return;
      }

      var $form = $( this ),
          url = $form.attr( 'action' );
      $form.bind("ajax:success", function(event, data, status, xhr) 
      {
        $('.add_comment').html('<div class="thanks"><p>Thanks for posting!</p></div>').show('slide');
        $('.comment_list').prepend(data);
      });

    });
  }
};
