// errCode constants

var SUCCESS = 1;
var ERR_BAD_CREDENTIALS = -1;
var ERR_USER_EXISTS = -2;
var ERR_BAD_USERNAME = -3;
var ERR_BAD_PASSWORD = -4;

// Document Ready function, hide welcome message

$('document').ready(function () {
	$('.welcome-message').hide()
});


// When the login button is clicked
function login_user () {
	var data = {'user': $('#username').val(), 'password': $('#user-password').val()};
	$.ajax({
		type: "POST",
		url: "/users/login",
		data: data,
		dataType: 'json',
		success: function(response) {
			if (response.errCode == SUCCESS) {
				$('.login').hide();
				$('#num_logins').html(response.count);
				$('#user').html(data.user);
				$('.welcome-message').show();
			} else { // errCode == ERR_BAD_CREDENTIALS
				$('#message-box').html("Invalid username/password combination. Please try again.");
			}
		}
	});
};


// When the add button is clicked
function add_user () {
	var data = { 'user': $('#username').val(), 'password': $('#user-password').val()};
	$.ajax({
		type: "POST",
		url: "/users/add",
		data: data,
		dataType: 'json',
		success: function(response) {
			if (response.errCode == SUCCESS) {
				$('.login').hide();
                $('#num_logins').html(response.count);
                $('#user').html(data.user);
                $('.welcome-message').show();	
			} else if (response.errCode == ERR_BAD_USERNAME) {
				$('#message-box').html("Invalid username. Please try again.");
			} else if (response.errCode == ERR_BAD_PASSWORD) {
				$('#message-box').html("Invalid password. Please try again.");
			} else if (response.errCode == ERR_USER_EXISTS) {
				$('#message-box').html("Error: User already exists. Please choose a different username and try again.");
			}
		}
	});
};

function logout() {
	$('#username').val('');
	$('#user-password').val('');
	$('.welcome-message').hide();
	$('.login').show();
};	
