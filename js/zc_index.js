//异步加载页头
$(()=>{
$('#header').load('zuche-header.html',function(){
    $.ajax({
        url: 'data/users/session_data.php',
        success: function(result){
            if(result.uname){
                $('.list').html('<li>&nbsp;欢迎:'+result.uname+' <a href="logout.html" title="退出登录">退出</a><b>|</b></li><li><a href="uc_basic.html" title="用户中心">用户中心</a></li>');
                $('[href="logout.html"]').click(function(e){
                    e.preventDefault();
                    $.ajax({
                        url: 'data/users/logout.php',
                        success: function(result){
								if(result.code===200){
									alert("退出成功");
									location.href = 'login.html';
								}else{
									alert('退出失败！原因：'+result.msg);
								}
							}
                        })
                    })
                };
            }
		})
      })
});

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
})();
//超值产品推荐
/*
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
 */
//39

// banner轮播图
(()=>{
var imgs=[
    "img/ad-01.jpg",
    "img/ad-02.jpg",
    "img/ad-03.jpg",
    "img/ad-04.jpg"
];
var $ulImgs=$("#slider"),
    $ulIdxs=$("#index");

const LIWIDTH=1911,
       INTERVAL=1000,
        WAIT=1000;
// 给slider添加内容
$ulImgs.html(
    `<li>
         <a >
              <img src="${imgs.join('"></a></li><li><a ><img src="')}
              "></a></li>`+`<li><img src="${imgs[0]}"></li>`
).css("width",LIWIDTH*(imgs.length+1));
$ulIdxs.html(
    ()=>{
        var str="";
        for(i=1;i<=imgs.length;i++){
            str+=`<li>${i}</li>`
        }
        return str;
    }
).children(":first").addClass("hover");

var moved=0,
    timer=null,
    canMove=true;

// 设置轮播动画
    function move(){
    if(canMove){
        timer =setTimeout(
            ()=>{
                moved ++;
                $ulImgs.animate({left: -LIWIDTH * moved },INTERVAL,()=>{
                    if(moved <imgs.length){
                        $ulIdxs.children(`:eq(${moved })`).addClass("hover").siblings().removeClass("hover");
                    }else{
                        moved=0;
                        $ulImgs.css("left",0);
                        $ulIdxs.children(":first").addClass("hover").siblings().removeClass("hover");
                    }
                    move();
                })
            },WAIT
        )
    }
}
move();
$("#banner").hover(
    ()=>{
        clearTimeout(timer);
        timer=null;
        canMove=false;
    },
    ()=>{
        canMove=true;
        move();
    }
);
$ulIdxs.on("mouseover","li",e=>{
    var $li=$(e.target);
    $li.addClass("hover").siblings().removeClass("hover");
    moved=$li.index();
    $ulImgs.stop(true).animate({left:-LIWIDTH*moved},INTERVAL);
});
})();
// 品牌切换
(()=>{
// 点击tab切换下方品牌list
var $brand=$("#brand_show");
$(".brand_toggle [data-toggle=tab]").click(e=>{
    e.preventDefault();
    var $li=$(e.target).parent();
    var i=$li.index();

    if(!$li.hasClass("active")){
        $li.addClass("active").siblings().removeClass("active")
    }
    var $brand=$("#brand_show");
    $brand.children(`:eq(${i})`).css("display","block").siblings().css("display","none");
});
// 点击按钮切换品牌list
var $a1=$("#brand_box>a.prev");
var $a2=$("#brand_box>a.next");
var $toggle=$(".brand_toggle>ul");
var $d=null;
var i=0;
 $a1.click(()=>{
     $d=$brand.children(":visible");
      i=$d.index();
    $d.css("display","none");
     if(i===0){
         $brand.children(":last").css("display","block");
         $toggle.children(":last").addClass("active").siblings().removeClass("active")
     }else{
         i--;
         $d.prev().css("display","block");
         $toggle.children(`:eq(${i})`).addClass("active").siblings().removeClass("active")
     }
 });
$a2.click(()=>{
     $d=$brand.children(":visible");
     i=$d.index();
    $d.css("display","none");
    if(i===2){
        $brand.children(":first-child").css("display","block");
        $toggle.children(":first").addClass("active").siblings().removeClass("active")
    }else{
        i++;
        $d.next().css("display","block");
        $toggle.children(`:eq(${i})`).addClass("active").siblings().removeClass("active")
    }
})
// 小轮播图
var imgs=[
    "img/products/ad1.jpg",
    "img/products/ad2.jpg",
    "img/products/ad3.jpg"
];
var $ulImgs=$(".brand_ad_img"),
    $ulIdxs=$(".brand_ad_index");

const LIWIDTH=650,
    INTERVAL=1000,
    WAIT=2000;
// 给slider添加内容
$ulImgs.html(
    `<li>
         <a >
              <img src="${imgs.join('"></a></li><li><a ><img src="')}
              "></a></li>`+`<li><img src="${imgs[0]}"></li>`
).css("width",LIWIDTH*(imgs.length+1));
$ulIdxs.html(
    ()=>{
        var str="";
        for(i=0;i<imgs.length;i++){
            str+=`<li></li>`
        }
        return str;
    }
).children(":first").addClass("hover");

var moved=0,
    timer=null,
    canMove=true;

// 设置轮播动画
    function move(){
        if(canMove){
            timer =setTimeout(
                ()=>{
                    moved ++;
                    $ulImgs.animate({left: -LIWIDTH*moved },INTERVAL,()=>{
                        if(moved <imgs.length){
                            $ulIdxs.children(`:eq(${moved })`).addClass("hover").siblings().removeClass("hover");
                        }else{
                            moved=0;
                            $ulImgs.css("left",0);
                            $ulIdxs.children(":first").addClass("hover").siblings().removeClass("hover");
                        }
                        move();
                    })
                },WAIT
            )
        }
    }
move();
$(".brand_ad").hover(
    ()=>{
        clearTimeout(timer);
        timer=null;
        canMove=false;
    },
    ()=>{
        canMove=true;
        move();
    }
);
$ulIdxs.on("mouseover","li",e=>{
    var $li=$(e.target);
    $li.addClass("hover").siblings().removeClass("hover");
    moved=$li.index();
    $ulImgs.stop(true).animate({left:-LIWIDTH*moved},INTERVAL);
});
})();
// 左侧浮动导航
(()=>{
var $left=$("#suspension");
$(window).scroll(()=> {
    var height=$(window).scrollTop();
        if(height>=500){
            $left.fadeIn();
        }else{
            $left.fadeOut();
        }
    }
    )
})()
//底部弹出广告

	$(function(){
		//获取浏览器的宽高
		//var windowWidth=$(window).innerWidth();
		//var windowHeight=$(window).innerHeight();
		$("#msg").css({width:"100px",height:"400px"});
		moveIn();
		//定义moveIn方法
		function moveIn(){
			//页面加载完成5秒后，广告出现
			setTimeout(function(){
				$('.advert').slideDown(100);
			},5000);
		}
	})
