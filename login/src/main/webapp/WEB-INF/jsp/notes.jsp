<%@include file="/WEB-INF/jsp/parts/header.jsp"%>

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
								onclick="showModalView('${viewnote.note}');return false;"><c:out
										value="${viewnote.descr}" /></a></td>
							<td>
								<button type="button" class="btn btn-primary"
									data-toggle="button" aria-pressed="false" autocomplete="off">
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

<div class="modal fade" id="exampleviewmodal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Note full text</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<input type="hidden" id="noteId" name="custId" value="">
			<div class="modal-body viewnote" id="modalviewnotebody">
				Content</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

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

		var viewnote = findOneNote(id);
		alert (viewnote);
		document.getElementById("modalviewnotebody").innerHTML = viewnote;
		$('#exampleviewmodal').modal('show');
	}

	window.onload = function() {
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
		alert (json);
		return json;
	}
	function editNote(id) {

		var note = findOneNote(id);

		document.getElementById('noteId').value = note.id;
		document.getElementById('noteeditdescr').value = note.descr;
		document.getElementById('editvalidationTextarea').value = note.note;

	}

	function saveNewNote() {

		var data = new Object();
		data.descr = document.getElementById('notedescr').value;
		data.note = document.getElementById('validationTextarea').value;
		data.user_id = document.getElementById('noteId').value;

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
			getAllNotes();
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