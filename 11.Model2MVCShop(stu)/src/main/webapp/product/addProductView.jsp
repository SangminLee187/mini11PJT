<%@ page contentType="text/html; charset=euc-kr" %>

<!DOCTYPE html>


<html lang="ko">
</head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	
		<!--  ///////////////////////// CSS ////////////////////////// -->
	
	<style>
       body > div.container{
            margin-top: 50px;
        }
    </style>
	<script type="text/javascript">

function fncAddProduct() {
	var prodName = $("input[name='prodName']").val();
	var prodDetail = $("input[name='prodDetail']").val();
	var menuDate = $("input[name='menuDate']").val();
	var price = $("input[name='price']").val();
	var fileName = $("input[name='fileName']").val();
		
	$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();

}

$(function() {
	$( "button.btn.btn-primary" ).on("click" , function() {
		fncAddProduct();
	});
});

$(function() {
	$("a[href='#' ]").on("click" , function() {
		$("form")[0].reset();
	});
});	
</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />

   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		
		<div class="page-header text-info">
	       <h3>�ǸŻ�ǰ���</h3>
	    </div>
			
		<form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��">

		    </div>
		    <div class="col-sm-3">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ������" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="��������" readonly="readonly">
		      	&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
				onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="����">
		    </div>
		  </div>
		 		  
		   <div class="form-group">
		    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="file" name="file" placeholder="��ǰ�̹���">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >��&nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
			
	</div>

</body>
</html>
