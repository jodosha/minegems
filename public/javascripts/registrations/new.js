$(document).ready(function() {
  $('a.sign-in, a.sign-up').click(function( ) {
    $('div#sign-up-box, div#sign-in-box').fadeToggle(function( ) {
      $('input:not(:visible)').attr('disabled', 'disabled');
      $("input[name='authenticity_token'], input:visible, input#user_remember_me, input#utf8").removeAttr('disabled');
      $('form').attr('action', $('div#sign-in-box').is(':visible') ? '/subdomains' : '/users');
    });

    return false;
  });
});
