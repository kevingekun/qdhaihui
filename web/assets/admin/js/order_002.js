
(function(VOrder,MOrder){VOrder.CONST={DAYS3:172800000};VOrder.isAsyncDataLoaded=true;VOrder.whitelist={isCPM:function(){return GDT.account.checkPrivilege('cpm');},hasPingURL:function(){return GDT.account.checkPrivilege('customized_url');},isRzEmbed:function(){return GDT.account.checkPrivilege('renzheng_embed');},isShoppingInterest:function(){return GDT.account.checkPrivilege('shoppinginterest');},isTargetingLBS:function(){return GDT.account.checkPrivilege('targeting_lbs');},isO2O:function(){return GDT.account.checkPrivilege('limitation_1000');},isGroupSearch:function(){return GDT.account.checkPrivilege('group_search');},isLinktypeOnlyNormal:function(){return GDT.account.checkPrivilege('linktype_only_normal');},isCollaborator:function(){return GDT.account.checkPrivilege('collaborator');},isTaskAduser:function(){return GDT.whitelist.isTaskAduser();},isOpenPlatformAppAduser:function(){return GDT.whitelist.isOpenPlatformAppAduser();},isInnerAppAduser:function(){return GDT.gAduser&&GDT.gAduser.targettype==GDT.confTargetType.INNER_APP;},isQQLiveShow:function(){return GDT.account.checkPrivilege('qq_liveshow_room');},isBqq:function(){return GDT.account.checkPrivilege('bqq');},isQzoneGift:function(){return GDT.account.checkPrivilege('qzone_gift');},isQzoneSign:function(){return GDT.account.checkPrivilege('qzone_sign');},isSensitiveIndustryAduser:function(){return GDT.account.checkPrivilege('pcuni_medical');},isWechatAduser:function(){return GDT.account.checkPrivilege('weixin_ex_link');}};VOrder.viewController=(function(){var pageletMapping,buttonMapping,enableButton,disableButton;enableButton=function(){J('#wrapButton a').attr({'data-disabled':'',title:''});};disableButton=function(){J('#wrapButton a').attr({'data-disabled':'disabled',title:'请等待请求完成'});};buttonMapping={toBasic:{tpl:'<a href="javascript:;" opt="toBasic" onclick="return false" data-skipvalidate="1" class="previous s-button-back" title="回到基本信息" data-hottag="atlas.orderbutton.tobasic" data-hotsender="parent">上一步</a>',handler:function(){VOrder.viewController.showPagelet('basic');}},toCreative:{tpl:'<a href="javascript:;" opt="toCreative" onclick="return false" class="next s-button-right" title="跳到规格选择" data-hottag="atlas.orderbutton.tocreative" data-hotsender="parent">下一步</a>',handler:function(){var data,fields=[];if(MOrder.invalidFileds.length>0){return false;}
GDT.timepot.customStep1End=+new Date;J.each(pageletMapping.basic.pagelet,function(i,item){fields=fields.concat(item.fields).concat(item.dynamicFields);});data=MOrder.getValue(fields);MOrder.setOrderCacheData(data);GDT.log('collect data: ',data);VOrder.viewController.showPagelet('creative');}},backCreative:{tpl:'<a href="javascript:;" opt="backCreative" onclick="return false" data-skipvalidate="1" class="previous s-button-back" title="回到规格选择" data-hottag="atlas.orderbutton.backcreative" data-hotsender="parent">上一步</a>',handler:function(evt){VOrder.viewController.showPagelet('creative');}},toTargeting:{tpl:'<a href="javascript:;" opt="toTargeting" onclick="return false" class="next s-button-right" title="跳到定向设置" data-hottag="atlas.orderbutton.totargeting" data-hotsender="parent">下一步</a>',handler:function(){var data,fields=[],creatives={};if(MOrder.invalidFileds.length>0){return false;}
GDT.timepot.customStep2End=+new Date;J.each(pageletMapping.creative.pagelet,function(i,item){fields=fields.concat(item.fields).concat(item.dynamicFields);});data=MOrder.getValue(fields);J.each(data.creatives||{},function(crtsize,item){J.each(item,function(tid,v){if(!v._isEmpty){delete v._isEmpty;!creatives[crtsize]&&(creatives[crtsize]={});creatives[crtsize][tid]=v;}});});data.creatives=creatives;MOrder.setOrderCacheData(data);GDT.log('collect data: ',data);J.each(GDT.viewOrderEdit.getPageletFields('targeting'),function(k,one){MOrder.dance(one);});VOrder.viewController.showPagelet('targeting');return false;}},backTargeting:{tpl:'<a href="javascript:;" opt="backTargeting" onclick="return false" data-skipvalidate="1" class="previous s-button-back" title="回到定向设置" data-hottag="atlas.orderbutton.backtargeting" data-hotsender="parent">上一步</a>',handler:function(evt){VOrder.viewController.showPagelet('targeting');}},toPreview:{tpl:'<a href="javascript:;" opt="toPreview" onclick="return false" class="next s-button-right" title="跳到确认提交" data-hottag="atlas.orderbutton.topreview" data-hotsender="parent">下一步</a>',handler:function(){var data,fields=[];if(MOrder.invalidFileds.length>0){return false;}
GDT.timepot.customStep3End=+new Date;data=GDT.viewOrderTargeting.getTarget('targeting');MOrder.setOrderCacheData(data);GDT.log('collect data: ',data);VOrder.viewController.showPagelet('preview');return false;}},close:{tpl:'<a href="javascript:;" opt="close" onclick="return false" data-skipvalidate="1" class="close s-button-back" title="收起面板" data-hottag="atlas.orderbutton.close" data-hotsender="parent">取消</a>',handler:function(){var cf=new GDT.util.Confirm('请确认：','确定要放弃当前的编辑吗？',{'icontype':'warn','type':QZFL.widget.Confirm.TYPE.OK_NO,'hastitle':false,'height':120,'tips':['确认','取消']});cf.onConfirm=function(){MOrder.clearOrderCacheData();VOrder.clearLocalCacheData();parent.GDT.sideslide.collapse({'remove':true});};cf.onNo=function(){};cf.show();}},submit:{tpl:'<a href="javascript:;" opt="submit" onclick="return false" class="next s-button-right" title="保存广告">提交广告</a>',handler:function(){var action,params={};params=VOrder.viewController.getOrderData();GDT.timepot.customStep4End=+new Date;action=VOrder.isEdit?'modify':'add';disableButton();GDT.util.showMsgbox('正在提交数据，请稍候……',6,15000);GDT.cgiOrder[action](params,function(d){GDT.util.hideMsgbox();if(d.ret===0){var cont,orderurl,oid=d.data.aid,cid=d.data.cid,msg='提交成功';VOrder.isSubmited=true;MOrder.clearOrderCacheData();VOrder.clearLocalCacheData();orderurl=GDT.ENV.ROOT+'report/order?oid='+oid;cont='<div class="pagedone">\
         <div class="tipsline"><i class="ico-right l"><i></i></i>\
          <div class="tipsline-info">\
              <strong class="tipsline-info-title">'+msg+'</strong>\
              <p class="tipsline-info-p">您还可以 <a href="edit?oid='+oid+'&cid='+cid+'&clone=1" id="cloneOrder" data-hottag="atlas.ordercomplete.clone" data-hotsender="parent">复制广告</a> 或 <a href="edit" data-hottag="atlas.ordercomplete.continue" data-hotsender="parent">继续新建</a></p>\
          </div>\
           </div>\
         <div class="s-btnline">\
          <a href="'+orderurl+'" class="tipsline-check-ad s-button-right" target="_parent" id="viewOrder" data-hottag="atlas.ordercomplete.view" data-hotsender="parent">查看广告</a>\
          <a href="javascript:;" class="tipsline-close s-button-back" id="closepop" data-hottag="atlas.ordercomplete.close" data-hotsender="parent">关闭</a>\
         </div>';J('#innerPreview').html(cont);GDT.timepot.customCommitEnd=+new Date;GDT.pageSpeed.report();J('#closepop').bind('click',function(){parent.GDT.sideslide.collapse({'remove':true});});J('#wrapButton').hide();}else{enableButton();GDT.util.showMsgbox(d.msg||'提交失败，请重试',d.ret===0?4:3,2000);var step;step=parseInt(d.data&&d.data.step,10);if(step){J.each(pageletMapping,function(pagelet,cnf){if(cnf.step==step){VOrder.viewController.showPagelet(pagelet);}});}}},function(){enableButton();GDT.util.showMsgbox('提交失败，请重试');});}},submitpack:{tpl:'<a href="javascript:;" opt="submitpack" onclick="return false" class="next s-button-right" title="保存定向包">提交</a>',handler:function(){disableButton();GDT.util.showMsgbox('正在提交数据，请稍候……',6,15000);if(MOrder.invalidFileds.length>0){GDT.util.hideMsgbox();enableButton();return false;}
GDT.targetPackEdit.save(function(data){GDT.util.hideMsgbox();},function(){GDT.util.hideMsgbox();enableButton();});}}};pageletMapping={basic:{step:1,pagelet:'basic',label:'基本信息',button:['close','toCreative'],js:GDT.files.getVersionFile('vieworderbasic'),handler:function(callback){GDT.viewOrderBasic.init(callback)},pagelet:[{block:1,title:'',fields:['campaignid','ordername','sdate+edate','alltime','linktype'],dynamicFields:[]}]},creative:{step:2,pagelet:'creative',label:'规格选择',button:['toTargeting','toBasic','close'],js:GDT.files.getVersionFile('viewordercreative'),handler:function(callback){GDT.viewOrderCreative.init(callback)},pagelet:(function(){var fields=['siteset','industry_id','crtsize'];return[{block:1,title:'',fields:fields,dynamicFields:[]}];})()},targeting:{step:3,pagelet:'targeting',label:'定向设置',button:['toPreview','backCreative','close'],js:[GDT.files.getVersionFile('validator'),GDT.files.getVersionFile('selectmanage'),GDT.files.getVersionFile('viewordertargeting'),GDT.files.getVersionFile('targetpackedit'),GDT.files.getVersionFile('slider')],handler:function(callback){GDT.viewOrderTargeting.init('targeting',{callback:callback});},pagelet:[{block:1,title:'',fields:['targetpkg','area'],dynamicFields:[]},{block:2,title:'基本信息',fields:['age','gender','scene'],dynamicFields:[],expandable:true},{block:3,title:'用户情况',fields:['education','userstatus','imgroup','businessinterest','keyword'],dynamicFields:[],expandable:true},{block:4,title:'用户行为<span class="tips-remark c-tx3"><i class="icon ico-tips"><i></i></i>对投放非APP商品的广告，请勿使用“应用用户”定向</span>',fields:['payment','fans','appaction_object_type','appuser'],dynamicFields:[],expandable:true},{block:5,title:'自定义用户',fields:['numberpackage'],dynamicFields:[],expandable:true},{block:11,title:'消费能力',fields:(function(){var arr=[];if(GDT.account.checkPrivilege('community_price ')){arr.push('resident_community_price');}
if(GDT.account.checkPrivilege('player_consupt')){arr.push('player_consupt');}
if(GDT.account.isConsumption()||GDT.account.isLowConsumption()){arr.push('consumption_ability');}
return arr;})(),dynamicFields:[],expandable:true},{block:6,title:'流量方定向',fields:['wechatflowclass'],dynamicFields:[],expandable:true},{block:7,title:'天气定向<i class="icon ico-help" rel="order.weather"><i></i></i>',fields:['dressindex','uvindex','makeupindex','climate','temperature'],dynamicFields:[],expandable:true},{block:8,title:'移动定向<span class="tips-remark c-tx3"><i class="icon ico-tips"><i></i></i>对投放到非移动平台上的广告，请勿使用“移动定向”</span>',fields:['mobileprice','os','connectiontype','isp'],dynamicFields:[],expandable:true},{block:9,title:'',fields:['newtargetpack'],dynamicFields:[]},{block:10,title:'',fields:['feetype','feeprice'],dynamicFields:[]}]},targetpack:{step:4,pagelet:'targetpack',label:'定向包设置',button:['close','submitpack'],js:[GDT.files.getVersionFile('validator'),GDT.files.getVersionFile('selectmanage'),GDT.files.getVersionFile('viewordertargeting'),GDT.files.getVersionFile('targetpackedit'),GDT.files.getVersionFile('slider')],handler:function(callback){var mid=VOrder.params.mid||null,act;act=VOrder.params.act;GDT.jumpallow=true;GDT.viewOrderTargeting.init('targetpack',{data:{mid:mid,act:act},callback:callback});},pagelet:[{title:'',fields:['rulename','ruledesc'],dynamicFields:[]},{title:'',fields:['area'],dynamicFields:[]},{title:'基本信息',fields:['age','gender','scene'],dynamicFields:[],expandable:true},{title:'用户情况',fields:['education','userstatus','businessinterest','keyword'],dynamicFields:[],expandable:true},{title:'用户行为<span class="tips-remark c-tx3"><i class="icon ico-tips"><i></i></i>对投放非APP商品的广告，请勿使用“应用用户”定向</span>',fields:['payment','appaction_object_type','appuser'],dynamicFields:[],expandable:true},{title:'自定义用户',fields:['numberpackage'],dynamicFields:[],expandable:true},{block:11,title:'消费能力',fields:(function(){var arr=[];if(GDT.account.checkPrivilege('community_price ')){arr.push('resident_community_price');}
if(GDT.account.checkPrivilege('player_consupt')){arr.push('player_consupt');}
if(GDT.account.isConsumption()||GDT.account.isLowConsumption()){arr.push('consumption_ability');}
return arr;})(),dynamicFields:[],expandable:true},{title:'天气定向<i class="icon ico-help" rel="order.weather"><i></i></i>',fields:['dressindex','uvindex','makeupindex','climate','temperature'],dynamicFields:[],expandable:true},{title:'移动定向<span class="tips-remark c-tx3"><i class="icon ico-tips"><i></i></i>对投放到非移动平台上的广告，请勿使用“移动定向”</span>',fields:['mobileprice','os','connectiontype','isp'],dynamicFields:[],expandable:true}],header:false},preview:{step:4,pagelet:'preview',label:'确认提交',button:['submit','backTargeting','close'],js:GDT.files.getVersionFile('vieworderpreview'),handler:function(callback){GDT.viewOrderPreview.init(callback)},pagelet:[{block:1,title:'',fields:['preview_orderimg'],dynamicFields:[]},{block:2,title:'',fields:['preview_campaign','preview_ordername','preview_linktype','preview_apkname','preview_date','preview_metaclass'],dynamicFields:[]},{block:3,title:'',fields:['preview_userrules','preview_payment'],dynamicFields:[]}]}};return{pageletMapping:pageletMapping,getPageletSteps:function(){var steps=['basic','creative','targeting','preview'];J.each(steps,function(i,pagelet){pageletMapping[pagelet].step=i+1;});return steps;},getOrderData:function(){var data=MOrder.getOrderCacheData(),params={};VOrder.campaignData=VOrder.campaignData||{};data.campaignname=GDT.translator.getText('campaignid',data.campaignid);data.daybudget=(VOrder.campaignData[data.campaignid]||{}).daybudget||'';J.each(data,function(field,value){if(field.substring(0,1)!='_'){params[field]=data[field];}
typeof data.formid==='undefined'&&/^crtsize/.test(field)&&(params.formid=value);});typeof params.formid==='undefined'&&(params.formid=data.crtsize||'');params.sdate&&params.edate&&(params.launchdate=[params.sdate,params.edate].join(','));return params;},showPagelet:function(pagelet,callback){var pageletHandler=pageletMapping[pagelet];if(!pageletHandler){throw'error pagelet.';}
J('#wrapBasic,#wrapCreative,#wrapTargeting,#wrapPreview').css('display','none');J('#innerPreview').html('');VOrder.params.step=pagelet;GDT.beautyUI.showLoading('content',{minHeight:'200px'});pageletHandler.header!==false?this.renderHeader(pageletHandler):J('#viewProcess').hide();J('#wrapButton').hide();GDT.load(pageletHandler.js,function(){GDT.beautyUI.hideLoading('content');VOrder.viewController.needRestoreLastPage(function(){var oid=VOrder.params.oid;if(oid&&!VOrder.orderloaded){GDT.util.showMsgbox('广告数据加载中，请稍候……',6,10000);GDT.cgiOrder.getById(oid,function(d){var oridata,data={},localData,tm,today,crtsizeList=[];GDT.util.hideMsgbox();if(d.ret===0){VOrder.orderloaded=true;oridata=d.data;J.extend(true,VOrder.originData,oridata);J.extend(true,data,oridata);J.each(oridata.creatives,function(crtsize,item){var isCrtDeleted=true;J.each(item,function(tid,v){if(v.status!=GDT.ENV.STATUS_DELETED){isCrtDeleted=false;return false;};});if(isCrtDeleted){delete data.creatives[crtsize];}else{crtsizeList.push(crtsize);}});data.crt_size=crtsizeList.join('-');VOrder.getLocalCacheData();localData=MOrder.getOrderCacheData();J.extend(data,localData);if(VOrder.isClone){delete data.aindex;delete data.orderid;delete data.aid;data.ordername+=' 副本';tm=GDT.gEnv.servertime*1000;today=QZFL.string.timeFormatString(tm,'{Y}-{M}-{d}');if(data.launchdate[0]<today){data.launchdate[0]=today;}
if(data.launchdate[1]<today){data.launchdate[1]=QZFL.string.timeFormatString(tm+VOrder.CONST.DAYS3,'{Y}-{M}-{d}');}}
J.extend(data,MOrder.getOrderCacheData('userrules')||{});MOrder.setOrderCacheData(data);pageletHandler.handler(function(){VOrder.viewController.renderFooter(pageletHandler);});GDT.timepot.renderEnd=+new Date;}else{GDT.util.showMsgbox(d.msg||'获取广告信息出错，请刷新重试',5);}});}else{VOrder.getLocalCacheData();pageletHandler.handler(function(){VOrder.viewController.renderFooter(pageletHandler);});VOrder.params.step=='basic'&&(GDT.timepot.renderEnd=+new Date);}});});J.publish('/pagelet/load',pagelet);GDT.page.init();},needRestoreLastPage:function(callback){var lastUrl=GDT.helper.hasLocalCacheData()||'',curUrl=location.href,isOrderChanged=false,compareUrl;if(VOrder.isEdit||VOrder.isClone){compareUrl=lastUrl.replace(/(\?|&)restore=1/,'');curUrl=curUrl.replace(/(\?|&)restore=1/,'');isOrderChanged=compareUrl&&compareUrl!=curUrl?true:false;}else{isOrderChanged=lastUrl&&curUrl.indexOf('restore=1')<0?true:false;}
if(isOrderChanged){var cf=new GDT.util.Confirm('请确认：','您的操作会覆盖之前编辑中的内容，确定要继续吗？',{'icontype':'warn','type':QZFL.widget.Confirm.TYPE.OK_NO,'hastitle':false,'height':120,'tips':['继续','取消']});cf.onConfirm=function(){MOrder.clearOrderCacheData();VOrder.clearLocalCacheData();callback();};cf.onNo=function(){window.onbeforeunload=null;location.href=lastUrl;};cf.show();}else{callback();}},renderHeader:function(pageletConfig){var step=pageletConfig.step,pageletMapping=this.pageletMapping,stepList,cont=[],steps;cont.push('<h2 class="create-step-title">'+(VOrder.isClone?'复制广告':(VOrder.isEdit?'编辑广告':'新建广告'))+'</h2>');stepList=this.getPageletSteps();steps=stepList.length;cont.push('<ul class="create-step-area">');J.each(stepList,function(i,step){var stepname=pageletMapping[step].label,isLast,currentStep=i+1;isLast=steps==currentStep;cont.push('<li class="s'+currentStep+'">'+stepname+'<i class="create-step-dot"></i><i class="create-setp-grayline"></i></li>');});cont.push('</ul>');cont.push('<div class="create-step-line"></div>');J('#viewProcess').attr('class','').addClass('create-step create-step'+pageletConfig.step).html(cont.join('')).show();},renderFooter:function(pageletConfig){var cont=[],evtList={},wrap=J('#wrapButton'),map=buttonMapping;if(pageletConfig.footer===false){return;}
J.each(pageletConfig.button||[],function(i,btn){cont.push(map[btn].tpl);});J.each(map,function(btn,item){evtList[btn]=map[btn].handler;});wrap.hide().html(cont.join(''));GDT._cgiGetterCounter=0;GDT._cgiGetterCounter++;setTimeout(function(){GDT._cgiGetterCounter--;wrap.show();},500);if(!VOrder.bindFooterEvent){VOrder.bindFooterEvent=true;QBL.delegate(wrap.get(0),'click',evtList,{preevent:function(evt){var pagelet=VOrder.params.step||'basic',skipValidate,distance,pass=true,fields;if(GDT._cgiGetterCounter>0){GDT.util.showMsgbox('请等待页面资源加载完毕',6,1000);return false;}
if(J(evt.target).attr('data-disabled')){return false;};skipValidate=parseInt(this.getAttribute('data-skipvalidate'));if(skipValidate){VOrder.isAsyncDataLoaded=true;MOrder.clearInvalidFields();}else{if(!VOrder.isAsyncDataLoaded){GDT.util.showMsgbox('请等待数据获取完成，再重试一次',6);return false;}
fields=VOrder.getPageletFields(pagelet);MOrder.validate(fields);if(MOrder.invalidFileds.length>0){pass=false;var firstField;J.each(MOrder.invalidFileds,function(field,val){if(field!='length'){firstField=field.split(GDT.ENV.SELECTOR_KEY_KEY);firstField=firstField.shift();return false;}});firstField&&firstField!='crtsize'&&VOrder.scrollToError(J('[name='+firstField+']'));GDT.log('invalid field parameters: '+QBL.stringify(MOrder.invalidFileds));}}
pass&&J.publish('/pagelet/unload',pagelet);}});}}};})();VOrder.scrollToErrorTimer=null;VOrder.scrollToError=function(errNode){clearTimeout(VOrder.scrollToErrorTimer);VOrder.scrollToErrorTimer=setTimeout(function(){typeof errNode==='string'&&(errNode=J('#'+errNode));if(errNode.size()>0){errNode=errNode.eq(0);if(errNode.attr('type')=='hidden'){errNode=errNode.parent();}
J("body, html").animate({scrollTop:errNode.offset().top-100},{duration:300,easing:"swing"});}},200);};VOrder.fieldsConfig={};VOrder.getConfigValue=function(field){return VOrder.fieldsConfig[field].value;};VOrder.appendFieldsConfig=function(configs){J.extend(VOrder.fieldsConfig,configs);};GDT.log('fields conf',VOrder.fieldsConfig);VOrder.genFieldsConfig=function(pagelet){var result={};config=VOrder.viewController.pageletMapping[pagelet];if(!config){throw'error pagelet:'+pagelet;}
J.extend(true,result,config.pagelet);J.each(result,function(i,item){var fields=item.fields.concat(item.dynamicFields);J.each(fields,function(j,name){result[i].fields[j]=VOrder.fieldsConfig[name];});});return result;};VOrder.getPageletFields=function(pagelet){var fields=[],pfs;pfs=VOrder.viewController.pageletMapping[pagelet];J.each(pfs.pagelet,function(pk,pconfig){fields=fields.concat(pconfig.fields).concat(pconfig.dynamicFields);});return fields;};VOrder.setPageletDynamicFields=function(fields,pagelet,op){var pfs,oDynamicFields,nDynamicFields;GDT.log('view order |1008| setPageletDynamicFields',fields,pagelet,op);typeof fields!=='object'&&(fields=[fields]);pagelet=pagelet||VOrder.params.step;pfs=VOrder.viewController.pageletMapping[pagelet];oDynamicFields=pfs.pagelet[0].dynamicFields;MOrder.clearInvalidFields(oDynamicFields);if(op==='append'){nDynamicFields=oDynamicFields;J.each(fields,function(i,field){if(typeof oDynamicFields[field]==='undefined'){nDynamicFields.push(field);}});}else if(op==='remove'){nDynamicFields=[];J.each(oDynamicFields,function(i,field){if(J.inArray(field,fields)<0){nDynamicFields.push(field);}else{MOrder.clearInvalidFields(field);}});}else{nDynamicFields=fields;}
pfs.pagelet[0].dynamicFields=nDynamicFields;GDT.log('view order |1043| after setPageletDynamicFields',pfs.pagelet[0].dynamicFields);};VOrder.getOrderTargetStr=function(da){var list,ur={},str='';ur=GDT.helper.getuserrules(da);ur.area=ur.area?(ur.area+'').split(','):'';ur.ageseg=ur.ageseg?(ur.ageseg+'').split(','):'';str=GDT.helper.getOrderTargetStr(ur,function(ur,data){list=[];ur.area&&J.each(ur.area,function(k,id){if(!((QBL.AreaSelector.judgeCodeType(id)=='inside')&&id.toString().length>4)){var _l=QBL.AreaSelector&&QBL.AreaSelector.getNameById(id);_l&&list.push(_l.replace(/[A-Z\s]/,''));}});data.areastr=list.join(',');},da);return str;};VOrder.renderPagelet=function(pagelet,callback){var fieldsConfig=VOrder.genFieldsConfig(pagelet),js=[],jsreadyCallback=[],wrapMap={basic:'innerBasic',creative:'innerCreative',targeting:'innerTargeting',targetpack:'innerTargeting',preview:'innerPreview'},wrap,preloadFns={};GDT.log('fields to render ',fieldsConfig);wrap=J('#'+wrapMap[pagelet]);if(wrap.children().size()>0){wrap.parent().show();callback&&callback();return;};J.each(fieldsConfig,function(i,block){J.each(block.fields,function(k,cfg){var fieldname;if(!cfg||cfg.forbidden){return;}
fieldname=cfg.name;cfg.js&&(J.isArray(cfg.js)?(js=js.concat(cfg.js)):js.push(cfg.js));cfg.jsready&&(jsreadyCallback.push([cfg.jsready,fieldname]));typeof cfg.items==='function'&&(preloadFns[fieldname]=cfg.items);});});GDT.log('Pagelet load js: '+js.join(','));if(js&&js.length){GDT.load(js,function(){J.each(jsreadyCallback||[],function(i,fncfg){var fieldname=fncfg[1],fn=fncfg[0],instance;instance=MOrder.getInstance(fieldname);if(instance){fn.call(instance);}});J.each(MOrder.instanceToInit,function(i,instance){if(J.inArray(instance.type,['radio','checkbox'])>=0&&instance.value){if(typeof instance.value!=='object'&&instance.name!='linktype'){J('[name='+instance.name+'][value='+instance.value+']',J('#'+instance.name+'ItemsWrap')).trigger('click');}}});J.each(preloadFns,function(name,fn){var instance=MOrder.getInstance(name);fn.call(instance);});callback&&callback();});}else{callback&&callback();}
MOrder.render(wrapMap[pagelet],fieldsConfig);J('#'+wrapMap[pagelet]).delegate('input[type=text],textarea','blur',function(){var m=this.id.match(/\_(\d+?)\_/);if(J.inArray(this.name,['desc','title'])!=-1&&m&&m[1]&&J.inArray(parseInt(m[1],10),GDT.ENV.NONEEDTOCLEANFULLSPACE_CRTSIZE_ARR)!=-1){this.value=GDT.util.trimWithoutPreEmSpace(this.value);}
else{this.value=J.trim(this.value);}});};VOrder.restorePagelet=function(fieldsConfig){var fieldMapping={'sdate+edate':'launchdate','alltime':(function(){if(VOrder.isEdit||VOrder.isClone){var timeset=MOrder.getOrderCacheData('timeset'),alltime;if(timeset==GDT.timeutil.makeFullTimeStr()){alltime=1;}else{alltime=0;}
MOrder.setOrderCacheData('alltime',alltime);}
return'alltime';})()},orderData=MOrder.getOrderCacheData()||{};J.each(fieldsConfig,function(field,fieldCfg){var instance,value,fkey;fkey=fieldMapping[field]||field;value=fieldCfg.value||orderData[fkey];if(value===0||value){instance=MOrder.getInstance(field);if(instance){if(instance.setValueParams){value=MOrder.getOrderCacheData(instance.setValueParams);instance.setValue(value);}else{instance.setValue(value);}}}});};VOrder.positionPreview={data:{},show:function(crtsize){var posinfo=VOrder.positionPreview.data[crtsize],elId='positionPreviewWrap',cont=[],tpl,tplPic,wrap;tplPic='<div class="adpreview"><img src="{THUMB}" alt="{NAME}"><a href="{PIC}" target="_blank" class="enlarge" data-src="{PIC}" opt="crtsizepreview"><i class="icon ico-enlarge"></i>预览大图</a></div>';tpl='<div class="adshow-box">{TPL_PIC}<p class="wd-intro pd-t10">{NAME}</p></div>';J.each(posinfo||{},function(i,pos){var picstr=pos.pic?tplPic.replace(/{THUMB}/g,pos.thumb).replace(/{PIC}/g,pos.pic).replace(/{NAME}/g,pos.name):'';cont.push(tpl.replace(/{TPL_PIC}/g,picstr).replace(/{NAME}/g,pos.name));});J('#'+elId).remove();if(cont.length<1){return;}
wrap=J('[name=crtsize][value='+crtsize+']').parents('p').get(0);J('<div class="adshow clearfix" id="'+elId+'">').html(cont.join('')).insertAfter(wrap);},_imgholder:null,showPop:function(imgurl){J('.preview-large').remove();var oimg=new Image();oimg.src=imgurl;VOrder.positionPreview._imgholder=oimg;var f=function(){var tpl='<div class="preview-large" style="top:{TOP}px;left:{LEFT}px"><img src="{IMGSRC}" alt="广告位位置示意"><a href="javascript:;" class="close-preview" onclick="this.parentNode.parentNode.removeChild(this.parentNode);return false;">关闭</a></div>',cont,top,left,w0=this.width||400,h0=this.height||400,winW=QZFL.dom.getClientWidth(),winH=QZFL.dom.getClientHeight();left=Math.abs((winW-w0))/2;top=(h0>winH?15:Math.abs((winH-h0))/2)+QZFL.dom.getScrollTop();cont=tpl.replace(/{TOP}/g,top).replace(/{LEFT}/g,left).replace(/{IMGSRC}/g,imgurl);J(cont).appendTo(document.body);};if(oimg.complete){f.call(oimg);}else{oimg.onload=function(){f.call(this);oimg.onload=null;};oimg.onerror=function(){GDT.util.showMsgbox('拉取预览图片失败， 请稍候再试！',2,3000);oimg.onerror=null;};}
return false;}};VOrder._isGetLocalCacheData=false;VOrder.getLocalCacheData=function(){var data,localData,cacheData,storeKey;if(!VOrder.params.restore){return;}
if(VOrder._isGetLocalCacheData){return;}
VOrder._isGetLocalCacheData=true;storeKey=VOrder.genLocalCacheId();data=QBL.storage.get(storeKey,'local');GDT.log('get local cache data:',data);if(data){cacheData=MOrder.getOrderCacheData();localData={};if(!J.isEmptyObject(cacheData)){J.each(cacheData,function(key,val){if(key in data){localData[key]=data[key];}});}else{localData=data;}
GDT.log('get local cache data:',localData);MOrder.setOrderCacheData(localData);}};VOrder.setLocalCacheData=function(type){var data,lastUrl,step=VOrder.params.step,fields=[],storeKey;data=MOrder.getOrderCacheData();if(step=='basic'||step=='creative'){J.each(VOrder.viewController.pageletMapping.basic.pagelet,function(i,item){fields=fields.concat(item.fields).concat(item.dynamicFields);});J.extend(data,MOrder.getValue(fields));}else if(step=='targeting'){J.extend(data,GDT.viewOrderTargeting.getTarget('targeting'));}
GDT.log('set local cache data:',data);if(data.sdate&&data.edate){data.launchdate=[data.sdate,data.edate];delete data.sdate;delete data.edate;};storeKey=VOrder.genLocalCacheId();QBL.storage.set(storeKey,data,{media:'local',expire:3000000});lastUrl=location.href;lastUrl+=/restore=1/.test(lastUrl)?'':(lastUrl.indexOf('?')<0?'?':'&')+'restore=1';QBL.storage.set('oLCD_lastUrl',lastUrl,{media:'local',expire:3000000});};VOrder.clearLocalCacheData=function(type){var data,storeKey;storeKey=VOrder.genLocalCacheId();QBL.storage.del(storeKey,'local');QBL.storage.del('oLCD_lastUrl','local');};VOrder.genLocalCacheId=function(){var type,id,storeKey='oLCD_';if(VOrder.params.step=='targetpack'){type='mid';}else{type=(VOrder.isClone?'clone_':'')+'oid';}
id=VOrder.params[type]||('uid_'+GDT.account.getLoguin());storeKey+=type+'_'+id;return storeKey;};VOrder.params={};VOrder.originData={};VOrder.init=function(){var pagelet;J.each([location.hash.substring(1).split('&'),location.search.substring(1).split('&')],function(n,params){J.each(params,function(i,ps){var p=ps.split('=');VOrder.params[p[0]]=p[1]||'';});});VOrder.isClone=VOrder.params.clone?true:false;VOrder.isEdit=VOrder.params.oid&&!VOrder.isClone?true:false;pagelet=VOrder.params.step||'basic';VOrder.viewController.showPagelet(pagelet);VOrder.isSubmited=false;window.onbeforeunload=function(evt){var data;if(!VOrder.isSubmited){VOrder.setLocalCacheData();}};GDT.helper.initBackToTop();};VOrder.validate=GDT.validate;})(GDT.viewOrderEdit=GDT.viewOrderEdit||{},GDT.modOrder);(function(FormManage){var f={};function indexForm(list){var typemap=GDT.confCrttypeNameMapping;J.each(list,function(k,v){v.typename=typemap[v.crt_ype];v.imgsize=v.img_width?v.img_width+'px ×  '+v.img_height+'px':'';(v.crt_type==6)&&(v.imgsize+=' + '+v.ext_img_width+'px ×  '+v.ext_img_height+'px');f[v.crt_size]=v;});}
FormManage.formlistCallback=function(o){if(o&&(o.ret==0)&&o.data&&o.data.list){var olist=o.data.list;indexForm(olist);}};FormManage.getFormlist=function(siteset,callback,opts){var opts=opts||{},linktype;linktype=opts.linktype||'';GDT.cgiOrder.getFormlist({'siteset':siteset,'linktype':linktype},function(d){FormManage.formlistCallback(d);if(callback){callback(d);}});};FormManage.getFormInfo=function(fid){return f[fid];};FormManage.getFormInfoAsyn=function(fid,callback,opts){var info;opts=opts||{};info=f[fid];if(info){callback(info);}else{FormManage.getFormlist(opts.siteset,function(o){info=f[fid];callback(info);},opts);}};FormManage.filterFormat=function(ft){var list=[];if(FormManage.formlist){J.each(FormManage.formlist,function(k,v){if(v.formtype==ft){list.push(v);}});}};})(GDT.FormManage={});