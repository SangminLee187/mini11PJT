<%@ page contentType="text/html; charset=euc-kr" %>

<!DOCTYPE html>


<html lang="ko">
</head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
		<!--  ///////////////////////// CSS ////////////////////////// -->
	
	<style>
       body > div.container{
            margin-top: 50px;
        }
    </style>
<script type="text/javascript">
	
	$(function() {
		$( "button.btn.btn-primary" ).on("click" , function() {
			self.location = "/product/addProductView.jsp"
		});
	});
	
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			self.location = "/product/listProduct?menu=manage"
		});
	});	
</script>
	
<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />

   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		
		<div class="page-header text-info">
	       <h3>상품등록확인</h3>
	    </div>
			
		<form class="form-horizontal" name="detailForm" method="post">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명" value="${product.prodName}">

		    </div>
		    <div class="col-sm-3">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세정보" value="${product.prodName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자" value="${product.manuDate}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="가격" value="${product.price}">
		    </div>
		  </div>
		 		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <img alt="" src="/images/uploadFiles/${product.fileName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >추가등록</button>
			  <a class="btn btn-primary btn" href="#" role="button">확인</a>
		    </div>
		  </div>
		</form>
			
	</div>

</body>
</html>
