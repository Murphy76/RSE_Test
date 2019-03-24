<%@include file="/WEB-INF/jsp/parts/header.jsp" %>

<div class="d-flex justify-content-center align-items-center container " >

	<form:form method="POST" action="/registerprocess" class="form-signin  mt-5" modelAttribute="emp">
 		<div class="form-group ${error != null ? 'has-error' : ''}">
			<span>${msg}</span>
			<div class="form-row">
			 <div class="col">
					<form:label path="empName">Username</form:label>
					</div>
					 <div class="col">
					<form:input path="empName" name="username" type="text"	class="form-control align-items-center container mb-3" placeholder="Username" autofocus="true" />
					</div>
			</div>
			<div class="form-row">
			 <div class="col">
					<form:label path="password">Password</form:label>
					</div>
					 <div class="col">
					<form:password	path="password" name="password"  class="form-control align-items-center container  mb-3"	placeholder="Password" />
</div>
			</div>
			<div class="form-row">
			 <div class="col">
				<form:label path="passwordconfirm">Password confirmation</form:label>
				</div>
				 <div class="col">
				<form:password	path="passwordconfirm" name="password"  class="form-control align-items-center container  mb-3"	placeholder="Password confirmation" />
				</div>
				</div>
				<span>${errorMsg}</span>
			<div class="form-row">
			 <div class="col">

			<form:button class="btn btn-lg btn-primary align-items-center container" type="submit">Register</form:button>
			</div>
			</div>
		</div>


 </form:form>

</div>


</body>
</html>