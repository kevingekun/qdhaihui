<?php
namespace Mall\Model;

use Think\Model;
use Think\Exception;

class MallWorkcardModel extends Model
{
    
    public function applicationList($uid) {
        $map['hx_mall_workcard.user_id'] = array('eq', $uid);
        $map['hx_mall_workcard.status'] = array('neq', 9);

        $res = $this->field('type, create_at, hx_mall_order.order_number, hx_mall_workcard.progress, hx_mall_workcard.updated_at, proved_at, closed_at')
                    ->join('hx_mall_order on hx_mall_order.id=order_id')
                    ->where($map)
                    ->select();

        return $res ? $res : false;
    }

    public function hasAppliedService($order_id, $service)
    {
        $map['order_id'] = $order_id;
        $map['type'] = $service;
        $result = $this->where($map)->find();
        return $result ? true : false;
    }


    public function installationStatus($order_id)
    {
        $map['order_id'] = array('eq', $order_id);
        $map['type'] = array('eq', 'install');
        
        $result = $this->field('status')->where($map)->find();

        return $result ? $result['status'] : -1;

    }

    /*
    * 检查订单目前是否正在申请维修服务
    * @param string $order_id
    * @param string $service 服务种类 维修
    * @return boolean 
    *
     */
    public function applicationUnderProcessing($order_id, $service='repair')
    {
        $map['order_id'] = array('eq', $order_id);
        $map['type'] = array('eq', $service);
        $map['status'] = array('neq', 9);

        $result = $this->where($map)->find();

        return $result ? true : false;
    }
}
