<#include "/admin/layout/layout.ftl">
<#import "/admin/layout/macro.ftl" as macro>
<#assign css>
<style>
</style>
</#assign>
<#assign js>
<script>
    function del(id) {
        layer.confirm('确定删除吗?', {icon: 3, title: '提示'}, function (index) {
            $.ajax({
                type: "POST",
                dataType: "json",
                url: "${ctx!}/admin/dev/delete/" + id,
                success: function (res) {
                    layer.msg(res.message, {time: 2000}, function () {
                        location.reload();
                    });
                }
            });
        });
    }
</script>

</script>
</#assign>
<@layout title="设备管理" active="dev">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        设备列表
        <small>查看当前注册设备</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-cog"></i> 系统</a></li>
        <li><a href="#"><i class="fa fa-list-ul"></i> 设备管理</a></li>
        <li class="active"><i class="fa fa-table"></i> 设备列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- Default box -->
    <div class="box box-primary">
        <div class="box-header">
       <#-- <@shiro.hasPermission name="system:user:add">
            <a class="btn btn-sm btn-success" href="${ctx!}/admin/user/add">注册新用户</a>
        </@shiro.hasPermission>-->
        </div>
        <div class="box-body">
            <table class="table table-striped">
                <tr>
                    <th>DeviceID</th>
                    <th>设备名</th>
                    <th>语音端口号</th>
                    <th>控制端口号</th>
                    <th>当前状态</th>
                </tr>
                <#list pageInfo.content as devInfo>
                <tr>
                    <td>${devInfo.id}</td>
                    <td>${devInfo.name}</td>
                    <td>${devInfo.port_a}</td>
                    <td>${devInfo.port_c}</td>
                    <td>
                        <#if (.now?string("yyyy-MM-dd HH:mm")= devInfo.update_time?string("yyyy-MM-dd HH:mm"))&&((.now?string("ss")?eval-devInfo.update_time?string("ss")?eval ) <= 30)>
                            <span class="label label-info">ON</span>
                        <#else >
                            <span class="label label-danger">OFF</span>
                        </#if>
                    </td>
                    <#--<td>${devInfo.update_time?string("mm")}</td>-->
                    <td>
                    <@shiro.hasPermission name="system:dev:edit">
                        <a class="btn btn-sm btn-primary" href="${ctx!}/admin/dev/show/${devInfo.id}">编辑</a>
                    </@shiro.hasPermission>
                  <#--  <@shiro.hasPermission name="system:user:grant">
                        <a class="btn btn-sm btn-warning" href="${ctx!}/admin/user/grant/${userInfo.id}">分配角色</a>
                    </@shiro.hasPermission>-->
                    <@shiro.hasPermission name="system:user:deleteBatch">
                        <button class="btn btn-sm btn-danger" onclick="del(${devInfo.id})">删除</button>
                    </@shiro.hasPermission>
                    </td>
                </tr>
                </#list>
            </table>
        </div>
        <!-- /.box-body -->
        <div class="box-footer clearfix">
            <@macro.page pageInfo=pageInfo url="${ctx!}/admin/dev/index?" />
        </div>
    </div>
    <!-- /.box -->

</section>
<!-- /.content -->
</@layout>