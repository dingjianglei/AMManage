<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../common/header.jspf"%>
<body>
<table id="dg" title="送货单列表" class="easyui-datagrid"
       toolbar="#toolbar" pagination="true"
       rownumbers="true" fitColumns="true" singleSelect="false" fit="true">
</table>
<div id="toolbar" align="left" style="height: auto">
    <div id="showMenu"></div>

    <form id="searchForm">
    <div style="line-height:1px; background:#ccc;width:100%;margin:0 auto 0 auto;">&nbsp;</div>
    <label>客户名称:</label><input type="text" class="easyui-textbox" id="customerName" name="deliveryNote.customerName"/>
    <label>送货单号:</label><input type="text" class="easyui-textbox" id="deliverNo" name="deliveryNote.deliverNo"/>
    <label>制单日期:</label><input type="text" class="easyui-textbox" id="beginDeliverDate" />
    <a href="#" class="easyui-linkbutton" onclick="doSearch()" data-options="iconCls:'icon-search'">查询</a>
    </form>
</div>
</body>

<script type="text/javascript">
    showMenu('14')
    $('#dg').datagrid({
        url:'getInvoiceZhListJson.htm',
        pageNumber:1,//当前页码
        pageSize:8,
        pageList:[8,16,32],
        pagination:true,
        queryParams:{},
        columns:[[
            {field:'id',checkbox:'true'},
            {field:'customerName',title:'客户名称',width:"20%"},
            {field:'deliverNo',title:'送货单号',width:"20%"},
            {field:'relationOrderType',title:'对应订单类型',width:"20%",formatter:formatterRelationOrderType},
            {field:'deliverDate',title:'制单日期',width:"20%",formatter:formatterdate},
            {field:'deliverNo',title:'关联订单操作',width:"20%",formatter:relationOperation}
        ]]
    });


    function exportWord(){
        window.location.href='manufactureOrder-exportWord.htm';
    }
    function add(){
        toolsAdd('新增送货单','/manager/invoice-zh-add.htm');
    }
    function edit(){
        toolsEdit('编辑送货单','/manager/invoice-zh-edit.htm','id');
    }
    function show(){
        toolsShow('查看送货单','/manager/invoice-zh-show.htm','id')
    }
    function destroy(){
        toolDestroy('zhInvoice-delete.htm','id');
    }
    function exportFile(){
        var rows= $('#dg').datagrid('getSelections');
        if(rows.length==0){
            $.messager.alert("操作提示", "请选择一项！","info");
        }else if(rows.length>1){
            $.messager.alert("操作提示", "只能选择一项数据！","info");
        }else{
            var orderNo=rows[0]['orderNo'];
            if(orderNo&&orderNo!=null&&orderNo!=''){
                toolExport('zhInvoiceAction-exportWord.htm?id=','id');
            }else{
                $.messager.alert("操作提示", "您选中的发票信息未关联订单信息，暂不可导出！","info");
            }
        }
    }
    function formatterRelationOrderType(val){
        if(val=='1'){
            return '生产单';
        }else if(val=='2'){
            return '采购单';
        }else{
            return '<font color="red">未知</font>';
        }
    }
    function relationOrder(id){

    }
    function relationOperation(id,row){
        var orderNo=row.orderNo;
        if(orderNo&&orderNo!=null&&orderNo!=''){
            return '<a>查看</a><a>修改</a>'
        }else{
            return '<a href="javascript:relationOrder('+row.id+')">关联</a>'
        }
    }
</script>
</html>
