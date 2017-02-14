<?php
namespace PartnerApi\Model;

use Common\Util\HisenseInventory;
use Think\Model;
use Think\Exception;

class MallGoodModel extends Model
{

    public function skuList()
    {
        $map['is_ecp'] = array('eq', 1);

        $result = $this->field('sku_id')->where($map)->select();

        $sku_list = array();
        foreach($result as $item) {
            $sku_list[] = trim($item['sku_id']);
        }

        return $sku_list;
    }
}
