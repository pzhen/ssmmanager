$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [ o[this.name] ];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}

layui.use(['form', 'laydate', 'layer'], function () {
    var form = layui.form;
    var layer = layui.layer;
    var laydate = layui.laydate;
    var laypage = layui.laypage;

    laydate.render({
        elem: '#start_time',
        type: 'datetime'
    });

    laydate.render({
        elem: '#end_time',
        type: 'datetime'
    });

    form.on('switch(Status)', function (data) {
        if (data.elem.checked) {
            data.elem.value = 1
        } else {
            data.elem.value = 0
        }
    });

});

function showAllContent(o, data) {
    layer.open({
        type: 1,
        area: ['600px', '360px'],
        shadeClose: true, //点击遮罩关闭
        content: '\<\div style="padding:20px;display:block;word-break: break-all;word-wrap: break-word;line-height:22px">' + data + '\<\/div>'
    });
}

// 单条删除
function deleteDataByOne(url,obj, id) {
    layer.confirm('确认要执行操作吗？', {btn: ['确定', '取消']}, function (index) {
        $.ajax({
            url: decodeURI(url),
            data: {"id": id},
            type: "get",
            dataType: "json",
            success: function (data) {
                var messge = "网络繁忙...";
                if (data.message) {
                    messge = data.message;
                }
                layer.msg(messge, {icon: 1, time: 1000}, function () {
                    if (data.code > 0) {
                        window.location.href = data.url;
                    }
                });
            }
        });
        return false;
    });
}

// 批量删除
function deleteDataByBatch(url) {
    var idArr = [];
    $(".layui-form-checked").each(function () {
        var currDataId = $(this).attr("data-id");
        if ("undefined" != typeof(currDataId)) {
            idArr.push(currDataId)
        }
    });

    if (!idArr.length) {
        layer.msg("未选中记录", {icon: 1, time: 1000});
        return
    }

    layer.confirm('确认要执行操作吗？', {btn: ['确定', '取消']}, function (index) {
        $.ajax({
            url: decodeURI(url),
            data: {"id": idArr.join()},
            type: "get",
            dataType: "json",
            success: function (data) {
                var messge = "网络繁忙...";
                if (data.message) {
                    messge = data.message;
                }

                layer.msg(messge, {icon: 1, time: 1000}, function () {
                    if (data.code > 0) {
                        window.location.href = data.url;
                    }
                });
            }
        });
        return false;
    });
}

// 单条修改状态
function modifyStatusByOne(url, obj, id, status) {
    layer.confirm('确认要执行操作吗？', {btn: ['确定', '取消']}, function (index) {
        $.ajax({
            url: decodeURI(url),
            data: {"id": id, "status": status},
            type: "get",
            dataType: "json",
            success: function (data) {
                var messge = "网络繁忙...";
                if (data.message) {
                    messge = data.message;
                }

                layer.msg(messge, {icon: 1, time: 1000}, function () {
                    if (data.code > 0) {
                        window.location.href = data.url;
                    }
                });
            }
        });
        return false;
    });
}


// 批量修改状态
function modifyStatusByBatch(url, status) {
    var idArr = [];
    $(".layui-form-checked").each(function () {
        var currDataId = $(this).attr("data-id");
        if ("undefined" != typeof(currDataId)) {
            idArr.push(currDataId)
        }
    });

    if (!idArr.length) {
        layer.msg("未选中记录", {icon: 1, time: 1000});
        return
    }

    layer.confirm('确认要执行操作吗？', {btn: ['确定', '取消']}, function (index) {
        $.ajax({
            url: decodeURI(url),
            data: {"id": idArr.join(), "status": status},
            type: "get",
            dataType: "json",
            success: function (data) {
                var messge = "网络繁忙...";
                if (data.message) {
                    messge = data.message;
                }

                layer.msg(messge, {icon: 1, time: 1000}, function () {
                    if (data.code > 0) {
                        window.location.href = data.url;
                    }
                });
            }
        });
        return false;
    });
}

//url 提交地址
//data 表单数据
//display 提醒方式 msg/alert
//jumpType  跳转还是刷新 reload/herf
function formSubmit(url, data, display,jumpType) {
    $.ajax({
        url: url,
        data: JSON.stringify(data),
        type: "post",
        //dataType: "text",
        contentType:"application/json",
        success: function (data) {
            var messge = "网络繁忙...";
            if (data.message) {
                messge = data.message;
            }
            if (display == "msg"){
                layer.msg(data.message,{icon:1,time:1000},function () {
                    if(data.code > 0){
                        if(jumpType == "reload"){
                            closeCurrentIframe()
                            window.parent.location.reload();
                        } else {
                            closeCurrentIframe()
                            window.parent.location.href = data.url
                        }
                    }else {
                        return false
                    }
                });
            } else {
                layer.alert(messge, {icon: 6, time: 3000}, function () {
                    if(data.code > 0){
                        if(jumpType == "reload"){
                            closeCurrentIframe()
                            window.parent.location.reload();
                        } else {
                            closeCurrentIframe()
                            console.log(data.url)
                            window.parent.location.href = data.url
                        }
                    }else {
                        return false
                    }
                });
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.alert(messge, {icon: 6}, function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
            });
        },
        beforeSend: function () {
        },
        complete: function () {
        }
    });
}

function closeCurrentIframe() {
    if (top.location != self.location)
    {
        // 获得frame索引
        var index = parent.layer.getFrameIndex(window.name);
        console.log(index)
        //关闭当前frame
        parent.layer.close(index);
    }
}