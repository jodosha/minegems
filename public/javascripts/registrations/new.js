/*!
 * registrations/new.js v0.0.1
 * Copyright 2010, Sushistar
 *
 * requires:
 *  - jquery.js
 *  - jquery.validations.js
 */
$(document).ready(function() {
  $('form#user_new').validate({
    fields: {
      subdomain_tld: {
        url: '/subdomains/search.json'
      }
    }
  });

  $('a.sign-in, a.sign-up').click(function( ) {
    $('div#sign-up-box, div#sign-in-box').fadeToggle(function( ) {
      $('input:not(:visible)').attr('disabled', 'disabled');
      $("input[name='authenticity_token'], input:visible, input#user_remember_me, input#utf8").removeAttr('disabled');
      $('form#user_new').attr('action', $('div#sign-in-box').is(':visible') ? '/subdomains' : '/users');
    });

    return false;
  });

  $('input#subdomain_tld').keyup(function( ){
    var value = 'https://' + $(this).val() + '.gemsmineapp.com';
    $('p#subdomain-tld').text(value);
  });
});
