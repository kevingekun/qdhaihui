<?php
/**
 * 控制器基类
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Controller;

use Think\Controller;

class BaseController extends Controller
{
    public $pageSize; // 每页条数
    public $page; // 页数


    public function _initialize()
    {
        $this->pageSize = C('PAGE_SIZE') ? C('PAGE_SIZE') : 25;
        $p = intval(isset($_GET['p']) ? $_GET['p'] : 1);
        $this->page = $p > 0 ? $p : 1;

    }


    /**
     * 导出csv
     * @param $data 二位数组, 要导出的数据
     * @param array $info $key=>$value  如: array('name'=>'姓名', 'phone'=>'手机'); 导出的列及列名
     * @param string $filename 文件名
     * @param string $separator 分隔符
     * @param string $delimiter 定界符
     */
    protected function export($data, $info = array(), $filePath = '', $filename = '', $separator = ',', $delimiter = '"')
    {
        if(trim($filename) == ''){
            $filename = date('YmdHis') . mt_rand(100,999) . '.csv';
        }
        $title = $keys = array();
        if(is_array($info) && !empty($info)){
            $keys = array_keys($info);
            $title = array_values($info);
        }

        // 是否保存到服务器
        if(trim($filePath) != '' && !file_exists($filePath)){
            mkdirs($filePath);
        }

        $csv = new \Org\Util\Csv($data);
        $csv->setExportTitle($title)
            ->setExportKeys($keys)
            ->setExportName($filename)
            ->setDelimiter($delimiter)
            ->setSeparator($separator)
            ->export($filePath);
        die;
    }

    /**
     * 通用文件上传
     * @param array $config 参考方法内部的defaultConfig 在外部可进行设置
     * @param string $driver 要使用的上传驱动 LOCAL-本地上传驱动，FTP-FTP上传驱动
     * @param null $driverConfig
     * @return array|bool 采用的多图片上传模式, 单图上传需注意返回格式, 上传失败返回false
     */
    protected function upload($config = array(), $driver = '', $driverConfig = null)
    {
        $defaultConfig = array(
            'mimes' => array(), //允许上传的文件MiMe类型
            'maxSize' => 5 * 1024 * 1024, //上传的文件大小限制 (0-不做限制)
            'exts' => array('jpg', 'gif', 'png', 'jpeg'), //允许上传的文件后缀
            'autoSub' => true, //自动子目录保存文件
            'subName' => array('date', 'Ymd'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
            'rootPath' => './uploads/', //保存根路径
            'savePath' => '', //保存路径
            'saveName' => array('uniqid', ''), //上传文件命名规则，[0]-函数名，[1]-参数，多个参数使用数组
            'saveExt' => '', //文件保存后缀，空则使用原后缀
            'replace' => false, //存在同名是否覆盖
            'hash' => true, //是否生成hash编码
            'callback' => false, //检测文件是否存在回调，如果存在返回文件信息数组
        );
        $config = array_merge($defaultConfig, $config);
        $upload = new \Think\Upload($config, $driver, $driverConfig);// 实例化上传类

        // 上传文件
        $info = $upload->upload();
        if (!$info) {// 上传错误提示错误信息
            $this->error($upload->getError());
            return false;
        } else {// 上传成功
            return $info;
        }
    }


    /**
     * 通用分页
     * eg:
     * $User = M('User'); // 实例化User对象
     * $list = $User->where($map)->order('create_time')->page($_GET['p'] . ',25')->select();
     * $count = $User->where($map)->count();// 查询满足要求的总记录数
     *
     * $page = $this->page($count, $map);
     * $this->assign('page', $page);
     * $this->assign('list', $list);
     * $this->display();
     * @param int $count 总数
     * @param array $map 组装url搜索参数
     * @param int $pageSize 每页数量
     * @return string $page
     */
    protected function page($count, $map = array(), $pageSize = 25)
    {
        $page = new \Think\Page($count, $pageSize);
        $page->setConfig('header', '共%TOTAL_ROW%条');
        $page->setConfig('first', '首页');
        $page->setConfig('last', '共%TOTAL_PAGE%页');
        $page->setConfig('prev', '上一页');
        $page->setConfig('next', '下一页');
        $page->setConfig('theme', '%HEADER% %FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END%');

        foreach ($map as $key => $val) {
            $page->parameter[$key] = urlencode($val);
        }
        return $show = $page->show();// 分页显示输出
    }
}