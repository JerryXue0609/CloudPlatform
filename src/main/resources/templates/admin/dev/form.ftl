<#include "/admin/layout/layout.ftl">
<#import "/admin/layout/macro.ftl" as macro>
<#assign css>

</#assign>
<#assign js>
<script>
    $(".btn-submit").click(function () {
        $.ajax({
            type: "POST",
            url: "${ctx!}/admin/dev/edit",
            data: $(".form-edit").serialize(),
            dataType: "JSON",
            success: function(res){
                layer.msg(res.message, {time: 1000
                }, function(){
                    location.reload();
                });
            }
        });
    });
</script>
</#assign>
<@layout title="设备编辑" active="dev">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        设备编辑
        <small>修改设备信息</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-cog"></i> 系统</a></li>
        <li><a href="#"><i class="fa fa-list-ul"></i> 设备管理</a></li>
        <li class="active"><i class="fa fa-edit"></i> 设备编辑</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-10">
            <!-- Default box -->
            <div class="box  box-primary">
                <form class="form-horizontal form-edit" method="post" action="${ctx!}/admin/dev/edit">
                    <div class="box-body">
                        <input type="hidden" id="id" name="id" value="${device.id}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">设备名称：</label>
                            <div class="col-sm-10">
                                <input id="name" name="name" class="form-control" type="text" value="${device.name}"  >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">语音端口：</label>
                            <div class="col-sm-10">
                                <input id="port_a" name="port_a" class="form-control" type="text" value="${device.port_a}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">控制端口：</label>
                            <div class="col-sm-10">
                                <input id="port_c" name="port_c" class="form-control" type="text" value="${device.port_c}" >
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-default btn-back">返回</button>
                        <button type="button" class="btn btn-info pull-right btn-submit">提交</button>
                    </div>
                </form>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<!-- /.content -->
</@layout>
