/*
var tabs=document.querySelectorAll("[data-toggle=tab]");

 for (var tab of tabs){//遍历tab
	tab.onclick=function(){//为每个tab添加点击事件
		//查找id为container下有style属性的div
		var show=document.querySelector("#banner img");
		//若找到，移除此div的style属性
		if(show!=null)
			show.removeAttribute("style");
		//获得当前tab的href属性值
		//var id=this.href.split("#")[1];//①浏览器会自动补全完整路径,split解决
		  var id=this.dataset.target.slice(1);//②HTML代码data-target="#content3"
		//用href属性值作为id选择器查找对应容器div
		var div=document.getElementById(id);
		//设置div的style中zIndex为10
		div.style.zIndex=10;
	}
 }
*/
/*轮播效果*/
 function task(){
	 var show=document.querySelector("#banner>ul.banner-img .show");
	show.className="";//先清空自己的样式
	 if(show.nextElementSibling!=null){
		show.nextElementSibling.className="show";
	 }else{
		show.parentNode.children[0].className="show";
	 }
   }
    var timer=setInterval(task,3000);
   slider.onmouseover=function(){//鼠标进入slider，定时器停止
	clearInterval(timer);
	this.timer=null;//好的习惯将定时器序号清空
   }
   slider.onmouseout=function(){
	timer=setInterval(task,3000);
   }
   var imgs=document.querySelectorAll("#banner>ul.banner-img img");
   for(let img of imgs){
		img.onclick=function(){
			alert(this.alt);
		}
   }
