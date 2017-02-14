<?php
namespace Logistics\Controller;
use Think\Controller;

class MallController extends Controller
{
  const GOODS_ON_SHELF = 1;
  const GOODS_OFF_SHELF = 0;

    /**
     * 商品定时上架
     */
    public function timingOnTheShelf()
    {
      // 当前时间戳
      $time = $_SERVER['REQUEST_TIME'];

      // 上架条件  上架时间小于等于 今日的 全部设为上架 大于今日的为 等待上架
      $map['_string'] = "on_time > '0' AND on_time <= $time";;
      $map['status'] = self::GOODS_OFF_SHELF;

      // 查询符合条件的商品
      M('mall_good')->where($map)->setField('status', self::GOODS_ON_SHELF);

    }

    /**
     * 商品定时下架
     */
    public function timingOffTheShelf()
    {
      // 当前时间戳
      $time = $_SERVER['REQUEST_TIME'];

      // 上架条件  上架时间小于等于 今日的 全部设为上架 大于今日的为 等待上架
      $map['_string'] = "off_time > '0' AND off_time <= $time";
      $map['status'] = self::GOODS_ON_SHELF;

      // 查询符合条件的商品
      M('mall_good')->where($map)->setField('status', self::GOODS_OFF_SHELF);
    }
}
