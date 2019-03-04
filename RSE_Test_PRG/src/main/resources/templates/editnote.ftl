<#import "frames/editnote.ftl" as editnote>
<@editnote.page>

<input type="hidden" id="noteid" name="custId" value="${notenumber}" onload="alert(' wefwefewr ')">

      <input type="hidden" class="form-control" id="noteid" placeholder="Short description">

 <form>
  <div class="form-group row">
    <label for="inputName" class="col-sm-2 col-form-label">Description</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputdescr" placeholder="Short description">
    </div>
  </div>


 <div class="mb-3">
    <label for="validationTextarea">Textarea</label>
    <textarea class="form-control is-invalid" id="validationTextarea" placeholder="Note fuill text" required></textarea>
    <div class="invalid-feedback">
      Please enter a message in the textarea.
    </div>
  </div>

  <div class="form-group row">
    <div class="col-sm-10">
      <button type="submit" class="btn btn-primary" onclick="saveNote(); return false;">Save Note</button>
  <a href="/note" class="btn btn-primary active" role="button" aria-pressed="true">Cancel</a>

    </div>
  </div>
</form>

<script type="text/javascript">

function fillNoteForm (){
alert('qwerwer');
 var noteid = document.getElementById('noteid').value;
 getAllNotes(noteid);

}
		function getAllNotes(noteid) {

			var xhr = new XMLHttpRequest();
			var open_str = "/rest/notes/"+noteid;
			xhr.open("PUT", open_str, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var json = JSON.parse(xhr.responseText);
					document.getElementById('inputdescr').value = json[0].descr;
					document.getElementById('validationTextarea').value = json[0].note;
				}
			}
			xhr.send();

		}





function tableCreate(arr){
    var tableRef = document.getElementById('table_body');
					var counter=1;


					for ( var key in arr) {

						counter ++;
						var newRow   = tableRef.insertRow(tableRef.rows.length);
						var newCell1  = newRow.insertCell(0);

						newCell1.appendChild(document.createTextNode(arr[key].id));
						var newCell2  = newRow.insertCell(1);

						var a = document.createElement('a');
						var linkText = document.createTextNode(arr[key].descr);
						a.appendChild(linkText);
						a.title = "Click to display full text!";
						a.href = "";
						a.onclick = function(){showModalView(arr[key].note);return false;};
						newCell2.appendChild(a);



						var newCell3  = newRow.insertCell(2);
						var btnEdit = document.createElement('input');
						btnEdit.type = "button";
						btnEdit.className = "btn btn-primary btn-lg";
						btnEdit.value = 'Edit';

						btnEdit.setAttribute ('number', arr[key].id);
						btnEdit.onclick = function () {editNote (this.getAttribute ('number'))};

						newCell3.appendChild(btnEdit);
						var btnDel = document.createElement('input');
						btnDel.type = "button";
						btnDel.className = "btn btn-primary btn-lg ml-1";
						btnDel.value = 'Delete';
						btnDel.setAttribute ('number', arr[key].id);
						btnDel.onclick = function () {delNote (this.getAttribute ('number'))};
						newCell3.appendChild(btnDel);


					}




}




		function saveNewNote() {


			var data = new Object();
			data.descr = document.getElementById('notedescr').value;
			data.note = document.getElementById('validationTextarea').value;
			data.user_id = 1;



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
		function editNote (id){
			window.location.replace("/editnote/"+id);

		}


		function delNote(id) {
			var json = JSON.stringify(id);
			var xhr = new XMLHttpRequest();
				xhr.open("DELETE", "/rest/notes/"+id, true);
			xhr.setRequestHeader('Content-type',
					'application/json; charset=utf-8');
			xhr.onload = function() {
				var note = JSON.parse(xhr.responseText);

				if (xhr.readyState == 4 && xhr.status == "201") {
					console.table(users);
					getAllNotes();
				} else {
					console.error(users);
				}

			}
			xhr.send(json);

		}
		function showModalView (note){

		document. getElementsByClassName("modal-body")[0].innerHTML = note;
		$('#exampleModal').modal('show');
		}

</script>
</@editnote.page>