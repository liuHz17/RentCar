<?php
//data/users/login.php
header('Content-Type: application/json;charset=UTF-8');
require_once("../init.php");
@$uname=$_REQUEST["uname"];
@$upwd=$_REQUEST["upwd"];
/*
if($uname&&$upwd){
	$sql="select uid from zc_user where uname='$uname' and binary upwd='$upwd'";
	$result=mysqli_query($conn,$sql);
	$row=mysqli_fetch_row($result);
	if($row){
		session_start();
		$_SESSION["uid"]=$row[0];
		echo "true";
	}else{
		echo "false";
	}
	}else{
		echo "false";
	}
*/
$sql = "SELECT uid FROM zc_user WHERE uname='$uname' AND upwd='$upwd'";
$result = mysqli_query($conn,$sql);

if(!$result){       //SQL语句执行失败
  echo('{"code":500, "msg":"sql execute err"}');
}else {
  $row = mysqli_fetch_assoc($result);//取出一行关联数组
  if(!$row){        //用户名或密码错误
    echo('{"code":201, "msg":"uname or upwd err"}');
  }else {           //登录成功
    session_start();
    $_SESSION['loginUname'] = $uname;
    $_SESSION['loginUid'] = $row['uid'];
    $pageToJump = @$_SESSION['pageToJump'];
    if($pageToJump==='cart.html' && @$_SESSION['toBuyLid']){
      //完成购物车添加
      $sql = "SELECT iid FROM zc_shoppingcart_item WHERE uid=$_SESSION[loginUid] AND cid=$_SESSION[toBuyLid]";
      $result = mysqli_query($conn, $sql);
      if( mysqli_fetch_row($result) ){
        $sql = "UPDATE zc_shoppingcart_item SET count=count+1 WHERE uid=$_SESSION[loginUid] AND cid=$_SESSION[toBuyLid]";
      }else {
        $sql = "INSERT INTO zc_shoppingcart_item VALUES(NULL, $_SESSION[loginUid], $_SESSION[toBuyLid], $_SESSION[toBuyCount],false)";
      }
      $result = mysqli_query($conn, $sql);
      unset($_SESSION['toBuyLid']);
      unset($_SESSION['toBuyCount']);
      unset($_SESSION['pageToJump']);

      echo('{"code":200, "msg":"login succ", "pageToJump":"'.$pageToJump.'"}');
    }else if($pageToJump==='cart.html'){
      //完成购物车查看
      unset($_SESSION['pageToJump']);
      echo('{"code":200, "msg":"login succ", "pageToJump":"'.$pageToJump.'"}');
    }else {
      echo('{"code":200, "msg":"login succ"}');
    }
  }
}