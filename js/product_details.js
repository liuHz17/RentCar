//页面初始化
$(()=>{
	var lid=location.search.split("=")[1];//"?lid=1"
	$.ajax({
		type:"get",
		url:"data/products/getProductByCid.php",
		data:"cid="+cid,
		dataType:"json"
	}).then(output=>{
		var {product,specs,imgs}=output;
		var {title, subtitle, price, promise}=product;
		document.querySelector("#show-details>h1")
						.innerHTML=title;
		document.querySelector("#show-details>h3>a")
						.innerHTML=subtitle;
		document.querySelector("#show-details .stu-price>span")
						.innerHTML="¥"+price;
		document.querySelector("#show-details .promise>span")
						.innerHTML=promise;
		var html="";
		for(var spec of specs){
			html+=`<a href="product_details.html?cid=${spec.cid}" 
				      class=${spec.cid===product.cid?"active":""}
						 >${spec.spec}</a>`;
		}
		document.querySelector("#show-details .spec>div")
						.innerHTML=html;
		var {title, spec, boxes, capacity}=product;
		document.querySelector("#param>ul")
			.innerHTML=`<li>
              <a href="javascript:;">商品名称：${title}</a>
            </li>
            <li>
              <a href="javascript:;">系统：${spec}</a>
            </li>
            <li>
              <a href="javascript:;">内存容量：${boxes}</a>
            </li>
            <li>
              <a href="javascript:;">分辨率：${capacity}</a>
            </li>`;
		document.querySelector("#product-intro")
			.innerHTML=details;

		var html="";
		for(var pic of imgs){
			html+=`<li class="i1"><img src="${pic.sm}" data-md="${pic.md}" data-lg="${pic.lg}"></li>`;
		}
		var ul=document.querySelector("#icon_list");
		ul.innerHTML=html;
		ul.style.width=62*imgs.length+"px";
		if(imgs.length<=5)
			document.querySelector("#preview>h1>a.forward")
							.className="forward disabled";
		document.querySelector("#mImg").src=imgs[0].md;
		document.querySelector("#largeDiv")
			.style.backgroundImage=`url(${imgs[0].lg})`;
	})
});
//放大镜功能
$(()=>{
	function checkA(){
		if(moved==0)
			aBackward.className="backward disabled";
		else if(ul.children.length-moved==5)
			aForward.className="forward disabled";
		else{
			aBackward.className="backward";
			aForward.className="forward";
		}
	}
	var [aBackward, aForward]=
		document.querySelectorAll("#preview>h1>a");
	var ul=document.getElementById("icon_list");
	var LIWIDTH=62,OFFSET=20,moved=0;
	aForward.onclick=e=>{
		if(e.target.className.indexOf("disabled")==-1)
			move(1);
	}
	aBackward.onclick=e=>{
		if(e.target.className.indexOf("disabled")==-1)
			move(-1);
	}
	function move(dir){
		moved+=dir;
		var left=-LIWIDTH*moved+20;
		ul.style.left=left+"px";
		checkA();
	}
	var mImg=document.getElementById("mImg"),
		  largeDiv=document.getElementById("largeDiv"),
		  mask=document.getElementById("mask"),
			superMask=document.getElementById("superMask");
	ul.onmouseover=e=>{
		if(e.target.nodeName=="IMG"){
			mImg.src=e.target.dataset.md;
			largeDiv.style.backgroundImage=
				`url(${e.target.dataset.lg})`;
		}
	}
	superMask.onmouseover=()=>{
		mask.style.display=largeDiv.style.display="block";
		
	}
	superMask.onmouseout=()=>{
		mask.style.display=largeDiv.style.display="none";
	}
	var MAX=175;
	superMask.onmousemove=e=>{
		var offsetX=e.offsetX, offsetY=e.offsetY;
		var top=offsetY-175/2,
			  left=offsetX-175/2;
		top=top<0?0:top>175?175:top;
		left=left<0?0:left>175?175:left;
		mask.style.top=top+"px";
		mask.style.left=left+"px";
		largeDiv.style.backgroundPosition=
			-left*16/7+"px "+(-top*16/7)+"px";
	}
})
