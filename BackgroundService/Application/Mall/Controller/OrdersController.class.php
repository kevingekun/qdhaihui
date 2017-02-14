<?php
namespace Mall\Controller;
use Think\Controller;

class OrdersController extends Controller
{
    public function receive()
    {
        $order = D('mall_order');
        $order->autoReceive();
    }
}
