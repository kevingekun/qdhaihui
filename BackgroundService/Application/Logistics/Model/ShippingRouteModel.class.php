<?php

namespace Logistics\Model;

use Common\Model\LogisticsModel;
use Logistics\Common\Vendor\Sfexpress;

class ShippingRouteModel extends LogisticsModel
{
    const ORDER_CLOSED = 9; //已结单 

    public $_data = "";
    
    /*
    * update route info in shippingroute table which statu=0
    * @param nil
    * @return mixed Success: nubmer of effected items Fail: false
    */

    public function updateRouteList()
    {

        $way_bill_list = $this->getWayBillList();

        if ($way_bill_list) {
            $i = 0;
            foreach ($way_bill_list as $way_bill_no) {
                $res = $this->updateRoutes($way_bill_no);

                if ($res == -1) {
                    try {
                        $fp = fopen('./Application/Logistics/routes_error.log', 'a+');
                        fwrite($fp, date('Y-m-d H:i:s', time())." ".$way_bill_no." update routes failed. \n");
                        fclose($fp);
                    } catch (Exception $e) {
                        print_r($e->getMessage());
                    }
                } else {
                    $i++;
                }

            }

            try {
                $fp = fopen('./Application/Logistics/routes.log', 'a+');
                fwrite($fp, date('Y-m-d H:i:s', time())." ".$i." packages updated successfully.\n");
                fclose($fp);
            } catch (Exception $e) {
                print_r($e->getMessage());
            }

            return $i;
        }

        return false;
    }

    /*
    * get way_bill_list
    *
    */
    private function getWayBillList($courier="SFExpress")
    {
        $map['status'] = array('eq', 0);
        $map['logistics_id'] = array('like', $courier);
        $res = $this->field('way_bill_no')->where($map)->select();
        if ($res) {
            $way_bill_list = array();
            foreach ($res as $k => $v) {
                $way_bill_list[] = $v['way_bill_no'];
            }
            return $way_bill_list;
        }

        return false;
    }

    /*
    * 更新路由信息
    * @param string @way_bill_no 运单号
    * @return mixed 失败返回false
    */
    private function updateRoutes($way_bill_no)
    {
    
        $sfexpress = new Sfexpress();
        $result = $sfexpress->RouteService($way_bill_no)->Send()->splitArr();

        if($result) {
            try{
            $last_route = end($result);
            if ($last_route[opcode] == '80' || $last_route[opcode] == '8000') { 
                $data['status'] = 1;
                $query  = "UPDATE hx_mall_order ";
                $query .= "SET order_status=".self::ORDER_CLOSED." ";
                $query .= "WHERE order_number LIKE (";
                $query .=       "SELECT order_id FROM hx_shipping_route ";
                $query .=       "WHERE way_bill_no LIKE '".$way_bill_no."'";
                $query .= ")";

                $model = M();

                $res = $model->execute($query);
            }

            $route_str = json_encode($result);
            $last_route_str = json_encode($last_route);

            $data['routes'] = $route_str;
            $data['last_route'] = $last_route_str;

            $res0 = $this->where(array('way_bill_no' =>  array('like', $way_bill_no)))->save($data);

            return $res0;
            } catch (Exception $e) {
                exit($e->getMessage());
            }

        }

        return -1;

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
        //return end($routes)['opcode'];
    }


    /*
     * 将树状路由数组转换为一维路由数组
     * @param array $tree 树状数组
     * @return array $res 一维数组
     */
    private function tree2arr($tree) 
    {
        $res_str = '';
        $res = array();
        $i = 0;
        array_walk_recursive($tree, function($value, $key) use (&$res, &$i){
            if ($key == 'remark')
                $res[$i][$key] = $value;
            if ($key == 'accept_time')
                $res[$i][$key] = $value;
            if ($key == 'accept_address')
                $res[$i][$key] = $value;
            if ($key == 'opcode') {
                $res[$i][$key] = $value;
                ++$i;
            }
        });

        return $res;
    }

    /*
    * 将路由数组转化成字符串
    * @param array $arr 路由数组
    * @return string 路由字符串
    *
     */
    private function arr2str($arr)
    {
        $res = '';
        foreach ($arr as $item) {
            foreach ($item as $k => $v) {
                $item[$k] = urlencode($v);
            }
            $str = json_encode($item);
            $res .= $str;
        }

        return urldecode($res);
    }

    /*
    * 从路由数组中取出最后一条路由并转换成字符串返回
    * @param array $arr 路由数组
    * @return string 最后一条路由字符串
    *
     */

    private function getLastRoute($arr)
    {
        foreach ($arr as $k => $v) {
            $arr[$k] = urlencode($v);
        }

        $str = json_encode($arr);
        return urldecode($str);
    }
}


