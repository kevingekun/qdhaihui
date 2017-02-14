<?php
namespace PartnerApi\Model;

use Common\Util\HisenseInventory;
use Think\Model;
use Think\Exception;

class EcpWarehouseModel extends Model
{

    public function warehouseCodeList()
    {
        $result = $this->field('warehouse_code')->select();

        $code_list = array();

        foreach ($result as $item) {
            $code_list[] = $item['warehouse_code'];
        }

        return $code_list;

    }
}
