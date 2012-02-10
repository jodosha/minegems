(function($){
  $(function() {
    $('#show_deploy_password').click(function() {
      var input = $('#deploy_password');
      var type  = input.attr('type') == 'password' ? 'text' : 'password'
      input.replaceWith('<input type="'+type+'" value="'+input.val()+'" class="title" id="deploy_password" />');
      $(this).val(type == 'password' ? 'Show' : 'Hide');
    });

    $('form#user_new').validate({
      fields: {
        subdomain_tld: {
          url: '/subdomains/search.json'
        },
        user_username: {
          url: '/users/search.json'
        }
      }
    });

    $('a.sign-in, a.sign-up').click(function() {
      $('div#sign-up-box, div#sign-in-box').fadeToggle(function() {
        $('input:not(:visible)').attr('disabled', 'disabled');
        $("input[name='authenticity_token'], input:visible, input#user_remember_me, input#utf8").removeAttr('disabled');
        $('form#user_new').attr('action', $('div#sign-in-box').is(':visible') ? '/subdomains' : '/users');
      });

      return false;
    });

    $('input#subdomain_tld').keyup(function() {
      var value = 'https://' + $(this).val() + '.minege.ms';
      $('p#subdomain-tld').text(value);
    });
  });
}(jQuery));
