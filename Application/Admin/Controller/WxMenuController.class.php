<?php
namespace Admin\Controller;

use Com\Wechat\TPWechat;
use Common\Controller\AdminController;

class WxMenuController extends AdminController
{

  	public $thisWxUser;
	public $access_token;
	public $wechat;
	public $_appid;
	public $_appsecret;

	public function _initialize() {
		parent::_initialize();

		$this->_appid 		= C('APP_ID');
		$this->_appsecret	= C('APP_SECRET');
		
	}

	//自定义菜单配置
	public function index(){

		if(IS_POST){

		}else{
			$class=M('wxmenu_class')->where(array('pid'=>0))->order('sort desc, id ASC')->select();//dump($class);
			$i=0;
			$count = 3;
			foreach($class as $key=>$vo){
				if ($vo['is_show']) {
					$i++;
					$count = 4 < $i ? 4 : $i;
					$displayMenu[] = $vo;
				}
				$c=M('wxmenu_class')->where(array('pid'=>$vo['id']))->order('sort desc, id ASC')->select();
				$class[$key]['class']=$c;
				foreach ($c as $k => $v) {
					if ($v['is_show'] && $vo['is_show']) {
						$displayMenu[$i-1]['class'][] = $v;
					}
					
				}
			}

			$this->assign('class',$class);
			
			
			$this->assign('wxsys', $this->_get_sys());
			$this->assign('displayMenu', $displayMenu);
			$this->assign('count', $count);
			$this->display();
		}
	}

	public function  class_add(){
		if(IS_POST){
			if ($_POST['menu_type']==2 && $_POST['url'] != '') {
				if ($this->dwzQuery(array('tinyurl' => $_POST['url']))) {
					$this->error('禁止使用短网址');
				}
				$_POST['url'] = $this->replaceUrl($_POST['url'], array('query'=>array('wecha_id'=>'{wechat_id}')));
			}
			// 2015-05-20 处理新增时会有多个值的 BUG 
			$type = array('1'=>'keyword', '2'=>'url', '3'=>'wxsys', '4'=>'tel', '5'=>array('longitude', 'latitude'));
			foreach ($type as $key => $value) {
				if ($_POST['menu_type'] != $key) {
					if (is_array($value)) {
						foreach ($value as $v) {
							unset($_POST[$v]);
						}
					} else {
						unset($_POST[$value]);
					}
				}
			}
			$this->all_insert('wxmenu_class','/WxMenu/index');
		}else{
			$class=M('wxmenu_class')->where(array('pid'=>0))->order('sort desc')->select();

			$this->assign('class',$class);
			$this->assign('wxsys',$this->_get_sys());
			$this->display();
		}
	}
	public function  class_del(){
		$class=M('wxmenu_class')->where(array('pid'=>$this->_get('id')))->order('sort desc')->find();
		//echo M('Diymen_class')->getLastSql();exit;
		if($class==false){
			$back=M('wxmenu_class')->where(array('id'=>$this->_get('id')))->delete();
			if($back==true){
				$this->success('删除成功', U('WxMenu/index'));
			}else{
				$this->error('删除失败');
			}
		}else{
			$class2=M('wxmenu_class')->where(array('id'=>$this->_get('id')))->order('sort desc')->find();
			if (0 != $class2['pid']) {
				$back=M('wxmenu_class')->where(array('pid'=>$this->_get('id')))->delete();
				$back2=M('wxmenu_class')->where(array('id'=>$this->_get('id')))->delete();
				if($back==true && $back2 == true){
					$this->success('删除成功', U('WxMenu/index'));
				}else{
					$this->error('删除失败');
				}
			} else {
				$this->error('请先删除子菜单');
			}
		}

	}
	
	public function  class_edit(){
		$this->assign('wxsys',$this->_get_sys());
		if(IS_POST){
			$_POST['id']=$this->_get('id');
			if($_POST['menu_type']==1 && $_POST['keyword'] != ''){
				$set = array('url'=>'','wxsys'=>'', 'tel'=>'', 'nav'=>'');
				unset($_POST['wxsys']);
				unset($_POST['url']);
				unset($_POST['tel']);
				unset($_POST['longitude']);
				unset($_POST['latitude']);
			}else if($_POST['menu_type']==2 && $_POST['url'] != ''){
				if ($this->dwzQuery(array('tinyurl' => $_POST['url']))) {
					$this->error('禁止使用短网址');
				}
				$_POST['url'] = $this->replaceUrl($_POST['url'], array('query'=>array('wecha_id'=>'{wechat_id}')));
				$set = array('keyword'=>'','wxsys'=>'', 'tel'=>'', 'nav'=>'');
				unset($_POST['keyword']);
				unset($_POST['wxsys']);
				unset($_POST['tel']);
				unset($_POST['longitude']);
				unset($_POST['latitude']);
			}else if($_POST['menu_type']==3 && $_POST['wxsys'] != ''){
				$set = array('keyword'=>'','url'=>'', 'tel'=>'', 'nav'=>'');
				unset($_POST['keyword']);
				unset($_POST['url']);
				unset($_POST['tel']);
				unset($_POST['longitude']);
				unset($_POST['latitude']);
			}else if($_POST['menu_type']==4 && $_POST['tel'] != ''){
				$set = array('keyword'=>'','url'=>'','wxsys'=>'', 'nav'=>'');
				unset($_POST['keyword']);
				unset($_POST['url']);
				unset($_POST['wxsys']);
				unset($_POST['longitude']);
				unset($_POST['latitude']);
			}else if($_POST['menu_type']==5 && $_POST['longitude'] != '' && $_POST['latitude'] != ''){
				$set = array('keyword'=>'','url'=>'','wxsys'=>'', 'tel'=>'');
				unset($_POST['keyword']);
				unset($_POST['url']);
				unset($_POST['wxsys']);
				unset($_POST['tel']);
			}

			M('wxmenu_class')->where(array('id'=>$_POST['id']))->save($set);
			$this->all_save('wxmenu_class','/WxMenu/index');
		}else{
			$data=M('wxmenu_class')->where(array('id'=>$this->_get('id')))->find();
			if($data==false){
				$this->error('您所操作的数据对象不存在！');
			}
			$class=M('wxmenu_class')->where(array('pid'=>0))->order('sort desc')->select();//dump($class);
			if($data['keyword'] != ''){
				$type = 1;
			}elseif($data['url'] != ''){
				$type = 2;
			}elseif($data['wxsys'] != ''){
				$type = 3;
			}elseif($data['tel'] != ''){
				$type = 4;
			}elseif($data['nav'] != ''){
				$type = 5;
				list($data['longitude'], $data['latitude']) = explode(',', $data['nav']);
			}
			$class2=M('wxmenu_class')->where(array('pid'=>$this->_get('id')))->order('sort desc')->find();
			foreach ($class as $key => $value) {
				if ($this->_get('id') == $value['id']) {
					unset($class[$key]);
				}
			} 
			if (0 != $data['pid'] || $class2 == false) {
				$this->assign('class',$class);
			}
			$this->assign('show',$data);
			$this->assign('type',$type);
			$json['html'] = $this->fetch();
			$json['status'] = 200;
			$json['url'] = U('WxMenu/class_edit', array('id'=>$this->_get('id')));
			exit(json_encode($json));
		}
	}

	function _get_sys($type='',$key=''){
		$wxsys 	= array(
				'扫码带提示',
				'扫码推事件',
				'系统拍照发图',
				'拍照或者相册发图',
				'微信相册发图',
				'发送位置',
		);

		if($type == 'send'){
			$wxsys 	= array(
					'扫码带提示'=>'scancode_waitmsg',
					'扫码推事件'=>'scancode_push',
					'系统拍照发图'=>'pic_sysphoto',
					'拍照或者相册发图'=>'pic_photo_or_album',
					'微信相册发图'=>'pic_weixin',
					'发送位置'=>'location_select',
			);
			return $wxsys[$key];
			exit;
		}
		return $wxsys;
	}

	public function  class_send(){
		if(IS_GET){
			// 2015-05-25 需要填写保存后才能生成 修复托管用户获取不到 access_token的BUG
			$options = array(
				'appid' => $this->_appid,
				'appsecret' => $this->_appsecret,
			);
			$this->wechat = new TPWechat($options);
			$this->access_token=$this->wechat->checkAuth();


			$data = '{"button":[';

			$class=M('wxmenu_class')->where(array('pid'=>0,'is_show'=>1))->limit(3)->order('sort DESC, id ASC')->select();//dump($class);
			$kcount = count($class);
			$k=1;

			foreach($class as $key=>$vo){
				//主菜单
				$data.='{"name":"'.$vo['title'].'",';
				$c=M('wxmenu_class')->where(array('pid'=>$vo['id'],'is_show'=>1))->limit(5)->order('sort DESC, id ASC')->select();
				$count = count($c);
				//子菜单
				$vo['url']=$this->convertLink($vo['url']);
				// 2015-05-11   一键拔号 
				$tel=$this->convertLink('{siteUrl}'.U('Wap/Index/tel', array('tel'=>$vo['tel'], 'token'=>session('token'))));
				// 2015-05-20 一键导航
				$amap=$this->convertLink('{siteUrl}'.U('Wap/Index/map', array('nav'=>$vo['nav'], 'name'=>$vo['title'], 'token'=>session('token'))));
				if($c!=false){
					$data.='"sub_button":[';
				}else{
					if($vo['keyword']){
						$data.='"type":"click","key":"'.$vo['keyword'].'"';
					}else if($vo['url']){
						$data.='"type":"view","url":"'.$vo['url'].'"';
					}else if($vo['wxsys']){
						$data.='"type":"'.$this->_get_sys('send',$vo['wxsys']).'","key":"'.$vo['wxsys'].'"';
					}else if($vo['tel']){
						$data.='"type":"view","url":"'.$tel.'"';
					}else if($vo['nav']){
						$data.='"type":"view","url":"'.$amap.'"';
					}
				}

				$i=1;
				foreach($c as $voo){
					$voo['url']=$this->convertLink($voo['url']);
					// 2015-05-11   一键拔号 
					$tel=$this->convertLink($this->siteUrl.U('Wap/Index/tel', array('tel'=>$voo['tel'], 'token'=>session('token'))));
					// 2015-05-20 一键导航
					$amap=$this->convertLink('{siteUrl}'.U('Wap/Index/map', array('nav'=>$voo['nav'], 'name'=>$voo['title'], 'token'=>session('token'))));
					if($i==$count){
						if($voo['keyword']){
							$data.='{"type":"click","name":"'.$voo['title'].'","key":"'.$voo['keyword'].'"}';
						}else if($voo['url']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$voo['url'].'"}';
						}else if($voo['wxsys']){
							$data.='{"type":"'.$this->_get_sys('send',$voo['wxsys']).'","name":"'.$voo['title'].'","key":"'.$voo['wxsys'].'"}';
						}else if($voo['tel']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$tel.'"}';
						}else if($voo['nav']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$amap.'"}';
						}
					}else{
						if($voo['keyword']){
							$data.='{"type":"click","name":"'.$voo['title'].'","key":"'.$voo['keyword'].'"},';
						}else if($voo['url']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$voo['url'].'"},';
						}else if($voo['wxsys']){
							$data.='{"type":"'.$this->_get_sys('send',$voo['wxsys']).'","name":"'.$voo['title'].'","key":"'.$voo['wxsys'].'"},';
						}else if($voo['tel']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$tel.'"},';
						}else if($voo['nav']){
							$data.='{"type":"view","name":"'.$voo['title'].'","url":"'.$amap.'"},';
						}
					}
					$i++;
				}
				if($c!=false){
					$data.=']';
				}

				if($k==$kcount){
					$data.='}';
				}else{
					$data.='},';
				}
				$k++;
			}
			$data.=']}';

			file_get_contents('https://api.weixin.qq.com/cgi-bin/menu/delete?access_token='.$this->access_token);
			$url='https://api.weixin.qq.com/cgi-bin/menu/create?access_token='.$this->access_token;
			$rt=$this->api_notice_increment($url,$data);

			if($rt['rt']==false){
				$errmsg=$this->wx_error_msg($rt['errorno']);
				$this->error($rt['errorno'].':'.$errmsg.'!');
			}else{
				$this->success('生成菜单成功');
			}
			exit;
		}else{
			$this->error('非法操作');
		}
	}

	function api_notice_increment($url, $data){
		$ch = curl_init();
		$header = "Accept-Charset: utf-8";
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
		curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$tmpInfo = curl_exec($ch);
		$errorno=curl_errno($ch);
		if ($errorno) {
			return array('rt'=>false,'errorno'=>$errorno);
		}else{
			$js=json_decode($tmpInfo,1);
			if ($js['errcode']=='0'){
				return array('rt'=>true,'errorno'=>0);
			}else {
				$errmsg=$this->wx_error_msg($js['errcode']);
				$this->error($js['errcode'].':'.$errmsg.'!!');
			}
		}
	}
	function curlGet($url){
		$ch = curl_init();
		$header = "Accept-Charset: utf-8";
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
		curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$temp = curl_exec($ch);
		return $temp;
	}

	protected function all_insert($name = '', $back = '/index')
    {
        $name = $name ? $name : MODULE_NAME;
        $db = D($name);
        if ($db->create() === false) {
            $this->error($db->getError());
        } else {
            $id = $db->add();
            if ($id) {
                $m_arr = array('Img', 'Text', 'Voiceresponse', 'Ordering', 'Lottery', 'Host', 'Product', 'Selfform', 'Panorama', 'Wedding', 'Vote', 'Estate', 'Reservation', 'Greeting_card');
                if (in_array($name, $m_arr)) {
                    //isset($_POST['precisions']) ? $precisions = 1: $precisions = 0 ;
                    $this->handleKeyword($id, $name, $_POST['keyword'], intval($_POST['precisions']));

                }

                $this->success('操作成功', U(MODULE_NAME . $back));
            } else {
                $this->error('操作失败', U(MODULE_NAME . $back));
            }
        }
    }

    //修改所有内容,包含关键词
    protected function all_save($name = '', $back = '/index')
    {
        $name = $name ? $name : MODULE_NAME;
        $db = D($name);
        if ($db->create() === false) {
            $this->error($db->getError());
        } else {
            $id = $db->save();
            if ($id) {
                $m_arr = array(
                    'Img',
                    'Text',
                    'Voiceresponse',
                    'Ordering', 'Lottery',
                    'Host', 'Product',
                    'Selfform',
                    'Panorama',
                    'Wedding',
                    'Vote',
                    'Estate',
                    'Reservation',
                    'Carowner', 'Carset'
                );
                if (in_array($name, $m_arr)) {
                    $this->handleKeyword(intval($_POST['id']), $name, $_POST['keyword'], intval($_POST['precisions']));

                }
                $this->success('操作成功', U(MODULE_NAME . $back));
            } else {
                $this->error('操作失败', U(MODULE_NAME . $back));
            }
        }
    }


    protected function dwzQuery($data)
    {
        $urls = array('t.cn', 'dwz.cn', 'url.cn', '985.so', 'is.gd', 'url7.me', 'to.ly', 'goo.gl');
        $url = parse_url($data['tinyurl']);
        if (in_array($url['host'], $urls)) {
            return true;
        } else if (in_array(dirname($url['path']), $urls)) {
            return true;
        } else if (in_array($data['tinyurl'], $urls)) {
            return true;
        } else {
            return false;
        }
        // 使用正则的方式，建议使用 会导致其他不是短网址的域名不能增加
        /*
        $ch=curl_init();
        curl_setopt($ch, CURLOPT_URL, "http://dwz.cn/query.php");
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        $result = curl_exec($ch);
        curl_close($ch);
        $query = json_decode($result, true);
        if($query['status'] == 0) {
            return true;
        } else {
            return false;
        }
        */
    }


    protected function replaceUrl($url, $params = array())
    {
        if (empty($url)) {
            return '';
        }
        $result = '';
        $url = parse_url($url);
        $siteUrl = parse_url($this->siteUrl);
        parse_str(htmlspecialchars_decode($url['query']), $query);
        foreach ($params['query'] as $key => $value) {
            if (isset($query[$key])) {
                $query[$key] = $value;
            }
        }
        $url['query'] = urldecode(http_build_query($query));
        if (isset($url['scheme'])) {
            $result = $url['scheme'] . '://';
        }
        if (isset($url['user'])) {
            $result .= $url['user'] . ':';
        }
        if (isset($url['pass'])) {
            $result .= $url['pass'] . '@';
        }
        if (isset($url['host'])) {
            if ($siteUrl['host'] == $url['host'] || '{siteUrl}' == $url['host']) { // 为本站链接时替换  或 {siteUrl}带http://
                $result = '';
            } else {
                $result .= $url['host'];
            }
        }
        if (!empty($url['path'])) { // /index.php 开头 或 index.php开头 侧替换
            if (empty($result)) {
                $flag = true;
                $dirname = dirname($url['path']);
                if ($dirname == $siteUrl['host']) { // 为本站链接时替换 不带 http://
                    $dirname = '.';
                }
                if ('{siteUrl}' == $dirname || strstr($dirname, '{siteUrl}')) {    //是替换模板时不添加http://	解决pathinfo 模式会强制加http
                    $flag = false;
                }
                $basename = basename($url['path']);
                if ('.' == $dirname && 'index.php' != $basename) { // 如果url 为 纯数字或字母时的处理  如 ： 12341234 abcabc
                    $result = $url['path'];
                } else {
                    if ('/' == $dirname || '\\' == $dirname || '.' == $dirname) {// 当url 为 /index.php \index.php ./index.php 时的处理
                        $flag = false;
                        $result .= '{siteUrl}/' . $basename;
                    } else {
                        $result .= $url['path'];
                    }

                }
            } else {
                $result .= $url['path']; // 当为 完整url时的处理  如 http://www.pigcms.com/index.php
            }
        } else {
            if (empty($result)) {
                $result = '{siteUrl}/index.php'; // 当url 为空 或不存在时的处理  如 ： '空' ?a=b  其他的特殊字符还未处理
            }
        }
        // 是否加http
        if ($flag) {
            $result = 'http://' . $result;
        }
        if (!empty($url['query'])) {
            $result .= '?' . $url['query'];
        }
        if (!empty($url['fragment'])) {
            $result .= '#' . $url['fragment'];
        }
        return $result;
    }

    public function _get($str){

    	return $_REQUEST[$str];

    }

    public function convertLink($url)
    {
        $url = str_replace(array('{siteUrl}', '&amp;', '&wecha_id={wechat_id}', '{changjingUrl}'), array($this->siteUrl, '&', '&diymenu=1', 'http://www.weihubao.com'), $url);
        return $url;
    }


    public function https_request($url, $data = NULL)
    {
        $curl = curl_init();

        $header = 'Accept-Charset: utf-8';
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $header);

        if (!empty($data)) {
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($curl);
        $errorno = curl_errno($curl);

        if ($errorno) {
            return array('curl' => false, 'errorno' => $errorno);
        } else {
            $res = json_decode($output, 1);

            if ($res['errcode']) {
                return array('errcode' => $res['errcode'], 'errmsg' => $res['errmsg']);
            } else {
                return $res;
            }
        }

        curl_close($curl);
    }

    public function wx_error_msg($code){
		//if(!is_numeric($code)){
		//	return "非法错误号！";
		//}
		if($code == -1){
            return "微信平台系统繁忙";
        }
        $error_codes = array(
            '40001'=>'请检查Appid 和AppSecret是否有错误 ',
			'40002'=>'不合法的凭证类型',
			'40003'=>'不合法的OpenID',
			'40004'=>'不合法的媒体文件类型',
			'40005'=>'不合法的文件类型',
			'40006'=>'不合法的文件大小',
			'40007'=>'不合法的媒体文件id',
			'40008'=>'不合法的消息类型',
			'40009'=>'不合法的图片文件大小',
			'40010'=>'不合法的语音文件大小',
			'40011'=>'不合法的视频文件大小',
			'40012'=>'不合法的缩略图文件大小',
			'40013'=>'不合法的APPID',
			'40014'=>'不合法的access_token',
			'40015'=>'不合法的菜单类型',
			'40016'=>'不合法的按钮个数',
			'40017'=>'不合法的按钮类型',
			'40018'=>'菜单名称超过最大长度',
			'40019'=>'不合法的按钮KEY长度',
			'40020'=>'URL链接超出最大长度',
			'40021'=>'不合法的菜单版本号',
			'40022'=>'不合法的子菜单级数',
			'40023'=>'不合法的子菜单按钮个数',
			'40024'=>'不合法的子菜单按钮类型',
			'40025'=>'不合法的子菜单按钮名字长度',
			'40026'=>'不合法的子菜单按钮KEY长度',
			'40027'=>'不合法的子菜单按钮URL长度',
			'40028'=>'不合法的自定义菜单使用用户',
			'40029'=>'不合法的oauth_code',
			'40030'=>'不合法的refresh_token',
			'40031'=>'不合法的openid列表',
			'40032'=>'不合法的openid列表长度',
			'40033'=>'不合法的请求字符，不能包含\uxxxx格式的字符',
			'40035'=>'不合法的参数',
			'40038'=>'不合法的请求格式',
			'40039'=>'不合法的URL长度',
			'40050'=>'不合法的分组id',
			'40051'=>'分组名字不合法',
        	'40054'=>'URL链接不正确，请仔细检查填写的链接。',
			'40099'=>'该 code 已被核销',
			'41001'=>'请检查Appid 和AppSecret是否有错误  ',
			'41002'=>'缺少appid参数',
			'41003'=>'缺少refresh_token参数',
			'41004'=>'缺少secret参数',
			'41005'=>'缺少多媒体文件数据',
			'41006'=>'缺少media_id参数',
			'41007'=>'缺少子菜单数据',
			'41008'=>'缺少oauth code',
			'41009'=>'缺少openid',
			'42001'=>'access_token超时',
			'42002'=>'refresh_token超时',
			'42003'=>'oauth_code超时',
			'42005'=>'调用接口频率超过上限',
			'43001'=>'需要GET请求',
			'43002'=>'需要POST请求',
			'43003'=>'需要HTTPS请求',
			'43004'=>'需要接收者关注',
			'43005'=>'需要好友关系',
			'44001'=>'多媒体文件为空',
			'44002'=>'POST的数据包为空',
			'44003'=>'图文消息内容为空',
			'44004'=>'文本消息内容为空',
			'45001'=>'多媒体文件大小超过限制',
			'45002'=>'消息内容超过限制',
			'45003'=>'标题字段超过限制',
			'45004'=>'描述字段超过限制',
			'45005'=>'链接字段超过限制',
			'45006'=>'图片链接字段超过限制',
			'45007'=>'语音播放时间超过限制',
			'45008'=>'图文消息超过限制',
			'45009'=>'接口调用超过限制',
			'45010'=>'创建菜单个数超过限制',
			'45015'=>'回复时间超过限制',
			'45016'=>'系统分组，不允许修改',
			'45017'=>'分组名字过长',
			'45018'=>'分组数量超过上限',
			'45024'=>'账号数量超过上限',
			'46001'=>'不存在媒体数据',
			'46002'=>'不存在的菜单版本',
			'46003'=>'不存在的菜单数据',
			'46004'=>'不存在的用户',
			'47001'=>'解析JSON/XML内容错误',
			'48001'=>'api功能未授权',
			'50001'=>'用户未授权该api',
			'61450'=>'系统错误',
			'61451'=>'参数错误',
			'61452'=>'无效客服账号',
			'61453'=>'账号已存在',
			'61454'=>'客服帐号名长度超过限制(仅允许10个英文字符，不包括@及@后的公众号的微信号)',
			'61455'=>'客服账号名包含非法字符(英文+数字)',
			'61456'=>'客服账号个数超过限制(10个客服账号)',
			'61457'=>'无效头像文件类型',
			'61500'=>'日期格式错误',
			'61501'=>'日期范围错误',
			'7000000'=>'请求正常，无语义结果',
			'7000001'=>'缺失请求参数',
			'7000002'=>'signature 参数无效',
			'7000003'=>'地理位置相关配置 1 无效',
			'7000004'=>'地理位置相关配置 2 无效',
			'7000005'=>'请求地理位置信息失败',
			'7000006'=>'地理位置结果解析失败',
			'7000007'=>'内部初始化失败',
			'7000008'=>'非法 appid（获取密钥失败）',
			'7000009'=>'请求语义服务失败',
			'7000010'=>'非法 post 请求',
			'7000011'=>'post 请求 json 字段无效',
			'7000030'=>'查询 query 太短',
			'7000031'=>'查询 query 太长',
			'7000032'=>'城市、经纬度信息缺失',
			'7000033'=>'query 请求语义处理失败',
			'7000034'=>'获取天气信息失败',
			'7000035'=>'获取股票信息失败',
			'7000036'=>'utf8 编码转换失败',
        );
        if(isset($error_codes[$code])){
            return $error_codes[$code];
        }else{
            return "错误号：{$code},未知错误";
        }
	
	}

}