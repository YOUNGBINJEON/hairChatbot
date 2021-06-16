<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Camera</title>
</head>
<style>
#camera{
	width: auto;
	height: auto;
	margin: auto;
	display: block;
	border: 1px solid black;
}
.snapshot {
	padding: 10px;
    border: none;
    outline: none;
    border-radius: 10px 10px 10px 10px;
    box-shadow: 4px 3px 15px rgba(0, 0, 0, 0.35);
    cursor: pointer;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: auto;
	margin-right: auto;
	display: block;
}
</style>
<body>
	<div id = "camera"></div>
	<img class='snapshot' src="<%=request.getContextPath() %>/resources/imgs/pngegg.png" onclick="take_snapshot()">
	<div id="results"></div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.26/webcam.min.js" integrity="sha512-dQIiHSl2hr3NWKKLycPndtpbh5iaHLo6MwrXm7F0FM5e+kL2U16oE9uIwPHUl6fQBeCthiEuV/rzP3MiAB8Vfw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
//load all webcam
Webcam.set({
	width: 350,
	height: 250,
	image_format: 'jpeg',
	jpeg_quality: 90
});
Webcam.attach("#camera");

//스냅샷 출력
function take_snapshot(){
	Webcam.snap( function(data_uri) {
		  // display results in page
		  document.getElementById('results').innerHTML = 
		  '<img src="'+data_uri+'"/>';
		  downloadImg(data_uri);
		} );
}
function dataURLtoBlob(dataurl) {
	  var arr = dataurl.split(','),
	    mime = arr[0].match(/:(.*?);/)[1],
	    bstr = atob(arr[1]),
	    n = bstr.length,
	    u8arr = new Uint8Array(n);
	  while (n--) {
	    u8arr[n] = bstr.charCodeAt(n);
	  }
	  return new Blob([u8arr], {
	    type: mime
	  });
	}
//스냅샷 다운로드
function downloadImg(imgSrc) {
	  var image = new Image();
	  image.crossOrigin = "anonymous";
	  image.src = imgSrc;
	  var fileName = image.src.split("/").pop();
	  image.onload = function() {
	    var canvas = document.createElement('canvas');
	    canvas.width = this.width;
	    canvas.height = this.height;
	    canvas.getContext('2d').drawImage(this, 0, 0);
	    if (typeof window.navigator.msSaveBlob !== 'undefined') {
	      window.navigator.msSaveBlob(dataURLtoBlob(canvas.toDataURL()), fileName);
	    } else {
	      var link = document.createElement('a');
	      link.href = canvas.toDataURL();
	      link.download = fileName;
	      link.click();
	    }
	  };
	}
</script>
</html>