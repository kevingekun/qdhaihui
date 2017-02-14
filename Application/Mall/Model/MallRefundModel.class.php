<?php
namespace Mall\Model;

use Think\Model;
use Think\Exception;

class MallRefundModel extends Model
{



    public function create($post_data=array())
    {
        if (empty($post_data)) {
            throw new Exception('empty post data');
        }

        
    }
    
    public function applicationList($uid)
    {
        $map['user_id'] = array('eq', $uid);

        $result = $this->field('order_number, status, create_at, updated_at, proved_at, returned_at, paid_at')->where($map)->select();

        if ($result) {
            $res = array();
            foreach ($result as $item) {
                $item['type'] = 'refund';
                $res[] = $item;
            }

            return $res;
        }

        return false;
    }
     
    /*
    * 返回指定订单的退款状态
    * @param string $order_number 订单id
    * @return int $status   退款状态
     */
    public function refundStatus($order_number, $good_id)
    {
        $map['order_number'] = array('like', $order_number);
        $map['good_id'] = array('eq', $good_id);

        $status = $this->field('status')->where($map)->find();

        return $status['status'] ? intval($status['status']) : false;
    }


    /*
    * 返回当前是第几次提交退款申请
    * @param string $order_number 订单号
    * @return mixed int 第N次提交退款申请 
     */
    public function checkSequence($order_number, $good_id)
    {
        if (!$order_number) {
            throw new Exception('no order_number');
        }

        $map['order_number'] = array('like', $order_number);
        $map['good_id'] = array('eq', $good_id);
        $result = $this->where($map)->find();

        $times = 0;

        if (!empty($result['first_at'])) {
            $times += 1;
        }

        if (!empty($result['second_at'])) {
            $times += 1;
        }

        if (!empty($result['third_at'])) {
            $times += 1;
        }

        return $times;

        
    }
}
