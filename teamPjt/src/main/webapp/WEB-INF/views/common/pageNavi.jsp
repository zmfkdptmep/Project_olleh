<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function go(page) {
		document.searchForm.pageNo.value=page;
		searchForm.submit();
	}
</script>
</head>
<body>
	<!-- 페이지 블럭 생성 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-end">
 	  	<c:if test="${pageDto.prev}">
		    <li class="page-item">
		      <a class="page-link" onclick="go(1)" href="#">&lt;&lt;</a>  <!-- / &lt; = < -->
		    </li>
	  		
	  	</c:if> 
	    <li class="page-item ${pageDto.prev?'':'disabled' }">
	      <a class="page-link" onclick="go(${ pageDto.startNo-1 })" href="#">Previous</a>
	    </li>

	    <c:forEach begin="${ pageDto.startNo }" end="${ pageDto.endNo }" var="i">
		    <li class="page-item"><a class="page-link ${ pageDto.cri.pageNo eq i?'active':'' }" onclick="go(${i})" href="#">${ i }</a></li>
	    </c:forEach>

	    <li class="page-item ${pageDto.next?'':'disabled' }">
	      <a class="page-link" onclick="go(${ pageDto.endNo+1 })" href="#">Next</a>
	    </li>
	
		<c:if test="${ pageDto.next }">
		    <li class="page-item">
		      <a class="page-link" onclick="go(${pageDto.realEnd})" href="#">&gt;&gt;</a>  <!-- / &gt; = > -->
		    </li>
		</c:if>
		
	  </ul>
	</nav>
</body>
</html>