<?php
//data/products/getProductByCid.php
header("Content-Type:application/json");
require_once("../init.php");
@$cid=$_REQUEST["cid"];
$output=[
	//"product"=>{ cid, fid, title, ...},
	//"specs"=>[ {cid:1, spec:xxx}, {cid:2, spec:xxx}, ...],
	//"imgs"=>[{sm:xxx,md:xxx,lg:xxx},xxx]
];
if($cid){
	$sql="SELECT * FROM zc_cars where cid=$cid";
	$result=mysqli_query($conn,$sql);
	$product=mysqli_fetch_all($result,1)[0];
	$output["product"]=$product;
	$fid=$product["fid"];
	$sql="SELECT cid, spec FROM zc_cars where fid=$fid";
	$result=mysqli_query($conn,$sql);
	$output["specs"]=mysqli_fetch_all($result,1);
	$sql="SELECT * FROM zc_cars_pic where cid=$cid";
	$result=mysqli_query($conn,$sql);
	$output["imgs"]=mysqli_fetch_all($result,1);
}
echo json_encode($output);