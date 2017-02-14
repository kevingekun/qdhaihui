<?php
namespace Logistics\Common\Vendor;

use \SoapClient;
use \XMLReader;

class Sfexpress {

//    var $_CHECKHEADER = 'BSPdevelop'; //客户卡号,校验码
//    var $_CHECKBODY = 'j8DzkIFgmlomPt0aLuwU'; //checkbody
//    var $_URL = 'http://218.17.248.244:11080/bsp-oisp/ws/sfexpressService?wsdl'; //快递类服务接口url
    var $_CHECKHEADER = 'hisense'; //客户卡号,校验码
    var $_CHECKBODY = 'RAFo8BJGQHSapbvE6lvXD9B3H311w491'; //checkbody
    var $_URL = 'http://bsp-ois.sf-express.com/bsp-ois/ws/sfexpressService?wsdl'; //快递类服务接口url
    var $_XML = "";
    var $_RES = "";

    public function OrderService($data) {
        $xml = '<?xml version="1.0" encoding="utf-8" ?>';
        $xml .= '<Request service="OrderService" lang="zh-CN">';
        $xml .= '<Head>' . $this->_CHECKHEADER . '</Head>';
        $xml .= '<Body>';
        $xml .= '<Order orderid="' . $data["orderid"] . '" express_type="' . $data["express_type"] . '" j_company="' . $data["j_company"] . '" j_contact="' . $data["j_contact"] . '" j_tel="' . $data["j_tel"] . '" j_address="' . $data["j_address"] . '" d_company="' . $data["d_company"] . '" d_contact="' . $data["d_contact"] . '" d_tel="' . $data["d_tel"] . '" d_address="' . $data["d_address"] . '" pay_method="' . $data["pay_method"] . '" j_province="' . $data["j_province"] . '" j_city="' . $data["j_city"] . '" j_county="' . $data["j_qu"] . '" d_province="' . $data["d_province"] . '" d_city="' . $data["d_city"] . '" d_county="' . $data["d_qu"] . '" custid="' . $data["custid"] . '" remark="' . $data["remark"] . '" parcel_quantity="1">';
        if ($data["things_num"] != 0 && $data["things_num"] != "") {
            $xml .= '<Cargo name="' . $data["things"] . '" count="' . $data["things_num"] . '"></Cargo>';
        }
        if ($data["daishou"] != "" && $data["daishou"] != 0) {
            $xml .= '<AddedService name="COD" value="' . $data["daishou"] . '" value1="' . $data["custid"] . '" />';
        }
        $xml .= '</Order>';
        $xml .= '</Body>';
        $xml .= '</Request>';
        $this->XML($xml);
        return $this;
    }

    public function OrderFilterService1($address, $mode=1) {
        $xml = '<?xml version="1.0" encoding="utf-8" ?>';
        $xml .= '<Request service="OrderFilterService" lang="zh-CN">';
        $xml .= '<Head>' . $this->_CHECKHEADER . '</Head>';
        $xml .= '<Body>';
        $xml .= '<OrderFilter filter_type="1" d_address="' . $address . '" />';
        $xml .= '</Body>';
        $xml .= '</Request>';
        $this->XML($xml);
        return $this;
    }

    public function OrderFilterService($data) {
        $orderid = $data["search_orderid"];
        $d_address = $data["search_d_address"];
        $d_tel = $data["search_d_tel"];
        $j_tel = $data["search_j_tel"];
        $j_address = $data["search_j_address"];
        $j_custid = $data["search_j_custid"];

        $xml = '<?xml version="1.0" encoding="utf-8" ?>';
        $xml .= '<Request service="OrderFilterService" lang="zh-CN">';
        $xml .= '<Head>' . $this->_CHECKHEADER . '</Head>';
        $xml .= '<Body>';
        $xml .= '<OrderFilter orderid="' . $orderid . '" filter_type="1" d_address="' . $d_address . '">';
        $xml .= '<OrderFilterOption j_tel="' . $j_tel . '" j_address="' . $j_address . '" d_tel="' . $d_tel . '" j_custid="' . $j_custid . '" />';
        $xml .= '</OrderFilter>';
        $xml .= '</Body>';
        $xml .= '</Request>';
        $this->XML($xml);
        return $this;
    }

    public function OrderSearchService($orderid) {
        $xml = '<?xml version="1.0" encoding="utf-8" ?>';
        $xml .= '<Request service="OrderSearchService" lang="zh-CN">';
        $xml .= '<Head>' . $this->_CHECKHEADER . '</Head>';
        $xml .= '<Body>';
        $xml .= '<OrderSearch orderid="' . $orderid . '" />';
        $xml .= '</Body>';
        $xml .= '</Request>';
        $this->XML($xml);
        return $this;
    }

    public function RouteService($mailno) {
        $xml = '<?xml version="1.0" encoding="utf-8" ?>';
        $xml .= '<Request service="RouteService" lang="zh-CN">';
        $xml .= '<Head>' . $this->_CHECKHEADER . '</Head>';
        $xml .= '<Body>';
        $xml .= '<RouteRequest tracking_type="1" method_type="1" tracking_number="' . $mailno . '"/> ';
        $xml .= '</Body>';
        $xml .= '</Request>';
        $this->XML($xml);
        return $this;
    }

    public function XML($xmltext) {
        $this->_XML = $xmltext;
        return $this;
    }

    public function Send() {
        if ($this->_XML == "") {
            return $this;
        } else {
            $client = new SoapClient($this->_URL);
            $newbody = $this->_XML . $this->_CHECKBODY;
            $md5 = md5($newbody, true);
            $verifyCode = base64_encode($md5);
            $result = $client->sfexpressService(array("arg0" => $this->_XML, "arg1" => $verifyCode));
            $this->_RES = $result->return;
            return $this;
        }
    }

    public function splitArr()
    {
        $res = simplexml_load_string($this->_RES);
        $res = $res->Body->RouteResponse;

        if ($res) {
            $i = 0;
            $res_arr = array();

            foreach ($res->Route as $item) {
                $res_arr[$i]['remark'] = (string)$item['remark'];
                $res_arr[$i]['accept_time'] = (string)$item['accept_time'];
                $res_arr[$i]['accept_address'] = (string)$item['accept_address'];
                $res_arr[$i]['opcode'] = (string)$item['opcode'];

                $i++;
            }
            return $res_arr;
        }
        return false;
    }

    public function View() {
        return $this->_RES;
    }

    public function webView() {
        $res = str_replace("<", "&lt", $this->_RES);
        $res = str_replace(">", "&gt", $res);
        $res = str_replace("'", "&quot;", $res);
        return $res;
    }

    public function readJSON() {
        header("Content-type: text/html; charset=utf-8");
        $res = array(
            "data" => $this->XML2Array($this->_RES)
        );

        $res = $this->LockCode($res);
        $res = json_encode($res);
        $res = urldecode($res);
        return $res;
    }

    private function LockCode($_Arrray){
        $Res_Array = array();
        foreach ($_Arrray as $K => $Dom) {
            if(is_array($Dom)){
                $Res_Array[$K] = $this->LockCode($Dom);
            }else{
                $Res_Array[$K] = urlencode($Dom);
            }
        }
        return $Res_Array;
    }


    private function XML2Array($xmltext) {
        $xml = new XMLReader();
        $xml->XML($xmltext);
        $assoc = $this->xml2assoc($xml);
        $xml->close();
        return $assoc;
    }

    private function xml2assoc($xml) {
        $tree = null;
        while ($xml->read()) {
            if ($xml->nodeType == XMLReader::END_ELEMENT) {
                return $tree;
            } else if ($xml->nodeType == XMLReader::ELEMENT) {
                $node = array();
                $node['tag'] = $xml->name;
                if ($xml->hasAttributes) {
                    $attributes = array();
                    while ($xml->moveToNextAttribute()) {
                        $attributes[$xml->name] = $xml->value;
                    }
                    $node['attr'] = $attributes;
                }
                if (!$xml->isEmptyElement) {
                    $childs = $this->xml2assoc($xml);
                    $node['childs'] = $childs;
                }
                $tree[] = $node;
            } else if ($xml->nodeType == XMLReader::TEXT) {
                $node = array();
                $node['text'] = $xml->value;
                $tree[] = $node;
            }
        }
        return $tree;
    }

}

?>
