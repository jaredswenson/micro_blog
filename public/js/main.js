$(document).ready(function () {
	$('#submit').on('click', function() { // submit button
		$('#myModal').modal();
	});
	$('#delete').on('click', function () {
		$('#hiddenbutton').click()
	});
	$('#cancel').on('click', function() { // cancel button in modal
		$('#myModal').modal('hide');
	});

});