$(document).ready(function() {
  $('a.sign-in, a.sign-up').click(function( ) {
    $('div#sign-up-box, div#sign-in-box').fadeToggle(function( ) {
      $('input:visible').removeAttr('disabled');
      $('input:not(:visible)').attr('disabled', 'disabled');
      $('input#signin').toggleClass('signin')
                       .removeAttr('disabled')
                       .val($('div#sign-in-box').is(':visible') ? 1 : 0);
    });

    return false;
  });
});
