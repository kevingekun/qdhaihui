<?php
namespace Common\Util;

use Think\Exception;

class HisenseInventory
{


    const URL = 'http://172.16.34.88:8080/api';
//    const URL = 'http://221.0.232.174:8080/api';
    const METHOD_WAREHOUSE_INVENTORY = 'mall.areaInventory.queryInventoryQuantity';
    const METHOD_SYNCAREAINFO = 'mall.areaInventory.syncAreaInfo';

    private $_appkey = '';
    private $_appPwd = '';
    private $_method = '';
    private $_inventory = '';
    private $_data = array();
    private $_result = '';


    public function __construct($appkey, $appPwd)
    {
        $this->_appkey = $appkey;
        $this->_appPwd = $appPwd;
    }

    public function foo()
    {
        echo "hello, world";
        exit;
    }

    /*
    * 查询方式赋值，1为查询库存，2为同步库存
     */
    public function method($method)
    {
        switch($method){
        case '1':
            $this->_method = self::METHOD_WAREHOUSE_INVENTORY;
        case '2':
            $this->_method = self::METHOD_SYNCAREAINFO;
        }

        return $this;
    }

    /*
    * 拼装仓库查询字串
    * @param string $sku_id(商品sku)
    * @param string $warehouse_code 仓库编码(由提供)
    * @return $this
    */
    public function warehouseInventory($sku_id, $warehouse_code, $pageIndex='1', $pageSize='5')
    {
        $this->_method = self::METHOD_WAREHOUSE_INVENTORY;

        $data = array(
            'sku_id' => $sku_id,
            'warehouseCode' => $warehouse_code,
            'pageIndex' => $pageIndex,
            'pageSize' => $pageSize,
        );

        $this->_data = $data;

        return $this;
    }

    /*
    * 同步仓库列表
    * @return $this
     */
    public function syncAreaInfo()
    {
        $this->_method = self::METHOD_SYNCAREAINFO;

        $this->_data = '';

        return $this;

    }



    /*
    * 向ecp发送查询请求
    * @return $this
    */
    public function query()
    {
        $data_str = json_encode($this->_data);
//        var_dump($data_str); exit;
        $sign_str = $this->_appkey.$this->_method.$data_str.$this->_appPwd;

        $signature = md5($sign_str);
        $post_data = array(
            'Method' => $this->_method,
            'AppKey' => $this->_appkey,
            'Sign' => $signature,
            'Data' => json_encode($this->_data),
        );

        $url = self::URL;

        $this->_result = $this->http_post($url, $post_data);

        return $this;
    }


    /*
    * 返回查询结果
    * @return string $this->_result
    */
    public function result()
    {
        if (empty($this->_result)) {
            throw new Exception('No query peformed');
        } else {
            return $this->_result;
        }
    }
    


    private function http_post($url, $post_data)
    {
        $post_data = http_build_query($post_data);

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);

        $response = curl_exec($ch);
        curl_close($ch);

        return $response;
    }
}
