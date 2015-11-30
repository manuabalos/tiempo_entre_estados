(function ($) {
  var ready = $.fn.ready;
  $.fn.ready = function (fn) {
    if (this.context === undefined) {
      // The $().ready(fn) case.
      ready(fn);
    } else if (this.selector) {
      ready($.proxy(function(){
        $(this.selector, this.context).each(fn);
      }, this));
    } else {
      ready($.proxy(function(){
        $(this).each(fn);
      }, this));
    }
  }
})(jQuery);

$(document).ready(function(){
	$(".holidays.index").ready(function() {
		var today = new Date();
		var y = today.getFullYear();
		$('#calendar').multiDatesPicker({
			addDates: ['10/14/'+y, '02/19/'+y, '01/14/'+y, '11/16/'+y],
			numberOfMonths: [3,4],
			defaultDate: '1/1/'+y,
			altField: '#prueba',
			firstDay: 1,
			dayNamesMin: ["D","L","M","X","J","V","S"],
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
		});
		/*		
		window.setInterval(function(){
			console.log($('#calendar').multiDatesPicker('getDates'));
		}, 5000);
		*/
	});
});