<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>

	<!-- Fonts and icons -->
	<script src="assets/js/plugin/webfont/webfont.min.js"></script>
	<script src="https://kit.fontawesome.com/7f7b0ec58f.js"
			crossorigin="anonymous"></script>

	<!-- CSS Files -->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
	<link rel="stylesheet" href="assets/css/plugins.min.css" />
	<link rel="stylesheet" href="assets/css/kaiadmin.css" />
	<!-- sweetAlert JS FILE -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	<script src="../../js/sweetAlert_modal.js"></script>
</head>
<body>


<!-- GNB 커스텀태그 -->
<mytag:gnb member_id="${MEMBER_ID}"></mytag:gnb>

<!-- container start -->

<div class="container pt-3">

		<div class="page-inner">
			<!-- 비밀번호 확인 창 -->
			<div class="card card-stats card-round p-3" id="passwordCheckPage">
				<div class="card-header">
					<h3 class="text-center">비밀번호 확인</h3>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">비밀번호</p>
						</div>
						<div class="col-md-10">
							<div class="form-group">
								<input type="password" class="form-control"
									   id="member_password" placeholder="비밀번호를 입력해주세요" />
							</div>
						</div>
					</div>
					<div class="card-action text-center">
						<button type="button" class="btn btn-primary px-5"
								id="check-pw-btn">확인</button>
					</div>
				</div>
			</div>
			<!-- 회원정보 수정 (초기에는 숨김) -->
			<form action="changeMember.do" method="POST"
				  enctype="multipart/form-data" id="changeMemberForm">
			<div class="card card-stats card-round p-3 d-none" id="editmyPage">
				<div class="card-header">
					<h3 class="text-center">회원 정보 수정</h3>
				</div>

				<div class="card-body">
					<!-- 프로필 사진 -->
					<div class="row my-3">
						<div class="col-12 d-flex justify-content-center">
							<div class="avatar avatar-xxl">
								<img src="https://comapro.cdn1.cafe24.com${data.member_profile}" alt="profile"
									 class="avatar-img rounded-circle" id="previewImage">
							</div>
						</div>
						<div class="row pt-3">
							<div class="col-12 d-flex justify-content-center">
								<button type="button" class="btn btn-secondary"
										id="changePhotoBtn">사진 변경</button>
							</div>
						</div>
					</div>

					<!-- 회원 정보 수정 폼 -->
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">이름</p>
						</div>
						<div class="col-md-10">
							<div class="form-group">
								<input type="text" class="form-control" id="member_name"
									   name="member_name" value="${data.member_name}" readonly />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">전화번호</p>
						</div>
						<div class="col-md-10">
							<div class="form-group">
								<input type="text" class="form-control" id="phone"
									   name="member_phone" value="${data.member_phone}"
									   placeholder="전화번호를 입력해주세요" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">지역</p>
						</div>
						<div class="col-md-10">
							<div class="form-group">
								<select id="member_location" name="member_location">
									<option>서울특별시</option>
									<option>세종특별자치도</option>
									<option>부산광역시</option>
									<option>대구광역시</option>
									<option>대전광역시</option>
									<option>인천광역시</option>
									<option>광주광역시</option>
									<option>울산광역시</option>
									<option>경기도</option>
									<option>충청남도</option>
									<option>충청북도</option>
									<option>전라남도</option>
									<option>전라북도</option>
									<option>경상남도</option>
									<option>경상북도</option>
									<option>강원도</option>

								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">변경할 비밀번호</p>
						</div>
						<div class="col-md-10">
							<div class="form-group">
								<input type="password" class="form-control"
									   id="update_password" name="member_password"
									   placeholder="변경할 비밀번호를 입력해주세요" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 d-flex align-items-center">
							<p class="mb-0">비밀번호 확인</p>
						</div>
						<div class="col-md-10">
							<div id="password-check-container" class="form-group">
								<input type="password" class="form-control" id="password_check"
									   name="password_check" placeholder="변경할 비밀번호를 확인해주세요" /> <small
									id="errorPassword" class="form-text text-muted"
									style="display: none;"></small>
							</div>
						</div>
					</div>
				</div>
				<div class="card-action text-center">
					<button type="button"
							class="btn btn-black px-5 mb-3 mb-sm-0 me-0 me-sm-4"
							onclick="window.location.href='myPage.do';">취소</button>
					<button id="update" class="btn btn-primary px-5">수정</button>
				</div>
			</div>

		</div>

		<!-- 프로필 사진 변경 modal -->
		<div class="modal fade" id="photoModal" tabindex="-1" role="dialog"
			 aria-labelledby="photoModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="photoModalLabel">사진 변경</h5>
						<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="photoUpload">새 프로필 사진 업로드</label> <input type="file"
																				 class="form-control-file" id="photoUpload" name="photoUpload">
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-primary" id="upload">업로드</button>
							<small class="error" id="fileError"></small> <!-- 파일 업로드 오류 추가 -->
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
								data-dismiss="modal" id="photoClose">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- Core JS Files -->
<script src="assets/js/core/jquery-3.7.1.min.js"></script>
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>

<%--<script>
	// 모달창 버튼 클릭 함수
	$(document).ready(function () {
		// 사진 변경 버튼 클릭시 모달창 표시
		$('#changePhotoBtn').click(function () {
			$('#photoModal').modal('show');
		});

		// 모달 닫기 버튼 클릭시 파일 입력 초기화
		$('#photoModal .close').click(function () {
			var fileInput = document.getElementById('photoUpload'); // 파일 선택 버튼
			fileInput.value = ''; // 파일 비워줘
			$('#photoModal').modal('hide');
		});
		$('#photoClose').click(function () {
			var fileInput = document.getElementById('photoUpload'); // 파일 선택 버튼
			fileInput.value = ''; // 파일 비워줘
			$('#photoModal').modal('hide');
		});
	});

	// 비밀번호 유효성 검사 = 회원의 비밀번호와 맞는지 확인해서 회원정보 수정 창 나오게 한다

	$(document).ready(function () {
		var passwordCheckPageField = $('#passwordCheckPage'); // 비밀번호 확인 box
		var editmyPageField = $('#editmyPage'); // 회원정보 수정 box
		var passwordCheckAsync = $('#member_password'); // 비밀번호 확인 input
		var passwordCheck = passwordCheckAsync.value; // 비밀번호 확인 input 입력값
		$('#changeMemberForm').on('submit', event=>{
			event.preventDefault();
		})
		$("#check-pw-btn").on("click", event => { // 확인 버튼 누르는 함수
			asyncPassword()
		});
		$(passwordCheckAsync).on("keypress", event => {
			if(event.key == 'Enter'){
				asyncPassword();
			}
		});

		function asyncPassword() {

			$.ajax({
				type: "POST",
				url: "checkPassword.do", // 서버에서 비밀번호 맞는지 검사를 처리하는 URL
				headers: {'Content-Type': 'application/json'},
				data: JSON.stringify({member_password: passwordCheck}),
				dataType: "json",
				success: function (data) {
					if (data != null) { // C한테 받아온 값이 있으면 == 비밀번호가 일치하다면
						passwordCheckPageField.addClass("d-none"); // 비밀번호 확인 box 숨기고
						editmyPageField.removeClass("d-none"); // 회원정보 수정 box 나타내줘
					} else { // 받아온 값이 없다면 == 비밀번호가 맞지않다면
						alert("비밀번호가 맞지 않습니다!");
						return false;
					}
				},
				error: function (error) {
					console.log("응답 실패...");
					console.log(error);
				}
			});
		}
	});
</script>

<script>
	// 이미지 업로드 유효성 검사 = 업로드한 이미지가 50kb넘지 않고 jpg나 png만 받을수 있다

	$(document).ready(function() {
		$("#upload").click(function(event) { // 모달창에 있는 업로드 버튼을 눌렀을 때의 함수
			var fileInput = document.getElementById('photoUpload'); // 파일 선택 버튼
			var file = fileInput.files[0];
			var fileError = document.getElementById('fileError'); // small 태그
			fileError.textContent = '';
			const imgPreview = document.getElementById('previewImage');


			if (file) {

				var fileTypes = ['image/jpeg', 'image/png']; // 이미지파일을 jpg나 png로 받는 변수

				if (!fileTypes.includes(file.type)) { // 타입이 jpg나 png가 아니라면
					$(fileError).text("jpg파일 또는 png파일만 업로드 가능합니다!!");
					fileInput.value = ''; // 파일 비워줘
					return;
				}

				if (file.size > 50 * 1024) { // 파일의 크기가 50kb가 넘는다면
					$(fileError).text("파일 크기는 50KB를 넘을 수 없습니다.");
					fileInput.value = ''; // 파일 비워줘

				}
				else {
					const reader = new FileReader();
					reader.onload = function() {
						imgPreview.src = reader.result;
						imgPreview.style.display = 'block';
					};
					if (file) {
						reader.readAsDataURL(file);
					}
					$('#photoModal').modal('hide'); // 제대로들어가면 모달창 닫아
				}
			}
		});
	});
</script>

<script>
	// 수정할 비밀번호 유효성 검사 = 비밀번호, 비밀번호 확인 창 둘이 일치하는지 확인한다

	$(document).ready(function() {

		let passwordCheckPassed = false; // 전역변수 - 비밀번호가 같다 true false
		var passwordField = $('#update_password'); // 비밀번호 input
		var passwordCheckField = $('#password_check'); // 비밀번호 확인 input
		var errorPassword = $('#errorPassword'); // 비밀번호 input밑에 숨겨져있는 small 태그

		function checkPasswords() { // 비밀번호 일치하는 지 확인하는
			var password = passwordField.value; // 비밀번호 input 입력값
			var passwordCheck = passwordCheckField.value; // 비밀번호 확인 input 입력값

			if (passwordCheck !== "") { // 비밀번호 확인 input값이 입력되면
				if (password == passwordCheck) { // 비밀번호 입력값과 비밀번호확인 입력값이 같다면
					passwordCheckField.removeClass('input-error');
					passwordCheckField.addClass('input-success');
					errorPassword.css('display', 'block'); // 그리고 small태그 나타나게해줘
					errorPassword.text('비밀번호가 일치합니다.^^');
					passwordCheckPassed = true; // true값으로 설정
				}
				else {
					passwordCheckField.removeClass('input-success');
					passwordCheckField.addClass('input-error');
					errorPassword.css('display', 'block'); // 그리고 small태그 나타나게해줘
					errorPassword.text('비밀번호가 일치하지 않습니다. 다시 확인해 주세요.');
					passwordCheckPassed = false; // false값으로 설정
				}
			}
			else { // 비밀번호 확인 input 값이 없다면
				passwordCheckField.removeClass('input-error');
				errorPassword.css('display', 'none');
			}
		}

		// 비밀번호 입력 필드와 비밀번호 확인 필드의 입력 이벤트
		passwordField.on('input', checkPasswords);
		passwordCheckField.on('input', checkPasswords);

		// 다른 입력 필드나 선택 박스에서 포커스가 이동할 때 비밀번호를 확인
		var otherInputs = document.querySelectorAll('input, select');
		otherInputs.forEach(function(input) {
			input.addEventListener('blur', function(event) {
				// 비밀번호 필드가 아닌 경우에는 checkPasswords를 호출하지 않음
				if (event.target.id !== 'password_check'
						&& event.target.id !== 'update_password') {
					checkPasswords();
				}
			});
		});
		$("#update").on('click',event => { // 수정 버튼 클릭했을 때의 함수
			if (!passwordCheckPassed) { // 비밀번호 같지않다면
				//event.preventDefault(); // 폼 제출을 막는 메서드 실행 후
				alert("비밀번호를 다시 확인해주세요."); // alert창 나타낸다.
				return false; // false 반환
			}
			$('#changeMemberForm').submit();

		});
	});
</script>--%>
<script>
	// 문서 로드 시 초기 설정
	$(document).ready(function () {
		// 사진 변경 버튼 클릭시 모달창 표시
		$('#changePhotoBtn').click(function () {
			$('#photoModal').modal('show');
		});

		// 모달 닫기 버튼 클릭 시 파일 입력 초기화
		$('#photoModal .close, #photoClose').click(function () {
			$('#photoUpload').val(''); // 파일 비워줌
			$('#photoModal').modal('hide');
		});
	});

	// 비밀번호 유효성 검사
	$(document).ready(function () {
		let passwordCheckPassed = false; // 전역변수 - 비밀번호가 일치하는지 확인

		const passwordCheckPageField = $('#passwordCheckPage'); // 비밀번호 확인 박스
		const editmyPageField = $('#editmyPage'); // 회원정보 수정 박스
		const passwordCheckAsync = $('#member_password'); // 비밀번호 확인 인풋 필드
		const passwordField = $('#update_password'); // 비밀번호 인풋 필드
		const passwordCheckField = $('#password_check'); // 비밀번호 확인 인풋 필드
		const errorPassword = $('#errorPassword'); // 에러 메시지 표시하는 small 태그

		function checkPasswords() { // 비밀번호 일치 검사 함수
			const password = passwordField.val(); // 비밀번호 입력값
			const passwordCheck = passwordCheckField.val(); // 비밀번호 확인 입력값

			if (passwordCheck !== "") { // 비밀번호 확인 인풋 값이 있는 경우
				if (password === passwordCheck) { // 비밀번호가 일치하는 경우
					passwordCheckField.removeClass('input-error').addClass('input-success');
					errorPassword.css('display', 'block').text('비밀번호가 일치합니다.^^');
					passwordCheckPassed = true; // true값으로 설정
				} else { // 비밀번호가 일치하지 않는 경우
					passwordCheckField.removeClass('input-success').addClass('input-error');
					errorPassword.css('display', 'block').text('비밀번호가 일치하지 않습니다. 다시 확인해 주세요.');
					passwordCheckPassed = false; // false값으로 설정
				}
			} else { // 비밀번호 확인 인풋 값이 없는 경우
				passwordCheckField.removeClass('input-error');
				errorPassword.css('display', 'none');
			}
		}

		// 비밀번호 입력 필드와 비밀번호 확인 필드의 입력 이벤트
		passwordField.on('input', checkPasswords);
		passwordCheckField.on('input', checkPasswords);

		// 폼 제출 이벤트 리스너
		$('#changeMemberForm').on('submit', function (event) {
			event.preventDefault();
			if (!passwordCheckPassed) { // 비밀번호가 일치하지 않는 경우
				return false; // false 반환하여 폼 제출 중지
			}
			this.submit();
		});

		// 비밀번호 일치 여부 확인을 위한 비동기 함수
		function asyncPassword() {
			const passwordCheck = passwordCheckAsync.val(); // 비밀번호 확인 인풋 값

			$.ajax({
				type: "POST",
				url: "checkPassword.do", // 서버에서 비밀번호 검사를 처리하는 URL
				headers: { 'Content-Type': 'application/json' },
				data: JSON.stringify({ member_password: passwordCheck }),
				dataType: "json",
				success: function (data) {
					if (data != null) { // 비밀번호가 일치하는 경우
						passwordCheckPageField.addClass("d-none"); // 비밀번호 확인 박스 숨김
						editmyPageField.removeClass("d-none"); // 회원정보 수정 박스 나타남
					} else { // 비밀번호가 일치하지 않는 경우
						sweetAlert_error('비밀번호를 확인해주세요!','비밀번호가 틀렸습니다.');
						return false; // false 반환하여 폼 제출 중지
					}
				},
				error: function (error) {
					console.log("응답 실패...");
					console.log(error);
				}
			});
		}

		// 확인 버튼 클릭 이벤트 리스너
		$("#check-pw-btn").on("click", asyncPassword);

		// 비밀번호 확인 인풋 필드 Enter 키 입력 이벤트 리스너
		passwordCheckAsync.on("keypress", function (event) {
			if (event.key === 'Enter') {
				asyncPassword();
			}
		});
	});

	// 이미지 업로드 유효성 검사
	$(document).ready(function () {
		$("#upload").click(function (event) { // 모달창에 있는 업로드 버튼을 눌렀을 때의 함수
			let fileInput = $('#photoUpload')[0]; // 파일 선택 인풋 필드
			let file = fileInput.files[0];
			let fileError = $('#fileError'); // 에러 메시지 표시하는 small 태그

			fileError.text(''); // 기존 에러 메시지 초기화
			const imgPreview = $('#previewImage'); // 이미지 미리보기 태그

			if (file) {
				const fileTypes = ['image/jpeg', 'image/png']; // 허용되는 파일 타입

				if (!fileTypes.includes(file.type)) { // 파일 타입이 jpg나 png가 아닌 경우
					fileError.text("jpg파일 또는 png파일만 업로드 가능합니다!!");
					fileInput.value = ''; // 파일 입력값 초기화
					return;
				}

				if (file.size > 50 * 1024) { // 파일 크기가 50KB를 초과하는 경우
					fileError.text("파일 크기는 50KB를 넘을 수 없습니다.");
					fileInput.value = ''; // 파일 입력값 초기화
				} else { // 파일 크기가 50KB 이하인 경우
					const reader = new FileReader();
					reader.onload = function () {
						imgPreview.attr('src', reader.result).show();
					};
					reader.readAsDataURL(file);
					$('#photoModal').modal('hide'); // 파일 유효성 검사 후 모달창 닫기
				}
			}
		});

	});
</script>
</body>
</html>
