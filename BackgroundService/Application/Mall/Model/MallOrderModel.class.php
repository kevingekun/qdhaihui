<?php
namespace Mall\Model;

use Think\Model;

class MallOrderModel extends Model 
{
    //const deltaTime = 7 * 24 * 60 * 60; //发货后deltaTime之后即设为自动收货

    public function autoReceive()
    {
        $deltaTime = 7 * 24 * 60 * 60;
        //$seven_days_ago = time() - self::deltaTime;
        $seven_days_ago = time() - $deltaTime;

        $map['order_status'] = array('eq', 3);
        $map['delivery_time'] = array('elt', $seven_days_ago);

        $orders_to_update = $this->where($map)->select();
        $order_effected = array();
        foreach ($orders_to_update as $k => $v) {
            $order_effected[$k]['order_number'] = $v['order_number'];
            $order_effected[$k]['last_updated_at'] = $v['update_time'];
        }


        $res = $this->where($map)->setField(array('order_status' => 9, 'update_time' => time(), 'complete_time' => time()));

        if ($res) {
            try {
                $fp = fopen('./auto_receive.log', 'a+'); 
                foreach ($order_effected as $item) {
                    fwrite($fp, "=========================\n");
                    fwrite($fp, date('Y-m-d H:i:s', time())." ".$item['order_number']." updated, last updated at ".date('Y-m-d H:i:s', $item['last_updated_at'])."\n");
                }
            } catch (Exception $e) {
                print_r($e->getError());
            }
        }
    }
}
