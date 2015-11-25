$(document).ready(function(){
	$('.workable').on('click', function(){
		if($(this).attr('checked')){
			num = $(this).attr('id')
			$("#tee_timetable_journals_attributes_"+num+"_start_time_4i").attr("disabled",false);
			$("#tee_timetable_journals_attributes_"+num+"_start_time_5i").attr("disabled",false);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_4i").attr("disabled",false);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_5i").attr("disabled",false);
		} else {
			num = $(this).attr('id')
			$("#tee_timetable_journals_attributes_"+num+"_start_time_4i").attr("disabled",true);
			$("#tee_timetable_journals_attributes_"+num+"_start_time_5i").attr("disabled",true);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_4i").attr("disabled",true);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_5i").attr("disabled",true);

			$("#tee_timetable_journals_attributes_"+num+"_start_time_4i option:eq(0)").prop('selected',true);
			$("#tee_timetable_journals_attributes_"+num+"_start_time_5i option:eq(0)").prop('selected',true);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_4i option:eq(0)").prop('selected',true);
			$("#tee_timetable_journals_attributes_"+num+"_end_time_5i option:eq(0)").prop('selected',true);
		}
	});
});