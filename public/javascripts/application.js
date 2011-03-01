/*!
 * Mine Gems application v0.0.1
 * Copyright 2011, Bootstrapp (http://bootstrapp.io)
 *
 * requires:
 *  - jquery.js
 */
(function( $ ){
 $.fn.extend({
   center: function( ) {
     return this.each(function( ) {
       self = $(this);
       self.css('position', 'absolute');
       self.css('left', ( $(window).width() - self.width() ) / 2 + $(window).scrollLeft() + 'px');
     });
   }
 });

 $(document).ready(function() {
   $('.center').center();
 });
}(jQuery));