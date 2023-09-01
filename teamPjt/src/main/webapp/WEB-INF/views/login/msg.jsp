<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript">
	window.onload = function(){
		
		const myModal = new bootstrap.Modal('#myModal', {
		  keyboard: false
		});
		document.querySelector(".modal-body").innerHTML= '메세지';
		
		myModal.show();
		
		// myModal 요소 선택
		const myModalEl = document.getElementById('myModal');
		// 이벤트 등록
		myModalEl.addEventListener('hidden.bs.modal', event => {
		  history.go(-1);
		})
	}
	</script>
</head>
<body>

<!-- Modal -->
<div id="myModal" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">알림</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


</body>
</html>