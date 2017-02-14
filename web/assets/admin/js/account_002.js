
(function(VAccount){var $=J;var MIndex=GDT.modAccount;var tpl=J('#tpl_info').html();var creditSwitch;var CREDIT_STATUS_PENDING=1;var CREDIT_STATUS_ON=2;var ACCOUNT_STATUS_ON=0;var ACCOUNT_STATUS_PAUSE=1;var CFT_STATUS_FROZEN=4;function Switcher(element,isOn,onchange){this.element=$(element);this.onClass='status-btn-open';this.isOn=isOn;this.init=function(){var th=this;th.setValue(this.isOn);th.element.click(function(e){th.setValue(!th.isOn);onchange(th.isOn,e,th);})};this.setValue=function(isOn){this.isOn=isOn;if(this.isOn){this.element.addClass(this.onClass);this.element.find('._text').text('开启');this.element.attr('title','点击后暂停');}else{this.element.removeClass(this.onClass);this.element.find('._text').text('暂停');this.element.attr('title','点击后启用。将会在您现金账户余额不足的情况下，自动从您的透支账户进行扣款充值到现金账户中。');}};this.getValue=function(){return isOn;};this.init();}
VAccount.init=function(){GDT.page.init(function(){GDT.speed.create('modAccount',[175,384,2]);GDT.modAccount.checkIfCharge();VAccount.loadAccountInfo(function(){GDT.speed.mark(2);GDT.modAccount.checkReport();});GDT.viewCharge.init();});};function showCreditInfo(){function showcb(o){if(o.ret==0){if(o.data.is_credit&&!o.data.credit_status){$('#_touzhizhanghu').show();$('#_touzhizhanghu>._before_apply').show();$('#_touzhizhanghu ._mayamount').text(o.data.credit_baseval);$('#_touzhizhanghu ._apply').click(function(e){e.preventDefault();showApplyCreditForm(o.data.credit_baseval);});}else if(o.data.is_credit&&o.data.credit_status==CREDIT_STATUS_PENDING){$('#_touzhizhanghu>._before_apply>span').text('您已经提交开通透支账户的申请，目前正在审核办理中！');$('#_touzhizhanghu').show();$('#_touzhizhanghu>._before_apply').show();}else if(o.data.is_credit&&o.data.credit_status==CREDIT_STATUS_ON){$('#_touzhizhanghu').html(GDT.util.tmpl($('#tpl_info_creditafter').html(),$.extend({},o.data,GDT.pageAccountInfo)));if(o.data.cft_status&&o.data.cft_status==CFT_STATUS_FROZEN){$('#_touzhizhanghu>p._after_apply').append($('<span>').addClass('c-red').text('（您的透支账户已经被冻结，请联系财付通）'))}else{creditSwitch=new Switcher($('#_touzhikaiguan'),o.data.account_status==ACCOUNT_STATUS_ON,turnCreditOnOff);$('#_touzhikaiguandiv').show();}
$('#_touzhizhanghu').show();}else{$('#_touzhizhanghu').hide();}}}
GDT.cgiAccount.checkCredit({},showcb);}
function turnCreditOnOff(isOn,e,switcher){GDT.cgiAccount.switchCredit({forzen_type:isOn?ACCOUNT_STATUS_ON:ACCOUNT_STATUS_PAUSE},function(o){if(o.ret==0){}else{GDT.util.showMsgbox(o.msg||'提交失败');switcher.setValue(!isOn);}})}
function showApplyCreditForm(credit_baseval){var htmlStr=GDT.util.tmpl($('#credit_apply').html(),{credit_baseval:credit_baseval});function apply(data){GDT.cgiAccount.openCredit(data,function(o){if(o.ret==0){layer.setReturnValue(true);layer.unload();var dlg=QZFL.dialog.create("透支账户申请",$('#credit_apply_succ').html(),{height:220,width:380,buttonConfig:[{type:QZFL.dialog.BUTTON_TYPE.Confirm,text:'确定',clickFn:function(){showCreditInfo();}}]});}else{GDT.util.showMsgbox(o.msg||'提交失败');}});}
var layer=QZFL.dialog.create("透支账户申请",htmlStr,{showMask:true,height:220,width:450,onLoad:function(){},buttonConfig:[{type:QZFL.dialog.BUTTON_TYPE.Confirm,text:'确定',clickFn:function(){layer.setReturnValue(false);var data={};data.name=$('#_creditapplyform input[name=name]').val();data.mobile=$('#_creditapplyform input[name=mobile]').val();if(!(data.name&&data.mobile)){GDT.util.showMsgbox('请填写完整再提交');return false;}else{apply(data);}}},{type:QZFL.dialog.BUTTON_TYPE.Cancel,text:'取消',clickFn:function(){layer.setReturnValue(true);layer.unload();}}]});layer.onBeforeUnload=function(rt){return rt;};layer.setReturnValue(true);}
window.showApplyCreditForm=showApplyCreditForm;VAccount.loadAccountInfo=function(cb,options){var loadInfoDef=J.Deferred(),loadModStatJsDef=J.Deferred();options=options||{};GDT.beautyUI.showLoading("_account",{minHeight:'150px'});GDT.cgiAccount.getInfo(function(d){GDT.beautyUI.hideLoading("_account");if(d.ret===0){loadInfoDef.resolve(d);}else{GDT.util.showMsgbox(d.msg||'系统繁忙，请稍后再试');}
cb&&cb();});GDT.load([GDT.files.getVersionFile('modaccountstat')],function(){loadModStatJsDef.resolve();});J.when(loadInfoDef,loadModStatJsDef).done(function(d){var da=d.data;da=GDT.modAccountStat.parseData(da);da.billorderstr=GDT.env.billorderlist[da.billorder]||'';GDT.pageAccountInfo=da;J('#_account').html(GDT.util.tmpl(tpl,da));GDT.helper.bindSetDaybudget("_account_daybudget","_account_daybudget");GDT.log('accountInfo',GDT.accountInfo);showCreditInfo();if(GDT.accountInfo.agid){GDT.viewAccount.bindSetBillorder();}});};VAccount.bindSetBillorder=function(){var tpl=['<p class="radio_item"><input type="radio" class="input_radio" name="billorder" id="billorder2" value="2" /><label for="billorder2">现金优先</label><input type="radio" class="input_radio"  name="billorder" id="ordercost1" value="1" /><label for="billorder1">虚拟优先</label></p>'].join('');GDT.delegate('_billordercnt','click',{billorder:function(evt){var orival=GDT.pageAccountInfo.billorder;GDT.modifier.slab(evt.target,tpl,function(){var billorder=J('[name=billorder]:checked').val();if(!billorder){GDT.util.showMsgbox('请选择顺序',2);return false;}
if(billorder==orival){return;}
GDT.cgiAccount.setBillorder(billorder,function(d){if(d.ret===0){GDT.pageAccountInfo.billorder=d.data.billorder;J('#_ori_billorder').html(GDT.env.billorderlist[d.data.billorder]);GDT.util.showMsgbox('修改消耗顺序成功',4);}else{GDT.util.showMsgbox(d.msg||'设置日消耗顺序失败');return false;}});},function(wrap){J(wrap).css('zIndex',100);GDT.form.setVal('billorder',orival);});return false;}});};})(GDT.viewAccount={});