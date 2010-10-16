(function(window,undefined){
	if(window.webcap == undefined){
		var iPhoneFirstScreenHeight = 356;
		var iPhoneRestScreenHeight = 356;
		
		var webcap = {
			
			init:function(){				
			},
			
			// ショートカット
			pageHeight:function(){
				return document.documentElement.scrollHeight;
			},
			pageOffsetY:function(){
				return window.pageYOffset;
			},
			// ページ位置取得
			currentPage:function(){
				if (pageOffsetY <= iPhoneFirstScreenHeight) {
					return 1;
				}else{
					return Math.floor((pageOffsetY - iPhoneFirstScreenHeight) / iPhoneRestScreenHeight) + 1;
				};
			},
			totalPages:function(){
				if (this.pageHeight() <= iPhoneFirstScreenHeight) {
					return 1;
				}else {
					pages = 1;
					additionalPages = Math.ceil((this.pageHeight() - iPhoneFirstScreenHeight)/iPhoneRestScreenHeight);
					return pages + additionalPages;
				};
			},
			// スクロール
			scrollToPage:function(pageNum){
				offsetY = 0;
				firstOffset = iPhoneFirstScreenHeight;
				
				// 1ページ目は0
				if (pageNum < 2) {
					offsetY = 0;
				// 2ページ目以降
				}else if(pageNum >= 2){
					offsetY = iPhoneFirstScreenHeight;
					scrollRest = pageNum - 2;
					offsetY += scrollRest * iPhoneRestScreenHeight;
				};
				
				document.body.scrollTop = offsetY;
				
				// 戻された分
				return this.pageOffsetY() - offsetY;
			},

			
			test:function(){
				alert("hoge");
			},
			currentPage:function(){
				
			},
		};
		window.webcap = webcap;
	}
	webcap.init();
})(window);