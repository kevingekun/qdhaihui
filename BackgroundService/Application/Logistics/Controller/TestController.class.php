<?php
namespace Logistics\Controller;

use Think\Controller;
use Logistics\Common\Vendor\Sfexpress;

class TestController extends Controller
{

    public function _initialize()
    {
        header('Content-type: text/html; charset=utf-8');
    }

    public function testModel()
    {
        $mall_order = D('mall_order');

        $mall_order->foo();
        exit;
    }

    public function index()
    {
        $way_bill_no = '444003077898';

        $sfexpress = new Sfexpress();
        var_dump($sfexpress->RouteService($way_bill_no)->send()->readJSON()); exit;


    }


    public function updateRoutes()
    {
        $custid = "BSPdevelop";
        $checkword = "j8DzkIFgmlomPt0aLuwU";
        $way_bill_no = '444003077898';
    
        $sfExpress = new SfExpress($custid, $checkword);
        $sfExpress->RouteService($way_bill_no)->Send(true);
        $routes = $sfExpress->result();

        $routes_string = $this->routeStr($routes);
        $last_route = $this->lastRoute($routes);

        var_dump($last_route); exit;
    }
    

    /*
    * 将路由数组转化为路由字符串
    * @param array 路由数组
    * @return string 路由字符串
    */
    private function routeStr($routes)
    {
        $route_string = '';

        foreach($routes as $route) {
           $route_string .= (implode(', ', $route)."; "); 
        }

        return $route_string;
    }


    /*
    * 从路由数组中取出最后一条路由
    * @param array 路由数组
    * @return string 路由字符串
    */
    private function lastRoute($routes)
    {
        return implode(', ', end($routes));
    }


    /*
    * 返回路由数组中最后一条路由的状态
    * @param array 路由数组
    * @return string opcode
    */
    private function checkLastStatus($routes)
    {
        //return end($routes)['opcode'];
    }
}
