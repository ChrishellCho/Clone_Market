
	* ASP.NET 3.5 가상 쇼핑몰 학습 순서

[1] 데이터베이스 

1. ShoppingDB.sql 파일 실행

[2] 주요 로직 컴포넌트

1. 패스워드 암호화 : 유틸리티 클래스
	~/App_Code/Components/Security.cs
2. 고객 처리 : 상품 관련 주요 로직
	~/App_Code/Components/CustomersDB.cs
3. 카테고리 처리 : 카테고리 관련 주요 로직
	~/App_Code/Components/CategoriesDB.cs
4. 상품 처리 : 상품 관련 주요 로직
	~/App_Code/Components/ProductsDB.cs
5. 상품평 처리 : 상품평 관련 주요 로직
	~/App_Code/Components/ReviewsDB.cs
6. 쇼핑카드 처리 : 쇼핑카드 관련 주요 로직
	~/App_Code/Components/ShoppingCartDB.cs
7. 주문 처리 : 주문 관련 주요 로직
	~/App_Code/Components/OrdersDB.cs

[3] 기본 기능 : 쇼핑몰 핵심 페이지 제작

  [3][1] 회원관리

    01. 회원 가입
	    Register.aspx
    02. 아이디 중복 검사
	    CheckID.aspx
	03. 우편번호 데이터 등록 : SQL(데이터가져오기) || 직접 프로그램
	    (http://www.zipfinder.co.kr/)
        ZipCodeAddFromFile.aspx
    04. 우편번호 검색(회원가입, 주문자, 배송지)	
	    GetZipCode.aspx?Zip=<%=%>&Address=<%=%>
    05. 회원 로그인 페이지
	    Login.aspx
	    
  [3][2] 상품관리

    06. 카테고리 등록
	    CategoryAdd.aspx
    07. 카테고리 리스트 
	    CategoryList.aspx
    08. 카테고리에 따른 상품 등록 
	    ProductAdd.aspx
    09. 카테고리에 따른 상품 리스트
	    ProductsList.aspx?CategoryID=<%#%>
    10. 전체 상품 리스트 
	    ProductPages.aspx
    11. 상품 검색
	    SearchForm.aspx : 검색 폼 모듈
    12. 상품 검색 결과
	    SearchResults.aspx : 검색 결과 리스트 
    13. 상품평
	    ReviewList.aspx?ProductID=<%=%>
    14. 연관상품 : 현재 구입하려는 제품과 같이 구입한 제품리스트
	    AlsoBought.aspx?ProductID=<%=%>	
    15. 상품 상세 보기 : 주의)웹폼의 클래스명을 ProductDetailsPage로
	    ProductDetails.aspx?ProductID=<%#%>
	        - ~/Bin/RedPlus.Library.dll
    16. 큰 이미지 보기 : 이미지 상세 보기
	    ShowImages.aspx 	
    17. 이벤트에 따른 상품리스트 : 신상품/히트상품/기획상품
	    EventNames.aspx
    18. 메인 상품 진열 : EventNames.ascx 3번 사용
        ProductCatalog.aspx
    19. 장바구니 담기 
	    AddToCart.aspx?ProductID=<%%>&Quantity=<%%>
    20. 장바구니 
	    ShoppingCart.aspx

  [3][3] 주문관리
	
    21. 회원/비회원 로그인 확인	
	    CheckLogin.aspx
    22. 주문서 페이지
	    CheckOut.aspx
    23. 주문 확인
	    OrderList.aspx : 회원(바로확인)/비회원(주문번호/주문비밀번호입력 후 확인)
    24. 주문 상세 내역 : 주의)클래스명을 OrderDetailsPage로
	    OrderDetails.aspx?OrderID=<%#%>

[4] 추가 기능 : ASP.NET의 주요 기능을 사용

25. 비밀번호 찾기 : 가입했을 때의 이메일로 보내준다.
	PasswordReminder.aspx : ASP.NET 이메일 전송
26. 잘 팔리는 제품 5개 출력
	PopularItems.aspx
27. 회원 동의 : ASP.NET 파일 처리 방법 사용
	Agreement.aspx : 회원 동의 페이지
	Agreement.txt : 원본 데이터
28. 회사 소개 : ASP.NET XML 파일 처리 방법 사용
	Company.aspx : 인라인 방식 : cs 파일 없음
	Company.xml : 회사 정보 보관 데이터 파일(쓰기권한 부여)
	Company.xslt : 회사 소개 페이지 스타일
	CompanyAdmin.aspx : 회사 정보 수정 페이지
29. 이전 상품 이미지 2개 출력, 다음 상품 이미지 2개 출력
	RelatedProduct.ascx : ProductDetails.ascx에 올려놓고 실행
	
[5] 기타 : 개인이 프로젝트로 전체 쇼핑몰을 더 꾸며보도록 한다.

    