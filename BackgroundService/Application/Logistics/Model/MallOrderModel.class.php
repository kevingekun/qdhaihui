<?php

namespace Logistics\Model;

use Common\Model\LogisticsModel;
use Logistics\Common\Vendor\SfExpress;

class MallOrderModel extends LogisticsModel
{

    const TEST_CUSTID = "BSPdevelop";
    const TEST_CHECKWORD = "j8DzkIFgmlomPt0aLuwU";

    public $_data = "";
    
    public function foo()
    {
        echo "hello foo";exit;
    }

    public function get_by_way_bill($way_bill_no)
    {
        $map['way_bill_no'] = array('eq', $way_bill_no);
        $result = $this->where($map)->find();

        $this->_data= $result;
        return $this;
    }

    /*
    * 更新路由信息
    * @param string @way_bill_no 运单号
    * @return mixed 成功返回影响条目（1）失败返回false
    */
    public function updateRoutes()
    {
        $custid = self::TEST_CUSTID;
        $checkword = self::TEST_CHECKWORD;
        if (!$id = $this->_data['id']) {
            throw new \Think\Exception('specify a record to operate on first.');
        }
        $way_bill_no = $this->_data['way_bill_no'];
    
        $sfExpress = new SfExpress($custid, $checkword);
        $sfExpress->RouteService($way_bill_no)->Send(true);

        $routes = $sfExpress->result();

        $routes_string = $this->routeStr($routes);
        $last_route = $this->lastRoute($routes);

        if (empty($routes_string) || empty($last_route)) {
            throw new \Think\Exception('failed fetching data from sfexpress');
        }

        $data = array('routes' => $routes_string, 'last_route' => $last_route, 'updated_at' => time());
        $map['id'] = array('eq', $id);

        return $this->where($map)->setField($data); 
    }

    /*
    * 将路由数组最后一条更新到数据库
    * @param array $routes
    * @return mixed 成功返回影响条目(1),失败返回false
    */
    public function updateLastRoute($routes)
    {
        $last_route = implode(', ', end($routes));
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
        return end($routes)['opcode'];
    }
}

