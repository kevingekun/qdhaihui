<?php
/** 模型
 * Attribute
 * @author: yanhuaitang
 * @date: 2015/10/13 14:35
 */
namespace Common\Model;

use Think\Model;

class AttributeModel extends BaseModel
{
    protected $tableName = 'attribute';

    const STATUS_ON = 0; // 开启可用
    const STATUS_OFF = 0; // 关闭不可用

    public function findAttributes($type, $status=0, $order='id ASC')
    {
        $map = array(
            'type' => $type,
            'status' => $status,
        );
        return $this->where($map)->order($order)->select();
    }

}