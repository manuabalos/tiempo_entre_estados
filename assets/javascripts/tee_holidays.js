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
		/*var today = new Date();
		var y = today.getFullYear();
		$('#calendar').multiDatesPicker({
			addDates: ['10/14/'+y, '02/19/'+y, '01/14/'+y, '11/16/'+y],
			numberOfMonths: [3,4],
			defaultDate: '1/1/'+y,
			altField: '#prueba',
			firstDay: 1,
			dayNamesMin: ["D","L","M","X","J","V","S"],
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
		});*/
		/*		
		window.setInterval(function(){
			console.log($('#calendar').multiDatesPicker('getDates'));
		}, 5000);
		*/

		var today = new Date();
		var y = today.getFullYear();
		$('#calendar').multiDatesPicker({
			numberOfMonths: [3,4],
			defaultDate: '1/1/'+y,
			firstDay: 1,
			dayNamesMin: ["D","L","M","X","J","V","S"],
			monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
		});

		$("#new_tee_holiday").on("submit",function(){

			// var holiday_project = $("#tee_holidays_project_id").val();
			// var holiday_name = $("#tee_holiday_name").val();
			var holiday_dates = $('#calendar').multiDatesPicker('getDates');
			$("#tee_holiday_date").val(holiday_dates);
			// var holiday_roles = []

			// $('#roles :selected').each(function(i, selected){
			// 	holiday_roles[i] = $(selected).prop('value');
			// });

			// var holidays = { name: holiday_name, dates: holiday_dates, roles: holiday_roles, project_id: holiday_project}

			// $.ajax({
			// 	URL: 'http://localhost:3000/tee_holidays',
			// 	type: 'POST',
			// 	dataType: 'json',
			// 	data: holidays,
			// 	success: function(params){console.log("succes:",params);},
			// 	error: function(params){console.log("error",params);}
			// });
		});

	});
});