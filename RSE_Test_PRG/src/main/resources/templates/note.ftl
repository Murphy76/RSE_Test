<#import "frames/main.ftl" as main>
<@main.page>


<p>
  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    Create New Note
  </button>
</p>
<div class="collapse" id="collapseExample">
  <div class="card card-body">
    <form action = "note" method = "POST">
 		<div class="form-group">
    		<input id="notedescr" class="form-control" type="text" placeholder="Short Note Description">
  		</div>
  		<div class="mb-3">
    		<label for="validationTextarea">Textarea</label>
    		<textarea class="form-control is-invalid" id="validationTextarea" placeholder="Required example textarea" required></textarea>
    		<div class="invalid-feedback">
      			Please enter a message in the textarea.
    		</div>
  		</div>


</form>
<a href="/note" class="btn btn-primary btn-lg active" role="button" aria-pressed="true" onclick="saveNewNote();">Save</a>
  </div>
</div>

<table class="table table-sm">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Note Name</th>
      <th scope="col">action</th>
    </tr>
  </thead>
  <tbody id="table_body">
  </tbody>
</table>


<div class="modal fade" id="exampleviewmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Note full text</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <input type="hidden" id="noteId" name="custId" value="">
      <div class="modal-body" id="viewbodyid">

      </div>
      <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="saveNote();">Save changes</button>

      </div>
    </div>
  </div>
</div>




<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Edit</button>

<!-- Modal Edit-->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

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
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>



<script type="text/javascript">

       function T(data,id)
    {
    $.ajax({
            url: '/editnote/'+id,
            type: "POST",
            data: data,
            contentType: "application/json",
            success: function (data) {
                alert(data);
            },
            error: function () {
                alert("false");
            },
            complete: function () {
                alert("complete");
            }
        });
      }
</script>

<script type="text/javascript">
function tableCreate(arr){

    var tableRef = document.getElementById('table_body');
	var counter=1;
	while (tableRef.firstChild) {
    	tableRef.removeChild(tableRef.firstChild);
	}

	for ( var key in arr) {
		counter ++;
		var newRow   = tableRef.insertRow(tableRef.rows.length);
		var newCell1  = newRow.insertCell(0);
		newCell1.appendChild(document.createTextNode(counter));
		var newCell2  = newRow.insertCell(1);
		var a = document.createElement('a');
		var linkText = document.createTextNode(arr[key].descr);
		a.appendChild(linkText);
		a.title = "Click to display full text!";
		a.href = "";
		a.setAttribute ('noteid', arr[key].id);

		a.onclick = function(){showModalView(this.getAttribute ('noteid'));return false;};
		newCell2.appendChild(a);
		var newCell3  = newRow.insertCell(2);

		var btnEdit = document.createElement('input');
		btnEdit.type = "button";
		btnEdit.className = "btn btn-primary btn-lg";
		btnEdit.setAttribute ('data-toggle', "modal");
		btnEdit.setAttribute ('data-target', "#exampleModal");
		btnEdit.setAttribute ('noteid', arr[key].id);
		btnEdit.value = 'Edit';
		btnEdit.onclick = function () {editNote (this.getAttribute ('noteid'))};
		newCell3.appendChild(btnEdit);
		var btnDel = document.createElement('input');
		btnDel.type = "button";
		btnDel.className = "btn btn-primary btn-lg ml-1";
		btnDel.value = 'Delete';
		btnDel.setAttribute ('number', arr[key].id);
		btnDel.onclick = function () {delNote (this.getAttribute ('number'));};
		newCell3.appendChild(btnDel);

}




}


		function getAllNotes() {

			var xhr = new XMLHttpRequest();
			var open_str = "/rest/notes";
			xhr.open("GET", open_str, true);
			xhr.onreadystatechange = function() {

				if (xhr.readyState == 4 && xhr.status == 200) {
					var json = JSON.parse(xhr.responseText);

					tableCreate(json);

				}
			}
			xhr.send();

		}

		function editNote(id){


			var note = findOneNote(id);

			alert (note.descr);
				document.getElementById('noteId').value = note.id;
				document.getElementById('noteeditdescr').value = note.descr;
				document.getElementById('editvalidationTextarea').value = note.note;


		}

function findOneNote (id){
	var url  = "/rest/notes/"+id;
	var xhr  = new XMLHttpRequest()
	xhr.open('GET', url, true)
	xhr.onload = function () {
		var note = JSON.parse(xhr.responseText);
		if (xhr.readyState == 4 && xhr.status == "200") {

			return note;
		} else {
			console.error(note);
		}
		alert(note.note);
	xhr.send(null);
	}
}


		function saveNewNote() {


			var data = new Object();
			data.descr = document.getElementById('notedescr').value;
			data.note = document.getElementById('validationTextarea').value;
			data.user_id = document.getElementById('noteId').value;



			var json = JSON.stringify(data);
			var xhr = new XMLHttpRequest();
			xhr.open("POST", "/rest/notes", true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var users = JSON.parse(xhr.responseText);

				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
					getAllNotes() ;
				} else {
					console.error(users);
				}
			}
			xhr.send(json);


		}
		function editNote11 (id){
			var note = findOneNote(id);

			window.location.replace("/editnote/"+id);

		}


		function delNote(id) {
			var json = JSON.stringify(id);
			var xhr = new XMLHttpRequest();
				xhr.open("DELETE", "/rest/notes/"+id, true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
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
		function showModalView (note){
			var note = findOneNote(id);
			document.getElementsById('viewbodyid').innerHTML = note;
			$('#exampleModal').modal('show');
		}

</script>

</@main.page>