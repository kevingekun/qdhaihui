<?php
namespace Common\Model;

/**
 * 佣金model
 * Class CommissionModel
 * @package Common\Model
 */
class CommissionModel extends BaseModel
{
    const TYPE_PRODUCT = 1; // 产品佣金
    const TYPE_PRODUCT_REWARD = 2; // 产品佣金提成
    const TYPE_SPREAD = 3; // 推广佣金
    const TYPE_SPREAD_REWARD = 4; // 推广佣金提成
    const TYPE_REWARD = 5; // 激励佣金

    const STATUS_NO = 0; // 未结算状态
    const STATUS_CHECK = 1; // 审核中
    const STATUS_YES = 9; // 已结算状态




}