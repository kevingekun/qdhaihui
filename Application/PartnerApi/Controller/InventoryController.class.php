<?php
namespace PartnerApi\Controller;

use Common\Controller\ApiController;
use Think\Controller;
use Common\Util\HisenseInventory;

/**
 * Inventory Controller
 * @author: leehwui 
 * @date: 2015/11/02 13:50
 */
class InventoryController extends ApiController
{

    public function _initialize()
    {
        header("Content-type: text/html; charset=utf-8");
    }


    public function test()
    {
        $app_key = 'XdLVPyq8AyAmvxxEjyYM';
        $app_pwd = '123456';
        $hisense_inventory = new HisenseInventory();

        $ecp_inventory = D('ecp_inventory');
        $ecp_inventory->updateInventoryList();
//        $app_key = 'HXHHR';
//        $app_pwd = '239B5F335E23F1EBE0532B2B10AC37D6';
        $sku_id = '1TE6004TCNCB';
        $warehouse_code = '1532';

        $hisense_inventory = new HisenseInventory($app_key, $app_pwd);
//        $hisense_inventory->syncAreaInfo();
        $hisense_inventory->warehouseInventory($sku_id, $warehouse_code);

        $hisense_inventory->query();
        $result = $hisense_inventory->result();

        var_dump(json_decode($result, true)); exit;

        var_dump($hisense_inventory); exit;
        var_dump($hisense_inventory); exit;
    }


    public function inventory($sku_id="", $warehose_code="")
    {
        $app_key = 'PARTNER';
        $app_pwd = '239B5F335E23F1EBE0532B2B10AC37D6';
        $sku_id = '1TE6004TCNCB';
        $warehouse_code = '1532';

        if (empty($sku_id) || empty($warehouse_code)) {
            exit('参数不全');
        }

        
        $hisense_inventory = new HisenseInventory($app_key, $app_pwd);
        $hisense_inventory->warehouseInventory($sku_id, $warehouse_code);
        
    }

    public function updateInventory()
    {
        try{
            $ecp_inventory = D('ecp_inventory');
            $result = $ecp_inventory->updateInventory();

            if ($result > 0 ) {
                $this->success($result.' items updated');
            }

        } catch (Exception $e) {
            $err_msg = $e->getMessage();
            if ($err_msg == "empty sku_list") {
                $this->exit('无ecp商品需要更新');
            }
        }
    }
}
