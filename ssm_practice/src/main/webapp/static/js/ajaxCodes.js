/**
 * 存放各种ajax代码, 同一文件方便管理
 */
var BasePath = "/ssm_practice";
// 发请求更新员工
function sendUpdateEmpAjax(oFromPrama,callback){
    $.ajax({
        url: BasePath+"/update",
        type: "put",
        data: oFromPrama,
        success: callback
    })
}

function sendDeleteEmpAjax(oFromParam , callback){
    $.ajax({
        url:BasePath + "/delete_emp/"+oFromParam,
        type:"delete",
        success:callback
    })
}

// ids : 为要删除的员工id的集合,
function sendDeleteEmpsInIdAjax(ids,callback){
    $.ajax({
        // 必须添加这两个请求头
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        url:BasePath+"/delete_emps",
        type:"DELETE",
        data: ids,
        success:callback
    });
}