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
	$('#commentbox').on('keyup', totalCharacters);
	function totalCharacters() {
		var minchar = 0;
		var maxchar = 150;
		var commentbox = $('#commentbox');
		var count = parseInt(commentbox.val().length);
		var diff = maxchar - count;
		$('#count').text(diff); 
		if (diff < minchar) {
			$('#submitpost').attr('disabled', true).css('background-color', 'red'); 
		} else {
			$('#submitpost').attr('disabled', true).css('background-color', '#22F90C')
		}
	}
});