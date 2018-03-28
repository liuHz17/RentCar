(()=>{
var i=1;//记录当前第几张图片
function task(){
	i++;//换下一张
	if(i==4) i=1;//超范围，就改回1
	//查找所有div
	var divs=document.querySelectorAll(".banner-img>div");
	var j=0,count=10,interval=50,dura=500;
	var timer=setInterval(()=>{
		var div=divs[j];//获得当前div
		div.style.backgroundImage=`url(imgs/${i}.jpg)`;
		div.className="shake";
		j++;//跳到下一个div的位置
		if(j==count) clearInterval(timer);//自动结束
	},50)//每隔50毫秒，才设置下一个div的震动
	setTimeout(()=>{//等最后一个div震完，才移除class
		for(var div of divs) div.className="";
		document.querySelector(".banner-img>img").src="imgs/"+i+".jpg";
	},interval*count+dura)
}
setInterval(task,3000);
})()
//超值产品推荐
var tabs=document.querySelectorAll("[data-toggle=tab]");
 for (var tab of tabs){//遍历tab
	tab.onclick=function(){//为每个tab添加点击事件
		//查找id为advs下有style属性的div
		var show=document.querySelector("#advs>div[style]");
		//若找到，移除此div的style属性
		if(show!=null)
			show.removeAttribute("style");
		//获得当前tab的href属性值
		//var id=this.href.split("#")[1];
		  var id=this.dataset.target.slice(1);
		//用href属性值作为id选择器查找对应容器div
		var div=document.getElementById(id);
		//设置div的style中zIndex为10
		div.style.zIndex=10;
	}
 }