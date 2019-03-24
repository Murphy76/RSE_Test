<%@include file="/WEB-INF/jsp/parts/header.jsp"%>

<div class="d-flex  align-items-center container  ">
	<p>
		<button class="btn btn-primary" type="button" data-toggle="collapse"
			data-target="#collapseExample" aria-expanded="false"
			aria-controls="collapseExample">Create New Note</button>
	</p>

</div>

<!-- Modal add new Note-->
<div class=" container  ">
	<div class="collapse" id="collapseExample">
		<div class="card card-body">
			<form action="notes" method="POST">
				<div class="form-group">
					<input id="notedescr" class="form-control" type="text"
						placeholder="Short Note Description">
				</div>
				<div class="mb-3">
					<label for="validationTextarea">Textarea</label>
					<textarea class="form-control is-invalid" id="validationTextarea"
						placeholder="Required example textarea" required></textarea>
					<div class="invalid-feedback">Please enter a message in the
						textarea.</div>
				</div>


			</form>
			<a href="/notes" class="btn btn-primary btn-lg active" role="button"
				aria-pressed="true" onclick="saveNewNote();">Save</a>
		</div>
	</div>


</div>
<div
	class="d-flex justify-content-center align-items-center container  ">

	<div class="grid">
		<div class="row">
			<h2>List of the notes</h2>
		</div>
		<div class="row">
			<table class="table table-sm">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Note Name</th>
						<th scope="col">action</th>
					</tr>
				</thead>
				<tbody id="table_body">
					<c:forEach items="${notes}" var="viewnote" varStatus="loop">
						<tr>
							<td><c:out value="${loop.index +1}" /></td>
							<td><a href=""
								onclick="showNoteInfo('${viewnote.id}');return false;"><c:out
										value="${viewnote.descr}" /></a></td>
							<td>
								<button type="button" class="btn btn-primary"
									data-toggle="button" aria-pressed="false" autocomplete="off"
									onclick="showModalView('${viewnote.note}');return false;">
									Edit note</button>

								<button type="button" class="btn btn-primary"
									data-toggle="button" aria-pressed="false" autocomplete="off">
									Delete note</button>
							</td>

						</tr>
					</c:forEach>


				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- Modal View-->
<div class="modal fade" id="exampleviewmodal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalLabel">Note full text</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body viewnote" id="modalviewnotebody">
				Content</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

			</div>
		</div>
	</div>
</div>


<!-- Modal Edit-->
<div class="modal fade" id="editNoteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Edit note</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <input type="hidden" id="noteeditid"  value="">
      <div class="modal-body editnote">

		<div class="form-group">
    		<input id="noteeditdescr" class="form-control" type="text" placeholder="Short Note Description">
  		</div>
  		<div class="mb-3">
    		<label for="validationTextarea">Textarea</label>
    		<textarea class="form-control is-valid" id="editvalidationTextarea" placeholder="Required example textarea" required></textarea>
    		<div class="invalid-feedback">
      			Please enter a message in the textarea.
    		</div>
  		</div>


      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="saveNote();">Save changes</button>
      </div>
    </div>
  </div>
</div>



<script type="text/javascript">
	function T(data, id) {
		$.ajax({
			url : '/editnote/' + id,
			type : "POST",
			data : data,
			contentType : "application/json",
			success : function(data) {
				alert(data);
			},
			error : function() {
				alert("false");
			},
			complete : function() {
				alert("complete");
			}
		});
	}
</script>

<script type="text/javascript">
	function showModalView(id) {
		var url = "/rest/notes/" + id;
		var xhr = new XMLHttpRequest();

		xhr.open("GET", url, true);
		xhr.onload = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var json = JSON.parse(xhr.responseText);
				document.getElementById("modalLabel").innerHTML = json.descr;
				document.getElementById("modalviewnotebody").innerHTML = json.note;
				$('#exampleviewmodal').modal('show');

			}
		}
		xhr.send(null);

	}
	function editModalView(id) {
		var url = "/rest/notes/" + id;
		var xhr = new XMLHttpRequest();
		xhr.open("GET", url, true);
		xhr.onload = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var json = JSON.parse(xhr.responseText);
				document.getElementById("modalLabel").innerHTML = json.descr;
				document.getElementById("modalviewnotebody").innerHTML = json.note;
				$('#exampleviewmodal').modal('show');

			}
		}
		xhr.send(null);

	}
	window.onload = function() {
		showAllNotes ();

	}

	function showAllNotes (){
		var xhr = new XMLHttpRequest();
		var url = "/rest/notes";
		xhr.open("GET", url, true);
		xhr.onload = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var json = JSON.parse(xhr.responseText);
				tableCreate(json);

			}
		}
		xhr.send(null);

	}

	function tableCreate(arr) {

		var tableRef = document.getElementById('table_body');
		var counter = 0;
		while (tableRef.firstChild) {
			tableRef.removeChild(tableRef.firstChild);
		}
		for ( var key in arr) {
			counter++;
			var newRow = tableRef.insertRow(tableRef.rows.length);
			var newCell1 = newRow.insertCell(0);
			newCell1.appendChild(document.createTextNode(counter));
			var newCell2 = newRow.insertCell(1);
			var a = document.createElement('a');
			var linkText = document.createTextNode(arr[key].descr);
			a.appendChild(linkText);
			a.title = "Click to display full text!";
			a.href = "";
			a.setAttribute('noteid', arr[key].id);

			a.onclick = function() {
				showModalView(this.getAttribute('noteid'));
				return false;
			};
			newCell2.appendChild(a);
			var newCell3 = newRow.insertCell(2);

			var btnEdit = document.createElement('input');
			btnEdit.type = "button";
			btnEdit.className = "btn btn-primary btn-sm";
			btnEdit.setAttribute('data-toggle', "modal");
			btnEdit.setAttribute('data-target', "#exampleModal");
			btnEdit.setAttribute('noteid', arr[key].id);
			btnEdit.value = 'Edit';
			btnEdit.onclick = function() {
				editNote(this.getAttribute('noteid'))
			};
			newCell3.appendChild(btnEdit);
			var btnDel = document.createElement('input');
			btnDel.type = "button";
			btnDel.className = "btn btn-primary btn-sm ml-1";
			btnDel.value = 'Delete';
			btnDel.setAttribute('number', arr[key].id);
			btnDel.onclick = function() {
				delNote(this.getAttribute('number'));
			};
			newCell3.appendChild(btnDel);
		}
	}

	function findOneNote(id) {
		var url = "/rest/notes/1";
		var xhr = new XMLHttpRequest();
		var json;
		xhr.open("GET", url, true);
		xhr.onload = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var json = JSON.parse(xhr.responseText);
				return json;

			}
		}
		xhr.send(null);

	}
	function editNote(id) {
		var url = "/rest/notes/" + id;
		var xhr = new XMLHttpRequest();
		xhr.open("GET", url, true);
		xhr.onload = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var json = JSON.parse(xhr.responseText);
				document.getElementById("noteeditid").value = json.id;
				document.getElementById("noteeditdescr").value = json.descr;
				document.getElementById("editvalidationTextarea").value = json.note;
				$('#editNoteModal').modal('show');

			}
		}
		xhr.send(null);

	}

	function saveNewNote() {

		var data = new Object();

		data.descr = document.getElementById('notedescr').value;
		data.note = document.getElementById('validationTextarea').value;
		//data.user_id = document.getElementById('username').textContent;

		var json = JSON.stringify(data);
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "/rest/notes", true);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function() {
			var users = JSON.parse(xhr.responseText);

			if (xhr.readyState == 4 && xhr.status == "201") {
				console.table(users);
				getAllNotes();
			} else {
				console.error(users);
			}
		}
		xhr.send(json);

	}

	function saveNote (){
		alert(document.getElementById("noteeditid").value);
		var data = new Object();
		data.descr = document.getElementById("noteeditdescr").value;
		data.note = document.getElementById("editvalidationTextarea").value;
		data.user_id = document.getElementById("noteeditid").value;
		$('#editNoteModal').modal('hide');
		var json = JSON.stringify(data);
		var xhr = new XMLHttpRequest();
		xhr.open("PUT", "/rest/notes/"+data.user_id, true);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function() {
			var users = JSON.parse(xhr.responseText);

			if (xhr.readyState == 4 && xhr.status == "201") {
				console.table(users);
				getAllNotes();
			} else {
				console.error(users);
			}
		}
		xhr.send(json);

	}

	function editNote11(id) {
		var note = findOneNote(id);

		window.location.replace("/editnote/" + id);

	}

	function delNote(id) {
		var json = JSON.stringify(id);
		var xhr = new XMLHttpRequest();
		xhr.open("DELETE", "/rest/notes/" + id, true);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function() {
			showAllNotes ();
			var note = JSON.parse(xhr.responseText);

			if (xhr.readyState == 4 && xhr.status == "201") {
				console.table(users);

			} else {
				console.error(users);

			}

		}
		xhr.send(json);

	}
</script>




</body onload="getAllNotes();">
</html>