<#include "/admin/layout/layout.ftl">
<#import "/admin/layout/macro.ftl" as macro>
<#assign css>

</#assign>
<#assign js>
<script>
    $(".btn-submit").click(function () {
        $.ajax({
            type: "POST",
            url: "${ctx!}/admin/user/edit",
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
<@layout title="用户编辑" active="user">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        用户编辑
        <small>编辑用户详细信息</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-cog"></i> 系统</a></li>
        <li><a href="#"><i class="fa fa-list-ul"></i> 用户管理</a></li>
        <li class="active"><i class="fa fa-edit"></i> 用户编辑</li>
    </ol>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-10">
            <!-- Default box -->
            <div class="box  box-primary">
                <form class="form-horizontal form-edit" method="post" action="${ctx!}/admin/user/edit">
                    <div class="box-body">
                        <input type="hidden" id="id" name="id" value="${user.id}">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">账户名：</label>
                            <div class="col-sm-10">
                                <input id="userName" name="userName" class="form-control" type="text" value="${user.userName}" <#if user?exists> readonly="readonly"</#if> >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">昵称：</label>
                            <div class="col-sm-10">
                                <input id="nickName" name="nickName" class="form-control" type="text" value="${user.nickName}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">头像URL：</label>
                            <div class="col-sm-10">
                                <select id="avatar" name="avatar" class="form-control" type="url" >
                                    <option value ="/assets/img/touxiang.PNG">默认头像1</option>
                                    <option value ="/assets/img/touxiang2.PNG">默认头像2</option>
                                </select>
                               <#-- <input id="avatar" name="avatar" class="form-control" type="url" value="${user.avatar}">-->
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">状态：</label>
                            <div class="col-sm-10">
                                <select name="locked" class="form-control">
                                    <option value="0" <#if user.locked == 0>selected="selected"</#if>>未锁定</option>
                                    <option value="1" <#if user.locked == 1>selected="selected"</#if>>锁定</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">描述：</label>
                            <div class="col-sm-10">
                                <textarea id="description" name="description" class="form-control" rows="6">${user.description}</textarea>
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
