	<script type="text/javascript">
		function getAllUsers() {
			var xhr = new XMLHttpRequest();
			var open_str = "/rest/employees";
			xhr.open("GET", open_str, true);
			xhr.onreadystatechange = function() {

				if (xhr.readyState == 4 && xhr.status == 200) {
					var json = JSON.parse(xhr.responseText);
					var div = document.getElementById('users');
					var str = '<p>';
					for ( var key in json) {
						str = str + '<p>'
						if (json.hasOwnProperty(key)) {
							str = str + (json[key].id) + " ";
							str = str + (json[key].username) + " ";
							str = str + (json[key].password);
							str = str + "</p>"
						}
					}
					div.innerHTML = str;

				}
			}
			xhr.send();

		}
		function getSingleUser(id) {
			var xhr = new XMLHttpRequest();
			var open_str = "/rest/employees/"+id;
			xhr.open("GET", open_str, true);
			xhr.onreadystatechange = function() {

				if (xhr.readyState == 4 && xhr.status == 200) {
					var json = JSON.parse(xhr.responseText);
					var div = document.getElementById('users');
					var str = '<p>';
					for ( var key in json) {
						str = str + '<p>'
						if (json.hasOwnProperty(key)) {
							str = str + (json[key].id) + " ";
							str = str + (json[key].username) + " ";
							str = str + (json[key].password);
							str = str + "</p>"
						}
					}
					div.innerHTML = str;

				}
			}
			xhr.send();
		}
		function createNewUser() {

			var data = {

				"username" : "NewAdmin",
				"password" : "NewAdminPwd",
				"enabled" : true

			};

			var json = JSON.stringify(data);
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "/rest/employees", true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var users = JSON.parse(xhr.responseText);
				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
				} else {
					console.error(users);
				}
			}
			xhr.send(json);

		}
		function updateUser(id) {
			var json = JSON.stringify(data);
			var xhr = new XMLHttpRequest();
			xhr.open("PUT", "/rest/employees/"+id, true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var users = JSON.parse(xhr.responseText);
				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
				} else {
					console.error(users);
				}
			}
			xhr.send(json);

		}
		function deleteUser(id) {
			var json = JSON.stringify(data);
			var xhr = new XMLHttpRequest();
			xhr.open("DELETE", "/rest/employees/"+id, true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var users = JSON.parse(xhr.responseText);
				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
				} else {
					console.error(users);
				}
			}
			xhr.send(json);

		}
	</script>
