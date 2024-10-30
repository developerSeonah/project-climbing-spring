






function requestPay() {

    var IMP = window.IMP; // imp 객체를 가져온다.
    IMP.init("imp87461252"); // 고객사 식별 코드

    let uuid = self.crypto.randomUUID(); // 랜덤 uuid생성
    const cleanUuid = uuid.replace(/-/g, ""); // 불필요한 특수기호 삭제
    const currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, '');

    const merchant_uid = cleanUuid+currentDate; // 예약자id+주문 번호 날짜+랜덤값
    console.log("merchant_uid : "+merchant_uid);

    let reservation_price = $('#member_money').val(); // 가격
    console.log("가격 : "+reservation_price);
    let gym_num = $('#gymNum').val(); // 암벽장 번호
    console.log("암벽장 번호 : "+gym_num);
    let reservationDate = $('#member_date').val(); // 예약 날짜
    console.log("예약일 : "+reservationDate);
    const gym_name = $('#gymName').val(); // 암벽장 이름
    console.log("암벽장 이름 : "+gym_name);
    const member_id = $('#member_id').val(); // 사용자 이름
    console.log("멤버 아이디 : "+member_id);
    const member_point = $('#member_point').val(); // 사용자 사용한 포인트
    console.log("멤버 사용포인트 : "+member_point);
    const member_name = $('#member_name').val(); // 사용자 이름
    console.log("멤버 이름 : "+member_name);

    // 사전 검증 등록
    $.ajax({
        url: "paymentPrepare.do",
        method: "POST",
        data: {
            merchant_uid: merchant_uid,
            reservation_price: reservation_price
        } // UUID, 가격 보내서 사전 검증 Controller로 전달
    }).done(function(data) {
        console.log("첫 번째 응답: " + data);
        if (data === "true") {  // true라면
            console.log("사전 검증 등록 완료"); // 사전검증 등록 성공

            // 사전 검증 등록 확인
            $.ajax({
                url: "paymentPrepared.do",
                method: "POST",
                dataType: "json",
                data: {
                    merchant_uid: merchant_uid // 해당 uuid 보냄
                }
            }).done(function(data) {
                console.log("두 번째 응답:", data); // 응답 전체 확인
                console.log("두 번째 응답:", data.amountRes); // 금액 확인

                if (!isNaN(data.amountRes) && data.amountRes > 0) { // 결제한 금액이 있다면
                    console.log("사전 검증 등록 조회 성공");
                    amount = data.amount_result;
                    console.log(amount);
                } else {
                    console.log("오류 발생: 반환된 값이 유효하지 않음");
                }
            }).fail(function(error) {
                console.log("사전 검증 조회 AJAX 오류:", error);
            });

        } else {
            console.log("사전 검증 등록 실패");
        }
    }).fail(function(error) {
        console.log("사전 검증 등록 AJAX 오류:", error);
    });

    IMP.request_pay({
        pg: 'kakaopay',
        pay_method: 'card',
        amount: reservation_price,
        name: gym_name,
        gym_num: gym_num,
        member_id: member_id,
        merchant_uid: merchant_uid,
        reservationDate : reservationDate
    },
        function (rsp) {
            if (rsp.success) {
                // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                // jQuery로 HTTP 요청
                jQuery.ajax({
                    url: "paymentValidate.do",
                    method: "POST",
                    // JSON 형식으로 전송
                    data: {
                        imp_uid: rsp.imp_uid,  // 포트원 결제 고유번호
                        product_num: gym_num,
                        merchant_uid: rsp.merchant_uid  // 주문번호
                    }
                }).done(function (data) {
                    if (rsp.paid_amount == data) {
                        // 결제 API 성공시 로직
                        alert("결제 및 결제검증완료");
                        location.href = "main.do"
                    } else {
                        alert("검증 실패");
                        // 결제 취소
                        location.href = "main.do"
                    }
                }).fail(function (error) {
                    console.error('AJAX 요청 오류:', error);
                    console.error('에러 상태 코드:', error.status);
                    console.error('에러 응답 텍스트:', error.responseText);
                });
            } else {
                alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
            }
        });
};


document.addEventListener('DOMContentLoaded', function () {
    // 버튼 클릭 시 requestPay 함수 호출
    document.getElementById('reservationbtn').addEventListener('click', requestPay);
});
