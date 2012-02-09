/*!
 * jQuery Validations v0.0.1
 * Copyright 2010, Sushistar
 *
 * requires:
 *  - jquery.js
 */
(function( $ ){
  jQuery.extend(jQuery.expr[':'], {
    invalid: function(a) {
      return $(a).attr('class').match(/invalid/)
    }
  });

  $.fn.extend({
    validate: function( options ) {
      return this.each(function( ) {
        var form = $(this);

        form.bind('validation.start', function( ) {
          var submit = $(this).find(':submit');

          submit.data('original-value', submit.val())
                .attr('disabled', 'disabled')
                .val('Validating..');
        });

        form.bind('validation.end', function( ) {
          var submit = $(this).find(':submit');

          submit.removeAttr('disabled')
                .val(submit.data('original-value'));
        });

        form.submit(function( event ) {
          event.preventDefault();

          withValidationCallbacks( this, function( form ) {
            form.find('input.required').each(function( ) {
              validateRequiredField(this);
            });

            form.find('input.unique').each(function( ) {
              validateUniqueField(this, options.fields[this.id]);
            });

            form.find('input.email').each(function( ) {
              validateEmailField(this);
            });

            form.find('input.confirmation').each(function( ) {
              validateConfirmationField(this);
            });
          });

          if ( isValid(this) ) {
            $(this).unbind('submit').submit();
          }

          return false;
        });
      });
    }
  });

  // private
  function isValid( form ) {
    // FIXME
    // return $(form).find('input:invalid').length == 0;

    var count = 0;
    $(form).find('input').each(function( ){
      if ( $(this).attr('class').match(/invalid/) )
        count++;
    });

    return count == 0;
  }

  function withValidationCallbacks( form, fn ) {
    form = $(form);
    form.trigger('validation.start')
    fn(form)
    form.trigger('validation.end')
  }

  function validateRequiredField( input ) {
    var input = $(input)
    if ( input.val() != "" ) {
      markAsValid(input, 'required')
    } else {
      markAsInvalid(input, 'required', 'This is a required field.')
    }
  }

  function validateUniqueField( input, options ) {
    var input  = $(input);
    var result = $.getJSON(options.url + '?q=' + encodeURIComponent(input.val()), function( data ) {
      if ( data && data.length > 0 ) {
        markAsInvalid(input, 'unique', 'It has been already taken.')
      } else {
        markAsValid(input, 'unique')
      }
    });
  }

  function validateEmailField( input ) {
    var input  = $(input);
    var regexp = /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i

    if ( input.val().match(regexp) ) {
      markAsValid(input, 'email')
    } else {
      markAsInvalid(input, 'email', 'A valid email address is required.')
    }
  }

  function validateConfirmationField( input ) {
    var input = $(input);
    var confirmationInput = $('#' + input.attr('id') + '_confirmation');

    if ( input.val() == confirmationInput.val() ) {
      markAsValid(input, 'confirmation')
      markAsValid(confirmationInput, 'confirmation')
    } else {
      markAsInvalid(input, 'confirmation', 'It must match')
      markAsInvalid(confirmationInput, 'confirmation', 'It must match')
    }
  }

  function markAsValid( input, type ) {
    input.removeClass('invalid-' + type)
         .parent().find('.validation-message span.' + type).text('');
  }

  function markAsInvalid( input, type, message ) {
    input.addClass('invalid-' + type)
    var messageContainer = input.parent().find('.validation-message span.' + type);
    if ( messageContainer.length == 0 ) {
      input.parent().find('.validation-message').append('<span class="'+type+'"> '+message+'</span>');
    }
  }
}(jQuery));