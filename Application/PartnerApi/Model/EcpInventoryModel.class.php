<?php
namespace PartnerApi\Model;

use Common\Util\HisenseInventory;
use Think\Model;
use Think\Exception;

class EcpInventoryModel extends Model
{
    const APP_KEY = 'PARTNER';
    //const APP_KEY = 'test';
    const APP_PWD = '239B5F335E23F1EBE0532B2B10AC37D6';

    protected $_validate =  array(
        
    );

    public function updateInventory()
    {
        $goods = D('mall_good');
        $sku_list = $goods->skuList();

        $rows_effected = 0;

        foreach ($sku_list as $sku_id) {
            $result = $this->update_item_inventory($sku_id);

            $rows_effected += $result;
        }

        return $rows_effected;
    }

    /*
    * 更新指定sku_id的商品在数据库中的信息，存在更新不存在创建
    * @param string $sku_id 商品id
    * @param string $warehouse_code 仓库编号
    * @return mixed 成功返回
    */

    private function update_item_inventory($sku_id='')
    {

        $hisense_inventory = new HisenseInventory(self::APP_KEY, self::APP_PWD);
        
        $result = $hisense_inventory->warehouseInventory($sku_id)->query()->result();

        $result = json_decode($result, true);
  
        $inventory_info = $result['retData']['inventoryList'];
        $trimmed = $this->trim_inventory_list($inventory_info);

        $list_converted= $this->convert($trimmed);

        $rows_effected = 0;

        foreach ($list_converted as $item) {
            $where['sku_id'] = array('like', $item['sku_id']);
            $where['warehouse_code'] = array('like', $item['warehouse_code']);
            $inventory = $this->where($where)->find();

            $pk = $inventory['id'];
            if (isset($pk)) {
                $item['updated_at'] = time();
                if ($this->where('id='.$pk)->save($item)) {
                    $rows_effected += 1;
                };
            } else {
                $item['created_at'] = time();
                if ($this->add($item)) {
                    $rows_effected += 1;
                }
            }
        }
        
        return $rows_effected; 
    }

    /*
     * 从全部列表里面挑出电商库的列表
     * @param array $inventory_list 取回的全部库存列表
     * @return array $trimmed 过滤之后的电商库
     *
     */
    private function trim_inventory_list($inventory_list)
    {
        $trimmed = array();
        
        foreach ($inventory_list as $item) {
            $warehouseCode = trim($item['warehouseCode']);
            $initial = substr($warehouseCode, 0, 1);
            if ($initial == 'D') {
                $trimmed[] = $item;
            }
        }
        return $trimmed;
    }

    private function convert($inventory_list)
    {
        $converted = array();
        $i = 0;

        foreach ($inventory_list as $item) {
            $converted[$i]['sku_id'] = $item['sku_id'];
            $converted[$i]['product_count'] = $item['productCount'];
            $converted[$i]['warehouse_code'] = $item['warehouseCode'];
            $converted[$i]['warehouse_name'] = $item['warehouseName'];
            ++$i;
        }

        return $converted;
    }
}
