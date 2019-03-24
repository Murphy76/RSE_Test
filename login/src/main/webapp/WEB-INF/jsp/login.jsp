<%@include file="/WEB-INF/jsp/parts/header.jsp"%>



<div class="d-flex justify-content-center align-items-center container " >

	<form method="POST" action="${contextPath}/login" class="form-signin">
 		<div class="form-group ${error != null ? 'has-error' : ''}">
			<span>${msg}</span> <input name="username" type="text"
				class="form-control align-items-center container mb-3 mt-3" placeholder="Username" autofocus="true" /> <input
				name="password" type="password" class="form-control align-items-center container  mb-3"
				placeholder="Password" /> <span>${errorMsg}</span>

			<button class="btn btn-lg btn-primary align-items-center container" type="submit">Log
				In</button>
		</div>


 </form>

</div>

</html>
