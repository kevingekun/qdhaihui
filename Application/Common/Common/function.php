<?php

/**
 * 网站数据统计
 * @param string $InArray
 * eg:
 */
function statistics($InArray = '')
{
    //array('openid'=>'','action'=>'','action_ext'=>'',);

    $Result = array();
    $Result['time'] = time();
    if ($InArray['openid']) {
        $Result['user'] = 'openid_' . $InArray['openid'];
    } elseif ($InArray['uid']) {
        $Result['user'] = $InArray['uid'];
    } else {
        $Result['user'] = 'guest';
    }

    $Result['referrer_url'] = $_SERVER['HTTP_REFERER'];
    $Result['now_url'] = $_SERVER['REQUEST_URI'];

    $Result['referer_action'] = '';
    $Result['ip'] = get_client_ip();


    $Result['action'] = $InArray['action'];
    switch ($InArray['action']) {
        case "submit_order":
            $Result['action_ext'] = $InArray['order_id'];
            break;
        case "show_good":
            $Result['action_ext'] = $InArray['good_id'];
            break;
        case "shared_to":
            $Result['action_ext'] = $InArray['shared_url'];
            break;
        case "click_shared":
            $Result['action_ext'] = $InArray['uid'];
            $Result['referer_action'] = 'click_shared';
            break;
        case "pay_start":
            $Result['action_ext'] = $InArray['order_id'];
            break;
        case "pay_success":
            $Result['action_ext'] = $InArray['order_id'];
            break;
        default:
            $Result['action_ext'] = isset($InArray['action_ext']) ? $InArray['action_ext'] : '';
    }

    $Result['_server'] = $_SERVER;

    $Model_Redis = new \Redis();
    $Model_Redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
    $Model_Redis->auth(C('REDIS_AUTH'));
    $Model_Redis->select('2');
    $Model_Redis->lpush(C('DB_PREFIX') . 'statistics_dataflow', json_encode($Result));
}

function getAddressDataArrayWithAddressID($_AddressID)
{
    if ($_AddressID == '') {
        return false;
    } else {
        $Model_MallAddress = M("MallAddress");
        $RowArray = $Model_MallAddress->find($_AddressID);
        if ($RowArray['region_id'] != '') {
            $RegionDataArray = get_region_row($RowArray['region_id']);
            $result = array_merge($RowArray, $RegionDataArray);
        } else {
            $result = $RowArray;
        }

        return $result;
    }
}

function getAttributeWithType($Type)
{
    $HashFlagKeyName = C("DB_PREFIX") . "attribute_" . $Type;
    if (S($HashFlagKeyName)) {
        return S($HashFlagKeyName);
    } else {
        $Model_Attribute = M("Attribute");
        $optionsWhere = array('type' => $Type, 'status' => '0');
        $CountIF = $Model_Attribute->where($optionsWhere)->Count();
        if ($CountIF == '1') {
            $TempData = $Model_Attribute->where($optionsWhere)->find();
            $ReturnArray = array('title' => $TempData['title'], 'value' => $TempData['value']);
        } elseif ($CountIF >= '2') {
            $TempData = $Model_Attribute->where($optionsWhere)->Order('sort DESC')->select();
            foreach ($TempData AS $key => $value) {
                $ReturnArray[$key] = array('title' => $value['title'], 'value' => ($value['value'] != '') ? $value['value'] : 'null');
            }
        } else {
            $ReturnArray = array();
        }
        S($HashFlagKeyName, $ReturnArray);
        return $ReturnArray;
    }
}

/**
 * 写入队列
 *
 * @param $lx 1-短信    2-微信    3-全部
 * @param $temp_arr     模板数组    'wehchat'=>'','msg'=>''
 * @param $user_arr     账号数组    'wehchat'=>'','msg'=>''
 * @param $msg_arr      消息数组    'wehchat'=>array(),'msg'=>array()
 *
 */
/*
    example:

    $queue_name='msg_queue';
    $uid  //用户ID 备用

    $lx="1";
    $temp_arr=array('msg'=>'reg_msg');
    $user_arr=array('msg'=>'13000000000');
    $msg_arr=array(
        'msg'=>array(
            'data'=>array(
                'verify_code'=>'1234'
            )
        )
    );

    $lx="2";
    $temp_arr=array('wechat'=>'TM00178');
    $user_arr=array('wechat'=>'o4Wwrt0ddMRHOjazgcxPjKgQ17BM');
    $msg_arr=array(
        'wechat'=>array(
            'url'=>'',
            'data'=>array(
                'first'=>array('value'=>'尊敬的客户'),
                'number'=>array('value'=>'1046'),
                'remark'=>array('value'=>'请在5分钟内输入')
            )
        )
    );

    $lx='3';
    $temp_arr=array('msg'=>'reg_msg','wechat'=>'TM00178');
    $user_arr=array('msg'=>'18660236954','wechat'=>'o4Wwrt0ddMRHOjazgcxPjKgQ17BM');

    $msg_arr=array(
        'msg'=>array(
            'data'=>array(
                'verify_code'=>'1234'
            )
        ),
        'wechat'=>array(
            'url'=>'',
            'data'=>array(
                'first'=>array('value'=>'尊敬的客户'),
                'number'=>array('value'=>'1046'),
                'remark'=>array('value'=>'请在5分钟内输入')
            )
        )
    );

*/

/**
 * @param $type     类型 (sms/wechat/both)
 * @param $temp_arr 模板数组
 * @param $user_arr 用户数组
 * @param $msg_arr  消息数组
 */
function addMessengerQueue($type, $temp_arr, $user_arr, $msg_arr)
{

    $TypeDefined = array('sms' => '1', 'wechat' => '2', 'both' => '3');


    if (array_key_exists($type, $TypeDefined)) {
        $Model_Redis = new \Redis();
        $Model_Redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
        $Model_Redis->auth(C('REDIS_AUTH'));


        $arr['lx'] = $TypeDefined[$type];
        $arr['temp_arr'] = $temp_arr;
        $arr['user_arr'] = $user_arr;
        $arr['msg_arr'] = $msg_arr;
        $arr['errortimes'] = 0;
        $arr['create_time'] = time();

        $string = json_encode($arr);
        $Model_Redis->rPush(C('DB_PREFIX') . 'msg_queue', $string);

    } else {
        return false;
    }


}

/**
 * 按输入条件返回三级地址表row行数据.
 * @param string InputString(Auto analy ID OR Chinese)
 * @param string LimitField(region_id/province_code.....)
 * @return bool
 */
function get_region_row($_String, $_Field = '')
{
    if (trim($_Field) != '' AND in_array(trim($_Field), array('region_id', 'province_code', 'province_name', 'city_code', 'city_name', 'district_code', 'district_name', 'region_type', 'district_type', 'warehouse_name', 'warehouse_code'))) {
        switch (trim($_Field)) {
            case "province_code":
                $optionsWhere['region_type'] = '1';
                break;
            case "city_code":
                $optionsWhere['region_type'] = '2';
                break;
            case "district_code":
                $optionsWhere['region_type'] = '3';
                break;
        }
        $optionsWhere[trim($_Field)] = trim($_String);
    } else {
        if (is_numeric(trim($_String))) {
            $optionsWhere['region_id|province_code|city_code|district_code'] = intval(trim($_String));
        } else {
            $optionsWhere['province_name|city_name|district_name|warehouse_name|warehouse_code'] = intval(trim($_String));
        }
    }

    $Model_EcpBaseRegion = M("EcpBaseRegion");
    return $Model_EcpBaseRegion->where($optionsWhere)->find();

}

/**
 * 生成配置文件, 如: 合伙人规则, 激励规则之类的
 * @param $config
 * @param string $config_file
 * @return bool
 */
function update_config($config, $config_file = '')
{
    !is_file($config_file) && $config_file = CONF_PATH . 'partner.php';
    if (is_writable($config_file)) {
        file_put_contents($config_file, "<?php \nreturn " . stripslashes(var_export($config, true)) . ";", LOCK_EX);
        @unlink(RUNTIME_PATH);
        return true;
    } else {
        return false;
    }
}

/**
 * 根据id 获取attribute的title
 * @param $id
 * @return mixed
 */
function get_attr_title($id, $field = 'title')
{
    return M('attribute')->where('id=' . intval($id))->getField($field);
}

/**
 * 更具type 获取attribute
 * @param $type
 * @param int $status
 * @param string $order
 * @return array
 */
function get_attribute($type, $status = 0, $order = 'sort DESC, id ASC')
{
    $attributes = M('attribute')->where(array('type' => $type, 'status' => $status))->order($order)->select();
    return $attributes ? $attributes : array();
}

/**
 * 金钱转换
 * @param $money
 * @param int $divisor
 * @return float
 */
function convert_money($money, $char = '/', $divisor = 100)
{
    switch ($char) {
        case '/':
            return floatval($money / $divisor);
            break;
        case '*':
            return floatval($money * $divisor);
            break;
        default:
            return floatval($money / $divisor);
    }
}

/**
 * 日期格式化
 * @param $date 日期
 * @param string $format
 * @return bool|string
 */
function format_date($date, $format = 'Y-m-d')
{
    if ($date < 1)
        return '';
    return date($format, $date);
}

/**
 * 密码加密方式
 * @param $password 输入密码
 * @param $salt 随机4位
 * @return string
 */
function encrypt($password, $salt)
{
    return md5($salt . md5($password . $salt));
}

/**
 * 检测验证码
 * @param $code 输入的验证码
 * @param string $id 验证码标识,多个验证码时可用
 * @return bool 用户验证码 true or false
 */
function verify_check($code, $id = '')
{
    // 实例化验证码类
    $verify = new \Think\Verify();
    return $verify->check($code, $id);
}

/**
 * 递归重组节点信息为多维数组
 * @param $node
 * @param null $access
 * @param string $pid
 * @return array
 */
function node_merge($node, $access = null, $pid = '0')
{
    $arr = array();

    foreach ($node as $v) {
        if (is_array($access)) {
            $v['access'] = in_array($v['id'], $access) ? 1 : 0;
        }
        if ($v['pid'] == $pid) {
            $v['child'] = node_merge($node, $access, $v['id']);
            $arr[] = $v;
        }
    }
    return $arr;
}

/**
 * 头像
 * @param $url
 */
function avatar($url, $size = '132')
{
    if (trim($url) == '') {
        return HOME_URL . '/' . 'assets/head.png';
    } else {
        $url = substr($url, 0, strlen($url) - 1);
        return $url . $size;
    }
}

/**
 * 把返回的数据集转换成Tree
 * @access public
 * @param array $list 要转换的数据集
 * @param array $pk 主键
 * @param string $pid parent标记字段
 * @param string $child 子数组索引
 * @param string $level 开始层级
 * @return array
 */
function list_to_tree($list, $pk = 'id', $pid = 'pid', $child = '_child', $level = 0)
{
    $tree = array();
    if (is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] =& $list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId = $data[$pid];
            if ($level == $parentId) {
                $tree[] =& $list[$key];
            } else {
                if (isset($refer[$parentId])) {
                    $parent =& $refer[$parentId];
                    $parent[$child][] =& $list[$key];
                }
            }
        }
    }
    return $tree;
}

/**
 * 对查询结果集进行排序
 * @access public
 * @param array $list 查询结果
 * @param string $field 排序的字段名
 * @param array $sortby 排序类型
 * asc正向排序 desc逆向排序 nat自然排序
 * @return array
 */
function list_sort_by($list, $field, $sortby = 'asc')
{
    if (is_array($list)) {
        $refer = $resultSet = array();
        foreach ($list as $i => $data)
            $refer[$i] = &$data[$field];
        switch ($sortby) {
            case 'asc': // 正向排序
                asort($refer);
                break;
            case 'desc':// 逆向排序
                arsort($refer);
                break;
            case 'nat': // 自然排序
                natcasesort($refer);
                break;
        }
        foreach ($refer as $key => $val)
            $resultSet[] = &$list[$key];
        return $resultSet;
    }
    return false;
}

/**
 * 在数据列表中搜索
 * @access public
 * @param array $list 数据列表
 * @param mixed $condition 查询条件
 * 支持 array('name'=>$value) 或者 name=$value
 * @return array
 */
function list_search($list, $condition)
{
    if (is_string($condition))
        parse_str($condition, $condition);
    // 返回的结果集合
    $resultSet = array();
    foreach ($list as $key => $data) {
        $find = false;
        foreach ($condition as $field => $value) {
            if (isset($data[$field])) {
                if (0 === strpos($value, '/')) {
                    $find = preg_match($value, $data[$field]);
                } elseif ($data[$field] == $value) {
                    $find = true;
                }
            }
        }
        if ($find)
            $resultSet[] =   &$list[$key];
    }
    return $resultSet;
}


function image_create_corners($sourceImageFile, $radius)
{
    # test source image
    if (file_exists($sourceImageFile)) {
        $res = is_array($info = getimagesize($sourceImageFile));
    } else $res = false;

    # open image
    if ($res) {
        $w = $info[0];
        $h = $info[1];
        switch ($info['mime']) {
            case 'image/jpeg':
                $src = imagecreatefromjpeg($sourceImageFile);
                break;
            case 'image/gif':
                $src = imagecreatefromgif($sourceImageFile);
                break;
            case 'image/png':
                $src = imagecreatefrompng($sourceImageFile);
                break;
            default:
                $res = false;
        }
    }

    # create corners
    if ($res) {

        $q = 10; # change this if you want
        $radius *= $q;

        # find unique color
        do {
            $r = rand(0, 255);
            $g = rand(0, 255);
            $b = rand(0, 255);
        } while (imagecolorexact($src, $r, $g, $b) < 0);

        $nw = $w * $q;
        $nh = $h * $q;

        $img = imagecreatetruecolor($nw, $nh);
        $alphacolor = imagecolorallocatealpha($img, $r, $g, $b, 127);
        imagealphablending($img, false);
        imagesavealpha($img, true);
        imagefilledrectangle($img, 0, 0, $nw, $nh, $alphacolor);

        imagefill($img, 0, 0, $alphacolor);
        imagecopyresampled($img, $src, 0, 0, 0, 0, $nw, $nh, $w, $h);

        imagearc($img, $radius - 1, $radius - 1, $radius * 2, $radius * 2, 180, 270, $alphacolor);
        imagefilltoborder($img, 0, 0, $alphacolor, $alphacolor);
        imagearc($img, $nw - $radius, $radius - 1, $radius * 2, $radius * 2, 270, 0, $alphacolor);
        imagefilltoborder($img, $nw - 1, 0, $alphacolor, $alphacolor);
        imagearc($img, $radius - 1, $nh - $radius, $radius * 2, $radius * 2, 90, 180, $alphacolor);
        imagefilltoborder($img, 0, $nh - 1, $alphacolor, $alphacolor);
        imagearc($img, $nw - $radius, $nh - $radius, $radius * 2, $radius * 2, 0, 90, $alphacolor);
        imagefilltoborder($img, $nw - 1, $nh - 1, $alphacolor, $alphacolor);
        imagealphablending($img, true);
        imagecolortransparent($img, $alphacolor);

        # resize image down
        $dest = imagecreatetruecolor($w, $h);
        imagealphablending($dest, false);
        imagesavealpha($dest, true);
        imagefilledrectangle($dest, 0, 0, $w, $h, $alphacolor);
        imagecopyresampled($dest, $img, 0, 0, 0, 0, $w, $h, $nw, $nh);

        # output image
        $res = $dest;
        imagedestroy($src);
        imagedestroy($img);
    }

    return $res;
}


/**
 * 生成二维码
 * @param string $text 内容
 * @param bool|false $outfile false-不生成文件, 或填写文件路径生成对应文件
 * @param string $logo false-不带logo, 填写logo路径, 生成带logo的二维码, 并返回二维码路径
 * @param int $level 容错率，L（QR_ECLEVEL_L，7%），M（QR_ECLEVEL_M，15%），Q（QR_ECLEVEL_Q，25%），H（QR_ECLEVEL_H，30%）；
 * @param int $size 生成图片大小；
 * @param int $margin 二维码周围边框空白区域间距值
 * @param bool|false $saveandprint 是否保存二维码并显示
 */
function qrcode($text, $outfile = false, $logo = false, $level = 'M', $size = 10, $margin = 1, $saveandprint = false)
{
    Vendor('phpqrcode.phpqrcode');
    QRcode::png($text, $outfile, $level, $size, $margin, $saveandprint);

    if ($logo !== false) {
        $logoPath = dirname($logo) . '/';
        imagepng(image_create_corners($logo, 20), $logo);
        $thumb = new \Org\Util\Easyphpthumbnail();
        $thumb->Thumbsize = 150;
        //$thumb->Framewidth = 7;
        $thumb->Thumblocation = $logoPath;
        $thumb->Borderpng = ROOT_PATH . DIRECTORY_SEPARATOR . 'assets' . DIRECTORY_SEPARATOR . 'border.png';
        $thumb->Createthumb($logo, 'file');
        imagepng(image_create_corners($logo, 20), $logo);

//        $outfilePath = dirname($outfile) . '/';
//        $thumb2 = new \Org\Util\Easyphpthumbnail();
//        $thumb2->Thumbsize = 350;
//        $thumb2->Watermarkpng = $logo;
//        $thumb2->Watermarkposition = '50% 50%';
//        $thumb2->Watermarktransparency = 100;
//        $thumb2->Thumblocation = $outfilePath;
//        $thumb2->Createthumb($outfile, 'file');

        $qrcode = imagecreatefromstring(file_get_contents($outfile));
        $logo = imagecreatefromstring(file_get_contents($logo));
        $QR_width = imagesx($qrcode);//二维码图片宽度
        $QR_height = imagesy($qrcode);//二维码图片高度
        $logo_width = imagesx($logo);//logo图片宽度
        $logo_height = imagesy($logo);//logo图片高度
        $logo_qr_width = $QR_width / 5;
        $scale = $logo_width / $logo_qr_width;
        $logo_qr_height = $logo_height / $scale;
        $from_width = ($QR_width - $logo_qr_width) / 2;
        //重新组合图片并调整大小
        imagecopyresampled($qrcode, $logo, $from_width, $from_width, 0, 0, $logo_qr_width, $logo_qr_height, $logo_width, $logo_height);
        imagejpeg($qrcode, $outfile, 100);
        return $outfile;
    }
}

/**
 * 递归创建多级目录
 * @param $dir
 * @return bool
 */
function mkdirs($dir)
{
    if (!is_dir($dir)) {
        if (!mkdirs(dirname($dir))) {
            return false;
        }
        if (!mkdir($dir, 0777)) {
            return false;
        }
    }
    return true;
}

/**
 * CURL  模拟http请求
 * @param $url
 * @param $params
 * @param int $timeout
 * @return mixed
 * @throws Exception
 */
function http_request($url, $params, $timeout = 0)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FAILONERROR, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);

    if (is_array($params) && sizeof($params) > 0) {
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
    }
    $response = curl_exec($ch);
    if (curl_errno($ch)) {
        throw new Exception(curl_error($ch), 0);
    }
    curl_close($ch);
    return $response;
}

/**
 * encode处理参数
 * @param $str
 * @return mixed
 */
function base_encode($str)
{
    $src = array('/', '+', '=', '.', ':');
    $dist = array('_aa_', '_bb_', '_cc_', '_dd_', '_ee_');
    $new = str_replace($src, $dist, $str);
    return $new;
}

/**
 * decode处理参数
 * @param $str
 * @return mixed
 */
function base_decode($str)
{
    $src = array('_aa_', '_bb_', '_cc_', '_dd_', '_ee_');
    $dist = array('/', '+', '=', '.', ':');
    $new = str_replace($src, $dist, $str);
    return $new;
}

/**
 * 获取当前URL
 * @return string
 */
function get_self_url($params = array(), $url = '')
{
    $secure = isset($_SERVER['HTTPS']) && (strcasecmp($_SERVER['HTTPS'], 'on') === 0 || $_SERVER['HTTPS'] == 1) || isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strcasecmp($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') === 0;
    $hostInfo = '';
    if ($secure) {
        $http = 'https';
    } else {
        $http = 'http';
    }
    if (isset($_SERVER['HTTP_HOST'])) {
        $hostInfo = $http . '://' . $_SERVER['HTTP_HOST'];
    } else {
        $hostInfo = $http . '://' . $_SERVER['SERVER_NAME'];
        if ($secure) {
            $port = isset($_SERVER['SERVER_PORT']) ? (int)$_SERVER['SERVER_PORT'] : 443;
        } else {
            $port = isset($_SERVER['SERVER_PORT']) ? (int)$_SERVER['SERVER_PORT'] : 80;
        }
        if (($port !== 80 && !$secure) || ($port !== 443 && $secure)) {
            $hostInfo .= ':' . $port;
        }
    }
    $requestUri = '';
    if (isset($_SERVER['HTTP_X_REWRITE_URL'])) {// IIS
        $requestUri = $_SERVER['HTTP_X_REWRITE_URL'];
    } elseif (isset($_SERVER['REQUEST_URI'])) {
        $requestUri = $_SERVER['REQUEST_URI'];
        if (!empty($_SERVER['HTTP_HOST'])) {
            if (strpos($requestUri, $_SERVER['HTTP_HOST']) !== false) {
                $requestUri = preg_replace('/^\w+:\/\/[^\/]+/', '', $requestUri);
            }
        } else {
            $requestUri = preg_replace('/^(http|https):\/\/[^\/]+/i', '', $requestUri);
        }
    } elseif (isset($_SERVER['ORIG_PATH_INFO'])) { // IIS 5.0 CGI
        $requestUri = $_SERVER['ORIG_PATH_INFO'];
        if (!empty($_SERVER['QUERY_STRING'])) {
            $requestUri .= '?' . $_SERVER['QUERY_STRING'];
        }
    } else {
        exit('没有获取到当前的url');
    }
    if (empty($url)) {
        $url = $hostInfo . $requestUri;
    }
    $parseUrl = parse_url($url);
    parse_str(htmlspecialchars_decode($parseUrl['query']), $query);
    foreach ($params as $key => $param) {
        $value = isset($query[$param]) ? $query[$param] : '';
        if (1 == count($query)) {
            $value = '\?' . $param . '=' . $value;
        } else {
            $value = '&' . $param . '=' . $value . '|' . $param . '=' . $value . '&';
        }
        $url = preg_replace("/$value/i", '', $url);
    }
    return $url;
}

/**
 * xml转换为数组
 * @param $xml
 * @return mixed
 */
function xml_to_array($xml)
{
    $reg = "/<(\w+)[^>]*>([\\x00-\\xFF]*)<\\/\\1>/";
    if (preg_match_all($reg, $xml, $matches)) {
        $count = count($matches[0]);
        for ($i = 0; $i < $count; $i++) {
            $subxml = $matches[2][$i];
            $key = $matches[1][$i];
            if (preg_match($reg, $subxml)) {
                $arr[$key] = xml_to_array($subxml);
            } else {
                $arr[$key] = $subxml;
            }
        }
    }
    return $arr;
}

/**
 * 将null处理成 ''
 * @param $v
 * @return string
 */
function null_to_blank($v)
{
    if ($v === null) {
        return $v = '';
    } else {
        return $v;
    }
}

/**
 * 生成验证码
 * @param int $length 验证码长度
 * @param int $numeric 1-纯数字  0-数字字母组合
 * @return string
 */
function random($length = 6, $numeric = 0)
{
    PHP_VERSION < '4.2.0' && mt_srand((double)microtime() * 1000000);
    if ($numeric) {
        $hash = sprintf('%0' . $length . 'd', mt_rand(0, pow(10, $length) - 1));
    } else {
        $hash = '';
        $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789abcdefghjkmnpqrstuvwxyz';
        $max = strlen($chars) - 1;
        for ($i = 0; $i < $length; $i++) {
            $hash .= $chars[mt_rand(0, $max)];
        }
    }
    return $hash;
}

/**
 * 通过产品分类ID快速获取分类名
 * @param $id   产品分类ID
 * @return mixed
 */
function getclassname($id)
{
    $class = M("mall_menu");
    $where['id'] = $id;
    $classname = $class->where($where)->getField('name');
    return $classname;
}

/**
 * 请求获取验证码
 * @param $mobile 手机号
 * @param string $code_style 标识, 比如:注册用reg, 根据业务名称来定(注意不要与其他业务用的搞重了)
 * @param int $expire 此时间后才能重新请求
 * @throws Exception
 * @return array('code'=>1, 'msg'=>'验证码请求频繁')
 */
function get_code($mobile, $code_style = 'reg', $expire = 60)
{
    $map = array(
        'code_style' => $code_style,
        'telephone' => $mobile
    );

    $data = M('code_telephone')->where($map)->order('id DESC')->find();
    if ($data['create_time'] + $expire > time()) {
        $result = array('code' => 1, 'msg' => '请不要频繁获取验证码');
    }
    $url = U('Api/Message/getRegCode', '', true, true);
    $returnData = http_request($url, array('tel' => $mobile, 'style' => $code_style));
    return json_decode($returnData, true);
}

/**
 * 查询所有商品分类
 * @return array 二维数组
 */
function findMenu()
{
    // 查询所有商品分类 重组二维数组
    $menu = M('mall_menu')->select();
    return node_merge($menu);
}

/**
 * 获取商品分组名称
 * @param $value 分组id
 * @return mixed 分组名称
 */
function get_group_name($value)
{
    $map = array(
        'type' => 'goods_group',
        'value' => $value,
        'status' => 0
    );

    return M('attribute')->where($map)->getField('title');
}

/**
 * 获取发票信息
 * @param $order_num  订单编号
 * @param $info_name  字段名
 * @return mixed      返回值
 */
function get_invoice_info($order_num, $info_name)
{

    $result = M('mall_invoice')->where(array('order_id' => $order_num))->getField($info_name);
    if (empty($result)) {

        $result = '未填写';
    }
    return $result;
}

/**
 * 生成唯一订单号
 * @return string
 */
function create_order_number()
{
    return 'P' . date('ymdHis') . sprintf('%02d', rand(111, 999));
}

/**
 * 生成商品唯一订单号
 * @return string
 */
function create_good_number()
{
    return 'G' . date('ymdHis') . sprintf('%02d', rand(111, 999));
}

/**
 * 获取管理用户信息
 * @param $adminId
 * @param string $field
 * @return bool|mixed
 */
function get_admin_user($adminId, $field = '')
{
    if (!$field) {
        return M('auth_user')->where('user_id=' . $adminId)->find();
    }
    if (is_string($field)) {
        return M('auth_user')->where('user_id=' . $adminId)->getField($field);
    }
    return false;
}

/**
 * 获取单个商品标题
 */
function get_goods_name($goods_id)
{
    return M('mall_good')->where(array('sku_id' => $goods_id))->getField('name');
}

/**
 * 用户性别
 * @param $sex
 * @return string
 */
function gender($sex)
{
    $sex = intval($sex);
    switch ($sex) {
        case 1:
            return '男';
            break;
        case 2:
            return '女';
            break;
        default:
            return '未知';
    }
}

/**
 * 获取优惠券信息
 */
function get_coupon_info($id, $field = 'coupon_name,money_cut')
{
    return M('mall_coupon')->field($field)->find($id);
}

/**
 * 二维数组 降维去重
 */
function array_unique_fb($array2D)
{
    foreach ($array2D as $v) {
        $v = serialize($v); //降维,将一维数组转换为序列化数据
        $temp[] = $v;
    }

    $temp = array_unique($temp);    //去掉重复的字符串,也就是重复的一维数组

    foreach ($temp as $k => $v) {
        $temp[$k] = unserialize($v);   //再将拆开的数组重新组装
    }
    return $temp;
}

/**
 * 根据订单编号 区分活动订单 和 普通订单
 * @param $order_number
 * @return float
 */
function get_seckill_orders_mark($order_number)
{
    $model = M('mall_order');
    $info = $model->where(array('order_number' => $order_number))->find();

    if ($info && $info['action_id']) {
        $action_info = M('activity_seckill_action')->where('action_id=' . $info['action_id'])->find();
        if ($action_info) {
            return convert_money($action_info['seckill_price']);
        } else {
            return false;
        }
    }
}

/**
 * 逐行读取csv内容
 * @param $filename
 * @return array|bool
 */
function get_csv_content($filename)
{
    if (file_exists($filename)) {
        setlocale(LC_ALL,array('zh_CN.gbk','zh_CN.gb2312','zh_CN.gb18030'));
        $handle = fopen($filename, 'r');
        $newData = array();
        $n = 0;
        while ($data = fgetcsv($handle)) {
            $count = count($data);
            for ($i = 0; $i < $count; $i++) {
                $newData[$n][$i] = mb_convert_encoding($data[$i], 'UTF-8', 'GBK');
            }
            $n++;
        }
        fclose($handle);
        return $newData;
    } else {
        return false;
    }
}

/**
 * 系统操作日志记录到操作日志表 hx_operate_log (操作: insert, update, delete)
 * @param int $tableId 记录的主键id
 * @param string $tableName 表名
 * @param int $type 操作类型, 1-insert, 2-update, 3-delete
 */
function operate_log($tableId, $tableName, $type = 1)
{
    $tableId = intval($tableId);
    $rs = M($tableName)->find($tableId);
    $data = array(
        'table_id' => $tableId,
        'table_name' => $tableName,
        'admin_uid' => session('admin_uid'),
        'type' => $type,
        'content' => json_encode($rs),
        'create_time' => date('Y-m-d H:i:s', time())
    );
    M('operate_log')->add($data);
}

/**
 * 写入文件
 * @param $filename 文件名称
 * @param $data 要写入的内容
 * @param $path 文件路径
 * @return mixed bool
 */
function FF($filename, $data, $path)
{
    return \Think\Storage::put(
        $path . $filename .'.php',
        '<?php' . "\n" . 'return '.var_export($data,true).';',
        'F');
}


