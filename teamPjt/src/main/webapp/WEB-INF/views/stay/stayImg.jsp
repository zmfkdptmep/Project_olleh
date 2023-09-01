<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../resources/css/common/48ab7619b7161b1c.css" rel="stylesheet">
<link href="../resources/css/common/5f0d2e1da89b35fb.css" rel="stylesheet">
<link href="../resources/css/list/list.css" rel="stylesheet">
<style>
	@font-face {
            font-family: SpoqaHanSans;
            font-weight: 100;
            src: url(/_next/static/media/SpoqaHanSansRegular.50d57b70.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansRegular.328aee46.woff) format("woff"), url(/_next/static/media/SpoqaHanSansRegular.ccdc4420.woff2) format("woff2")
        }

        @font-face {
            font-family: SpoqaHanSans;
            font-weight: 300;
            src: url(/_next/static/media/SpoqaHanSansRegular.50d57b70.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansRegular.328aee46.woff) format("woff"), url(/_next/static/media/SpoqaHanSansRegular.ccdc4420.woff2) format("woff2")
        }

        @font-face {
            font-family: SpoqaHanSans;
            font-weight: 400;
            src: url(/_next/static/media/SpoqaHanSansRegular.50d57b70.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansRegular.328aee46.woff) format("woff"), url(/_next/static/media/SpoqaHanSansRegular.ccdc4420.woff2) format("woff2")
        }

        @font-face {
            font-family: SpoqaHanSans;
            font-weight: 500;
            src: url(/_next/static/media/SpoqaHanSansRegular.50d57b70.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansRegular.328aee46.woff) format("woff"), url(/_next/static/media/SpoqaHanSansRegular.ccdc4420.woff2) format("woff2")
        }

        @font-face {
            font-family: SpoqaHanSans;
            font-weight: 700;
            src: url(/_next/static/media/SpoqaHanSansBold.0fd60c37.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansBold.f9065bbd.woff) format("woff"), url(/_next/static/media/SpoqaHanSansBold.0c12aa88.woff2) format("woff2")
        }

        @font-face {
            font-family: SpoqaHanSans;
            font-weight: 800;
            src: url(/_next/static/media/SpoqaHanSansBold.0fd60c37.ttf) format("truetype"), url(/_next/static/media/SpoqaHanSansBold.f9065bbd.woff) format("woff"), url(/_next/static/media/SpoqaHanSansBold.0c12aa88.woff2) format("woff2")
        }

        @font-face {
            font-family: NanumSquare;
            font-weight: 100;
            src: url(/_next/static/media/NanumSquareL.89916685.eot);
            src: url(/_next/static/media/NanumSquareL.89916685.eot?#iefix) format("embedded-opentype"), url(/_next/static/media/NanumSquareL.20f00212.woff) format("woff"), url(/_next/static/media/NanumSquareL.c5f442a7.ttf) format("truetype")
        }

        @font-face {
            font-family: NanumSquare;
            font-weight: 300;
            src: url(/_next/static/media/NanumSquareR.7bd3e46d.eot);
            src: url(/_next/static/media/NanumSquareR.7bd3e46d.eot?#iefix) format("embedded-opentype"), url(/_next/static/media/NanumSquareR.c0c44f2a.woff) format("woff"), url(/_next/static/media/NanumSquareR.e314b586.ttf) format("truetype")
        }

        @font-face {
            font-family: NanumSquare;
            font-weight: 500;
            src: url(/_next/static/media/NanumSquareB.0a85fe47.eot);
            src: url(/_next/static/media/NanumSquareB.0a85fe47.eot?#iefix) format("embedded-opentype"), url(/_next/static/media/NanumSquareB.1ef493de.woff) format("woff"), url(/_next/static/media/NanumSquareB.ccf112ee.ttf) format("truetype")
        }

        @font-face {
            font-family: NanumSquare;
            font-weight: 700;
            src: url(/_next/static/media/NanumSquareEB.3c60c42a.eot);
            src: url(/_next/static/media/NanumSquareEB.3c60c42a.eot?#iefix) format("embedded-opentype"), url(/_next/static/media/NanumSquareEB.abcc264b.woff) format("woff"), url(/_next/static/media/NanumSquareEB.d6c2427e.ttf) format("truetype")
        }

        @font-face {
            font-family: Abel;
            font-style: normal;
            font-weight: 300;
            src: local("Abel"), url(/_next/static/media/Abel-Regular.7b8ef719.woff) format("woff")
        }

        @font-face {
            font-family: Lato-Light;
            font-style: normal;
            font-weight: 400;
            src: local("Lato Light"), url(/_next/static/media/Lato-Light.1d96d260.woff) format("woff")
        }

        @font-face {
            font-family: Lato-Regular;
            font-style: normal;
            font-weight: 400;
            src: local("Lato Regular"), url(/_next/static/media/Lato-Regular.2584c58a.woff) format("woff")
        }

        @font-face {
            font-family: Lato-Bold;
            font-style: normal;
            font-weight: 400;
            src: local("Lato Bold"), url(/_next/static/media/Lato-Bold.1d7ec642.woff) format("woff")
        }

        @font-face {
            font-family: Lato-Black;
            font-style: normal;
            font-weight: 400;
            src: local("Lato Black"), url(/_next/static/media/Lato-Black.4842dab1.woff) format("woff")
        }

        @font-face {
            font-family: "DroidSerif-Regular";
            font-style: normal;
            font-weight: 400;
            src: local("DroidSerif-Regular"), url(/_next/static/media/DroidSerif-Regular.63a2abb8.woff) format("woff")
        }

        @font-face {
            font-family: "DroidSerif-Italic";
            font-style: normal;
            font-weight: 400;
            src: local("DroidSerif-Italic"), url(/_next/static/media/DroidSerif-Italic.48c82928.woff) format("woff")
        }

        @font-face {
            font-family: "DroidSerif-Bold";
            font-style: normal;
            font-weight: 400;
            src: local("DroidSerif-Bold"), url(/_next/static/media/DroidSerif-Bold.196018b5.woff) format("woff")
        }

        @font-face {
            font-family: "DroidSerif-BoldItalic";
            font-style: normal;
            font-weight: 400;
            src: local("DroidSerif-BoldItalic"), url(/_next/static/media/DroidSerif-BoldItalic.5ba8b50a.woff) format("woff")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 100;
            src: url(/_next/static/media/SUIT-Thin.fb0604ad.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 200;
            src: url(/_next/static/media/SUIT-ExtraLight.0a94b30c.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 300;
            src: url(/_next/static/media/SUIT-Light.c7c7e9d9.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 400;
            src: url(/_next/static/media/SUIT-Regular.090f7270.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 500;
            src: url(/_next/static/media/SUIT-Medium.63be5f82.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 600;
            src: url(/_next/static/media/SUIT-SemiBold.6b582e19.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 700;
            src: url(/_next/static/media/SUIT-Bold.24a0b501.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 800;
            src: url(/_next/static/media/SUIT-ExtraBold.027e87c9.woff2) format("woff2")
        }

        @font-face {
            font-family: SUIT;
            font-weight: 900;
            src: url(/_next/static/media/SUIT-Heavy.5ae5d0f6.woff2) format("woff2")
        }

        ._gallery_sec_photo__CITKA {
            margin-top: 60px;
            display: flex;
            justify-content: space-between;
            min-width: 1100px
        }

        ._gallery_cont_area__OLib1 {
            width: 320px
        }

        ._gallery_cont_tit__nqN0s {
            position: relative
        }

        ._gallery_cont_tit__nqN0s:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 54px;
            height: 4px;
            background: #333
        }

        ._gallery_name__FFIx8 {
            font-size: 40px;
            line-height: 1.1;
            padding-top: 35px
        }

        ._gallery_desc__2gd8E {
            font-size: 22px;
            line-height: 1.2;
            padding-top: 25px;
            color: #666
        }

        ._gallery_location__KCmB2 {
            font-size: 18px;
            line-height: 1.2;
            padding-top: 25px;
            color: #a5a5a5
        }

        ._gallery_cont_subtit__e5Fgl {
            border-top: 2px solid #333;
            padding-top: 17px;
            font-size: 26px;
            color: #333
        }

        ._gallery_photo_box__Wg_4Z {
            position: relative;
            background: #f4f4f4;
            width: 848px;
            font-size: 0;
            text-align: center
        }

        ._gallery_btn_photo_view__w6h_2 {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 36px;
            height: 36px;
            background: url(/web/images/ico-photo-view.svg) no-repeat 50%;
            background-size: 20px 20px;
            text-indent: -99999px
        }

        ._gallery_pointer__c0HmY {
            cursor: pointer
        }

        ._gallery_photo__q4TEN {
            max-width: 848px;
            max-height: 565px;
            display: inline-block
        }

        ._gallery_photo-pop__1fXFz {
            max-width: 100vw;
            max-height: 100vh;
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-color: #1a1a1a;
            z-index: 9101;
            color: #f0f0f0;
            --swiper-navigation-color: #ccc
        }

        ._gallery_photo_box_zoom__XKyYh {
            position: relative;
            text-align: center;
            height: 100vh
        }

        ._gallery_photo_box_zoom__XKyYh,
        ._gallery_photo_zoom__iZQqc {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%
        }

        ._gallery_photo_zoom__iZQqc {
            max-width: 1280px;
            height: calc(100vh - 220px);
            background-color: #1a1a1a
        }

        ._gallery_photo_zoom__iZQqc img {
            max-width: 100%;
            max-height: 100%;
            display: inline-block
        }

        ._gallery_desc_zoom__mZx9R {
            background-color: #1a1a1a;
            position: absolute;
            bottom: 35px;
            left: 0;
            width: 100%;
            text-align: center;
            color: #f0f0f0;
            font-size: 22px
        }

        ._gallery_name_zoom___1ZE5 {
            font-size: 16px;
            color: #ccc;
            display: inline-block;
            margin-top: 15px
        }

        ._gallery_btn_close__kYJkd {
            position: fixed;
            top: 50px;
            right: 50px;
            color: #fff;
            font-size: 18px;
            padding-right: 35px;
            background: url(/web/images/ico-slide-close-btn.svg) no-repeat 100% 50%;
            background-size: 22px 22px;
            z-index: 95
        }

        @media (max-width:768px) {
            ._gallery_wrapper__cyjyQ {
                padding-top: 35px
            }

            ._gallery_sec_photo__CITKA {
                margin-top: 30px;
                display: block;
                min-width: auto
            }

            ._gallery_cont_area__OLib1 {
                width: 100%
            }

            ._gallery_cont_tit__nqN0s:before {
                display: none
            }

            ._gallery_name__FFIx8 {
                font-size: 24px;
                padding-top: 10px
            }

            ._gallery_desc__2gd8E {
                font-size: 16px;
                padding-top: 15px
            }

            ._gallery_location__KCmB2 {
                font-size: 14px;
                padding: 10px 0 25px
            }

            ._gallery_cont_subtit__e5Fgl {
                border-top: none;
                padding: 17px 0 15px;
                font-size: 18px
            }

            ._gallery_photo_box__Wg_4Z {
                width: 100%
            }

            ._gallery_photo__q4TEN {
                max-width: 100%;
                max-height: 300px
            }

            ._gallery_photo-pop__1fXFz {
                z-index: 9000
            }

            ._gallery_photo_zoom__iZQqc {
                height: calc(100svh - 230px);
                transform: translateY(-10px)
            }

            ._gallery_desc_zoom__mZx9R {
                bottom: 115px;
                font-size: 16px;
                padding-top: 10px
            }

            ._gallery_name_zoom___1ZE5 {
                font-size: 12px;
                margin-top: 10px
            }

            ._gallery_btn_close__kYJkd {
                top: 65px;
                right: 20px;
                background-size: 16px 16px;
                text-indent: -99999px
            }
        }

        @media (min-width:769px) and (max-width:1280px) {
            ._gallery_cont_area__OLib1 {
                width: 25%;
                max-width: 200px
            }
        }
</style>
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/header.jsp" %>
	<div class="_gallery_wrapper__cyjyQ">
                <div class="container">
                	
                	
                    <div class="_gallery_sec_photo__CITKA">
                        <div class="_gallery_cont_area__OLib1">
                            <div class="_gallery_cont_tit__nqN0s">
                                <p class="_gallery_name__FFIx8">${param.stayName}</p>
                                 <p class="_gallery_desc__2gd8E">${stayImg.STAYINFO}</p>
                                <p class="_gallery_location__KCmB2">${stayImg.STAYLOC}</p>
                            </div>
                        </div>
                        <div>
                            <div class="_gallery_photo_box__Wg_4Z">
                                <div data-index="0" role="presentation" class="_gallery_pointer__c0HmY"><img
                                        src="../resources/images/${stayImg.MAINPIC1}"
                                        alt="Detail Stay" class="_gallery_photo__q4TEN" loading="lazy"></div>
                            </div>
                        </div>
                    </div>
                    
                    <c:set var="prevRoomName" value="" />
                    
                    <div class="_gallery_sec_photo__CITKA">
                        <div class="_gallery_cont_area__OLib1">
	                            <div class="_gallery_cont_subtit__e5Fgl">스테이</div>
                        </div>
	                        <div>
	                    <c:forEach items="${roomImg}" var="room" step="1">
	                            <div class="_gallery_photo_box__Wg_4Z" style="margin-bottom: 30px">
	                                <div data-index="1" role="presentation" class="_gallery_pointer__c0HmY"><img
	                                        src="../resources/images/${room.FILENAME.replace('\\','/') }"
	                                        alt="Detail Stay" class="_gallery_photo__q4TEN" loading="lazy"></div>
	                            </div>
	                    </c:forEach>
	                        </div>
                    </div>
                   </div>
            </div>
	<%@include file="../common/footer.jsp"%>
</body>
</html>