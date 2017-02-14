<?php


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
function get_attr_title($id)
{
    return M('attribute')->where('id=' . intval($id))->getField('title');
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
function avatar($url)
{
    if (trim($url) == '') {
        return HOME_URL . '/' . 'assets/head.png';
    } else {
        return $url;
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
        imagecopyresampled($qrcode, $logo, $from_width, $from_width, 0, 0, $logo_qr_width,
            $logo_qr_height, $logo_width, $logo_height);
        imagepng($qrcode, $outfile);
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
function get_code($mobile, $code_style='reg', $expire=60)
{
    $map = array(
        'code_style' => $code_style,
        'telephone' => $mobile
    );

    $data = M('code_telephone')->where($map)->order('id DESC')->find();
    if ($data['create_time'] + $expire > time()) {
        $result = array('code' => 1, 'msg' => '请不要频繁获取验证码');
    }
    $url = U('Crontab/MsgQueue/getRegCode', '', true, true);
    $returnData = http_request($url, array('tel' => $mobile, 'style' => $code_style));
    return json_decode($returnData, true);
}

//function addMessengerQueue($type, $temp_arr, $user_arr, $msg_arr)
//{
//
//    $TypeDefined = array('sms' => '1', 'wechat' => '2', 'both' => '3');
//
//
//    if (array_key_exists($type, $TypeDefined)) {
//        $Model_Redis = new \Redis();
//        $Model_Redis->connect(C('REDIS_HOST'), C('REDIS_PORT'));
//        $Model_Redis->auth(C('REDIS_AUTH'));
//
//
//        $arr['lx'] = $TypeDefined[$type];
//        $arr['temp_arr'] = $temp_arr;
//        $arr['user_arr'] = $user_arr;
//        $arr['msg_arr'] = $msg_arr;
//        $arr['errortimes'] = 0;
//        $arr['create_time'] = time();
//
//        $string = json_encode($arr);
//        $Model_Redis->rPush(C('DB_PREFIX') . 'msg_queue', $string);
//
//    } else {
//        return false;
//    }
//
//
//}
