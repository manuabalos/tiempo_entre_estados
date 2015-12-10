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
		// Creamos el calendario de los festivos
		var today = new Date();
		var y = today.getFullYear();
		$('#calendar').multiDatesPicker({
			numberOfMonths: [3,4],
			defaultDate: '1/1/'+y,
			firstDay: 1,
			dayNamesMin: ["D","L","M","X","J","V","S"],
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
		});

		// Recogemos las dias seleccionados (para el holiday#edit) para mostrarlos en el calendario
		var datesHolidays = $("#tee_holiday_date").val();
		if(datesHolidays.length > 0){
			datesHolidays = datesHolidays.split(",");
			$('#calendar').multiDatesPicker('addDates', datesHolidays);
		}
		

		// Asignamos al campo :date del formulario las fechas que se hayan seleccionado en el calendario
		$("#new_tee_holiday").on("submit",function(){
			setHolidaystoDate();
		});

		$(".edit_tee_holiday").on("submit",function(){
			setHolidaystoDate();
		});


		function setHolidaystoDate(){
			var holiday_dates = $('#calendar').multiDatesPicker('getDates');
			$("#tee_holiday_date").val(holiday_dates);
		}
	});
});