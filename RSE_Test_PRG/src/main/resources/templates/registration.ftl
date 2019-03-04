<#import "frames/reg.ftl" as reg>
<@reg.page>



<h1>Create new account</h1>
<form  method=post    oninput='up2.setCustomValidity(up2.value != up.value ? "Passwords do not match." : "")'>
  <div class="form-row">
          <div class="col-md-4 mb-3">
      		<label for="validationCustom01">First name</label>
      		<input type="text" class="form-control" id="validationCustom01" placeholder="User Name" value="" required>
      		<div class="valid-feedback">
        	Looks good!
      		</div>
	</div>

</div>

  <div class="form-row">
  	<div class="col-md-4 mb-3">
  		<label for="password1">Password:</label>
  		<input id="password1" class="form-control" type=password required name=up>
  	</div>
  </div>
   <div class="form-row">
  	<div class="col-md-4 mb-3">

  <label for="password2">Confirm password:</label>
  <input id="password2" class="form-control" type=password name=up2>
  	</div>
  </div>

  <div class="form-group row">
    <div class="col-sm-10">
      <button type="submit" class="btn btn-primary" onclick="saveUser(); return false;">Save User</button>
  <a href="/" class="btn btn-primary active" role="button" aria-pressed="true">Cancel</a>

    </div>
  </div>
</form>
<script>
$('#myForm').validator()
</script>




















<script>
		function saveUser() {

alert('save');
			var data = new Object();
			data.username = document.getElementById('validationCustom01').value;
			data.password = document.getElementById('password1').value;
			data.enabled = true;



			var json = JSON.stringify(data);
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "/rest/users", true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var users = JSON.parse(xhr.responseText);
				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
					alert('add!');
				} else {
					alert('error!');
					console.error(users);
				}
			}
			xhr.send(json);


		}

</script>
</@reg.page>