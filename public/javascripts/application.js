function showAjaxError(a, d){
	var e = $('<div class="error-notification supernovabg"><h3>' + d + '</h3>(点击此区域消除显示)</div>');
	var c = function(){
		$(".error-notification").fadeOut("fast",function(){
			$(this).remove();
		});
	};
	e.click(function(f){
		c();
	});
	$(a).append(e);
	e.fadeIn("fast");
	setTimeout(c, 1000 * 10);
};