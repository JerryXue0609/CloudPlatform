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
                async:false,
                url: "${ctx!}/admin/user/delete/" + id,
                success: function (res) {
                    layer.msg(res.message, {time: 2000}, function () {
                        location.reload();
                    });
                }
            });
        });
    }
    function search() {
        var search = $('#search').val();
        $.ajax({
            url: "${ctx!}/admin/user/search" ,
            type: "GET",
            data: {"search":search},
            dataType: "json",
            success:function(res){
                window.location.href="/admin/user/search";
            }
        });
    }
</script>
</#assign>
<@layout title="用户管理" active="user">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        用户列表
        <small>一切从这里开始</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-cog"></i> 系统</a></li>
        <li><a href="#"><i class="fa fa-list-ul"></i> 用户管理</a></li>
        <li class="active"><i class="fa fa-table"></i> 用户列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- Default box -->
    <div class="box box-primary">
        <div class="box-header">
        <@shiro.hasPermission name="system:user:add">
            <a class="btn btn-sm btn-success" href="${ctx!}/admin/user/add">注册新用户</a>
        </@shiro.hasPermission>
           <#-- <input type="text" name="username"  id="search"/> <button class="btn btn-sm btn-danger" onclick="search()">搜索</button>
            -->
            <div class="row" style="width:30%;float: right">
              <form id="form" action="${ctx!}/admin/user/search" method="get">
                  <table>
                      <tr>
                          <td> <input type="username" name="username" class="form-control" placeholder="username"></td>
                          <td><input type="submit" class="btn btn-primary btn-block btn-flat btn-sign" value="查询"></td>
                      </tr>
                  </table>
            </form>
            </div>
        </div>
        <div class="box-body">
            <table class="table table-striped">
                <tr>
                    <th>ID</th>
                    <th>账户名</th>
                    <th>昵称</th>
                    <th>删除状态</th>
                    <th>锁定</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                <#list pageInfo.content as userInfo>
                <tr>
                    <td>${userInfo.id}</td>
                    <td>${userInfo.userName}</td>
                    <td>${userInfo.nickName}</td>
                    <td>
                        <#if userInfo.deleteStatus == 1>
                            <span class="label label-danger">已删除</span>
                        <#else>
                            <span class="label label-info">未删除</span>
                        </#if>
                    </td>
                    <td>
                        <#if userInfo.locked == 1>
                            <span class="label label-danger">已锁定</span>
                        <#else>
                            <span class="label label-info">未锁定</span>
                        </#if>

                    </td>
                    <td>${userInfo.createTime}</td>
                    <td>
                    <@shiro.hasPermission name="system:user:edit">
                        <a class="btn btn-sm btn-primary" href="${ctx!}/admin/user/edit/${userInfo.id}">编辑</a>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="system:user:grant">
                        <a class="btn btn-sm btn-warning" href="${ctx!}/admin/user/grant/${userInfo.id}">分配角色</a>
                    </@shiro.hasPermission>
                    <@shiro.hasPermission name="system:user:deleteBatch">
                        <button class="btn btn-sm btn-danger" onclick="del(${userInfo.id})">删除</button>
                    </@shiro.hasPermission>
                    </td>
                </tr>
                </#list>
            </table>
        </div>
        <!-- /.box-body -->
        <div class="box-footer clearfix">
            <@macro.page pageInfo=pageInfo url="${ctx!}/admin/user/index?" />
        </div>
    </div>
    <!-- /.box -->

</section>
<!-- /.content -->
</@layout>