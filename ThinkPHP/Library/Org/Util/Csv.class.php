<?php
namespace Org\Util;
/**
 * php Export CSV abstract class,根据总记录数与每批次记录数,计算总批次,循环导出。
 *
 */
class Csv
{
    // 定义类属性
    protected $total = 0;                 // 总记录数
    protected $pagesize = 500;            // 每批次导出的记录数
    protected $exportName = 'export.csv'; // 导出的文件名
    protected $separator = ',';           // 设置分隔符
    protected $delimiter = '"';           // 设置定界符
    protected $data = array();            // 要导出的内容
    protected $title = array();           // 要导出的列名
    protected $keys = array();            // 要导出的数组对应key 的值

    public function __construct($data)
    {
        $this->data = $data;
    }

    /** 获取总记录条数
     * @return int
     */
    protected function getExportTotal()
    {
        return count($this->data);
    }

    /**
     * 获取导出的列名
     * @return Array
     */
    protected function getExportFields()
    {
        return $this->title;
    }

    /**
     * 获取每批次数据
     * @param  int $offset 偏移量
     * @param  int $limit 获取的记录条数
     * @return Array
     */
    protected function getExportData($offset, $limit)
    {
        return array_slice($this->data, $offset, $limit);
    }


    /**
     * 设置每次导出的记录条数
     * @param int $pagesize 每次导出的记录条数
     */
    public function setPageSize($pagesize = 0)
    {
        if (is_numeric($pagesize) && $pagesize > 0) {
            $this->pagesize = $pagesize;
        }
        return $this;
    }


    /**
     * 设置导出的文件名
     * @param String $filename 导出的文件名
     */
    public function setExportName($filename)
    {
        if ($filename != '') {
            $this->exportName = $filename;
        }
        return $this;
    }

    /**
     * 设置分隔符
     * @param String $separator 分隔符
     */
    public function setSeparator($separator)
    {
        if ($separator != '') {
            $this->separator = $separator;
        }
        return $this;
    }


    /**
     * 设置定界符
     * @param String $delimiter 定界符
     * @return $this
     */
    public function setDelimiter($delimiter)
    {
        if ($delimiter != '') {
            $this->delimiter = $delimiter;
        }
        return $this;
    }

    /**
     * 设置导出首行标题, 例如: array('姓名', '电话', '地址') ...
     * @param array $title
     * @return $this
     */
    public function setExportTitle(array $title)
    {
        if (is_array($title) && !empty($title)) {
            $this->title = $title;
        }
        return $this;
    }

    /**
     * 设置要导出的数据列 对应的 key值, 例如 $keys = array('id', 'name')
     * @param array $keys
     * @return $this
     */
    public function setExportKeys(array $keys)
    {
        if (is_array($keys) && !empty($keys)) {
            $this->keys = $keys;
        }
        return $this;
    }

    /** 导出csv */
    public function export($filePath='')
    {
        // 获取总记录数
        $this->total = $this->getExportTotal();

        // 没有记录
        if (!$this->total) {
            return false;
        }

        // 计算导出总批次
        $pagecount = $this->getPageCount();

        // 获取导出的列名
        $fields = $this->getExportFields();

        if($filePath == ''){
            // 设置导出文件header
            $this->setHeader();
        }

        // 循环导出
        for ($i = 0; $i < $pagecount; $i++) {
            $exportData = '';
            if ($i == 0) { // 第一条记录前先导出列名
                $exportData .= $this->formatCSV($fields);
            }

            // 设置偏移值
            $offset = $i * $this->pagesize;
            // 获取每页数据
            $data = $this->getExportData($offset, $this->pagesize);
            // 将每页数据转换为csv格式
            if ($data) {
                foreach ($data as $row) {
                    if($this->keys){
                        $newRow = array();
                        foreach($this->keys as $value){
                            $newRow[$value] = $row[$value];
                        }
                    }
                    $exportData .= $this->formatCSV($newRow);
                }
            }
            //$exportData = iconv('UTF-8', 'GBK', $exportData);
            $exportData = mb_convert_encoding($exportData,  'GBK', 'UTF-8');

            if($filePath == ''){
                // 导出数据
                echo $exportData;
            } else {
                file_put_contents(rtrim($filePath, '/') . '/' . $this->exportName , $exportData);
                header("Content-type: text/html; charset=utf-8");
                echo "<script>alert('导出成功, 请继续其他操作');history.go(-1);</script>";
            }

        }
    }


    /**
     * 算出总批次
     * @return int
     */
    private function getPageCount()
    {
        $pagecount = (int)(($this->total - 1) / $this->pagesize) + 1;
        return $pagecount;
    }


    /**
     * 设置header
     */
    private function setHeader()
    {
        header('content-type:application/x-msexcel');

        $ua = $_SERVER['HTTP_USER_AGENT'];

        if (preg_match("/MSIE/", $ua)) {
            header('content-disposition:attachment; filename="' . rawurlencode($this->exportName) . '"');
        } elseif (preg_match("/Firefox/", $ua)) {
            header("content-disposition:attachment; filename*=\"utf8''" . $this->exportName . '"');
        } else {
            header('content-disposition:attachment; filename="' . $this->exportName . '"');
        }

        ob_end_flush();
        ob_implicit_flush(true);
    }


    /**
     * 格式化为csv格式数据
     * @param Array $data 要转换为csv格式的数组
     */
    private function formatCSV($data = array())
    {
        // 对数组每个元素进行转义
        $data = array_map(array($this, 'escape'), $data);
        return $this->delimiter . implode($this->delimiter . $this->separator . $this->delimiter, $data) . $this->delimiter . "\r\n";
    }


    /**
     * 转义字符串
     * @param  String $str
     * @return String
     */
    private function escape($str)
    {
        return str_replace($this->delimiter, $this->delimiter . $this->delimiter, $str);
    }


}