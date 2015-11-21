<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../common/header.jspf"%>
    <link rel="stylesheet" type="text/css" href="<%=contextPath %>/css/newtable.css" />
    <style type="text/css">
        .text-left{ text-align: left}
        .text-right{ text-align: right}
        .text-center{ text-align: center}
        .none_right_border{ border-right: 0; border-left: 0;}
        table tr{ line-height: 30px;}
        .title{
            text-align:center;font-size: 20px; font-weight: bold; color: #000000;
        }
        .invoiceTab tr td input{border: 0; border-bottom: 1px solid gray; outline: none;font-weight: bold; color: #0000ff;}
        .maininfo td{ text-align: center; height: 30px;}
        .maininfo td input{ text-align: center; }
    </style>
<script>
    $(function(){
        $('input[type=text][required=true]').validatebox();
        var paymentType_val=$('#paymentType_val').val();
        $('#paymentType_sel').val(paymentType_val);
        var relationOrderType=$('#relationOrderType').val();
        if(relationOrderType=='1'){
            $('input[type="radio"]:eq(0)').attr("checked",'checked');
        }else if(relationOrderType=='2'){
            $('input[type="radio"]:eq(1)').attr("checked",'checked');
        }
    });
    function saveEnInvoice(){
        var url='enInvoiceEditSave.htm';
        $('#form1').form('submit',{
            url: url,
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.errorMsg){
                    $.messager.show({
                        title: 'Error',
                        msg: result.errorMsg
                    });
                }else{
                    $.messager.alert('操作提示','修改成功','info',function(){
                        location.reload();
                    });
                }
            }
        });
    }
    function formReset(){
        $("input[name='res']").click();
    }
</script>
<body LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0
      scroll=yes>
<form  id="form1" method="post" >
    <TABLE class="invoiceTab" WIDTH="80%" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#fff">
        <tr>
            <td colspan="5" class="title" >上海傲美实业有限公司</td>
        </tr>
        <tr>
            <td colspan="5" class="text-center">
                2nd Floor, 2-575 Changxiang Road, Nanxiang Town, Jiading District, Shanghai 201802, China
            </td>
        </tr>
        <tr>
            <td colspan="5"  class="title">
                商业发票
                <input type="hidden" name="enCommercialInvoice.id" value="${enCommercialInvoice.id}"/>

                <input type="hidden" name="enCommercialInvoice.createUserid" value="${user.id}"/>
            </td>
        </tr>
        <tr>
            <td colspan="5"  class="title">
                COMMERCIAL INVOICE
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <input type="hidden" id="relationOrderType" value="${enCommercialInvoice.relationOrderType}">
                对应订单类型&nbsp;&nbsp;<input name="enCommercialInvoice.relationOrderType" value="1" type="radio" checked="true" />生产单<input name="enCommercialInvoice.relationOrderType" value="2" type="radio"/>采购单
            </td>
        </tr>
        <tr>
            <td colspan="3">TO:<input type="text" style="width: 300px;" name="enCommercialInvoice.toCompany" value="${enCommercialInvoice.toCompany}"/></td>
            <td class="text-right">Invoice Number:</td>
            <td><input type="text" name="enCommercialInvoice.invoiceNumber" value="${enCommercialInvoice.invoiceNumber}"/></td>
        </tr>
        <tr>
            <td colspan="3"></td>
            <td class="text-right">Re:</td>
            <td><input type="text" name="enCommercialInvoice.reInfo" value="${enCommercialInvoice.reInfo}"/></td>
        </tr>
        <tr>
            <td colspan="3">FROM: Shanghai Ao Mei Industrial Co., Ltd.<input name="enCommercialInvoice.fromCompany" value="Shanghai Ao Mei Industrial Co., Ltd." type="hidden"></td>
            <td class="text-right">制单日期:</td>
            <td>
                <input class="Wdate" type="text" name="enCommercialInvoice.docTrade" value='<s:date name="enCommercialInvoice.docTrade" format="yyyy-MM-dd"/>' style="cursor: pointer" onFocus="WdatePicker({isShowClear:false})"/>
            </td>
        </tr>
        <tr>
            <td colspan="3"></td>
            <td class="text-right">出货日期:</td>
            <td>
                <input class="Wdate" type="text" name="enCommercialInvoice.shipmentDate" value="<s:property value='enCommercialInvoice.shipmentDate'/>"  style="cursor: pointer" onFocus="WdatePicker({isShowClear:false})"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">装船口岸 From: SHANGHAI CHINA
                <input name="enCommercialInvoice.seaportFrom" value="SHANGHAI CHINA" type="hidden">
            </td>
            <td colspan="3">目的地 To: <input type="text" value="${enCommercialInvoice.destinationTo}" name="enCommercialInvoice.destinationTo" style="width: 300px;"/></td>
        </tr>
        <tr>
            <td colspan="2">PAYMENT : <input type="text" value="${enCommercialInvoice.payment}" name="enCommercialInvoice.payment" style="width: 30px;">%
                <input type="hidden" value="${enCommercialInvoice.paymentType}" id="paymentType_val">
                <select  name="enCommercialInvoice.paymentType" id="paymentType_sel">
                    <option value="T/T">T/T</option>
                    <option value="D/P">D/P</option>
                    <option value="D/A">D/A</option>
                    <option value="M/T">M/T</option>
                </select>
            </td>
            <td colspan="3">开证银行 Issued by:<input type="text" value="${enCommercialInvoice.destinationTo}" name="enCommercialInvoice.issuedBy" style="width: 300px;"></td>
        </tr>
        <tr>
            <td class="text-center">订单编号</td>
            <td class="text-center" colspan="2">货物描述</td>
            <td class="text-center">单价</td>
            <td class="text-center">总价</td>
        </tr>
        <tr>
            <td class="text-center">PO</td>
            <td class="text-center">Name</td>
            <td class="text-center">PSC</td>
            <td class="text-center">Unit Price EXW OR CIF SHANGHAI (1000PCS)</td>
            <td class="text-center">Total Amount USD</td>
        </tr>
        <s:iterator value="enCommercialInvoice.enciOrders" var="item" status="status">
            <tr class="maininfo">
                <td>
                    <input type="text" name="enCommercialInvoice.enciOrders[${status.index}].orderNo" value="<s:property value="#item.orderNo"/>"/>
                    <input type="hidden" name="enCommercialInvoice.enciOrders[${status.index}].id" value="<s:property value="#item.id"/>"/>
                    <input type="hidden" name="enCommercialInvoice.enciOrders[${status.index}].enciId" value="<s:property value="#item.enciId"/>"/>
                </td>
                <td><input type="text" name="enCommercialInvoice.enciOrders[${status.index}].goodsDesc" value="<s:property value="#item.goodsDesc"/>"/></td>
                <td><input type="text" name="enCommercialInvoice.enciOrders[${status.index}].price" value="<s:property value="#item.price"/>"/></td>
                <td><input type="text" name="enCommercialInvoice.enciOrders[${status.index}].psc" value="<s:property value="#item.psc"/>"/></td>
                <td><input type="text"name="enCommercialInvoice.enciOrders[${status.index}].totalAmount" value="<s:property value="#item.totalAmount"/>"/></td>
            </tr>
        </s:iterator>

        <tr>
            <td colspan="5">Followings is the bank information of Shanghai Ao Mei Industrial Co., Ltd. </td>
        </tr>
        <tr>
            <td style="border-right: 0">&nbsp;</td>
            <td colspan="4" style="border-left: 0">Company Name: Shanghai Ao Mei Industrial Co., Ltd.	</td>
        </tr>
        <tr>
            <td style="border-right: 0">&nbsp;</td>
            <td colspan="4" style="border-left: 0">Account: OSA11443631363633</td>
        </tr>
        <tr>
            <td style="border-right: 0">&nbsp;</td>
            <td colspan="4" style="border-left: 0">SWIFT： SPDBCNSHOSA</td>
        </tr>
        <tr>
            <td style="border-right: 0">&nbsp;</td>
            <td colspan="4" style="border-left: 0">Bank Name: SHANGHAI  PUDONG  DEVELOPMENT  BANK</td>
        </tr>
        <tr>
            <td style="border-right: 0">&nbsp;</td>
            <td colspan="4" style="border-left: 0">Bank Address: No.12  ZHONG  SHAN  DONG  YI  LU , SHANGHAI , CHINA</td>
        </tr>
    </TABLE>
    <div id="button" style="margin-top: 20px;">
        <a href="javascript:void(0)" onclick="saveEnInvoice()" class="easyui-linkbutton" style="width: 100px;">提交</a> &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width: 100px;" onclick="formReset()">重置</a>
        <input id="res" name="res" type="reset" style="display:none;" />
    </div>
</form>
</body>
</html>
