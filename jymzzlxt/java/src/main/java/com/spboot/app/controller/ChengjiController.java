package com.spboot.app.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.jntoo.db.DB;
import com.jntoo.db.utils.StringUtil;
import com.spboot.app.config.Configure;
import com.spboot.app.mapper.ChengjiMapper;
import com.spboot.app.pojo.Chengji;
import com.spboot.app.service.ChengjiService;
import com.spboot.app.utils.R;
import com.spboot.app.utils.SessionFactory;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = { "成绩控制器" })
@RestController
@RequestMapping("/api/chengji")
public class ChengjiController {

    @Autowired
    public ChengjiService chengjiService;

    @ApiOperation(value = "获取全部成绩", httpMethod = "GET")
    @RequestMapping("/selectAll")
    public R<List<Chengji>> selectAll() {
        return chengjiService.selectAll();
    }

    @ApiOperation(value = "根据条件筛选获取管理员列表，并分页", httpMethod = "POST")
    @RequestMapping("/selectPages")
    public R selectPages(@RequestBody Map<String, Object> req) {
        return chengjiService.selectPages(req);
    }

    @ApiOperation(value = "根据条件筛选获取发布人字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectFaburen")
    public R selectFaburen(@RequestBody Map<String, Object> req) {
        return chengjiService.selectPagesFaburen(req);
    }

    @ApiOperation(value = "根据条件筛选获取答题人字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectDatiren")
    public R selectDatiren(@RequestBody Map<String, Object> req) {
        return chengjiService.selectPagesDatiren(req);
    }

    @ApiOperation(value = "根据id获取信息", httpMethod = "GET")
    @RequestMapping("/findById")
    @ApiImplicitParam(name = "id", value = "成绩对应的id", dataType = "Integer")
    public R findById(@RequestParam Integer id) {
        return chengjiService.findById(id);
    }

    @ApiOperation(value = "根据id更新数据", httpMethod = "POST")
    @RequestMapping("/update")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Chengji.class, paramType = "body")
    public R update(@RequestBody Map data) {
        Chengji post = BeanUtil.mapToBean(data, Chengji.class, true);
        return chengjiService.update(post, data);
    }

    @ApiOperation(value = "插入一行数据，返回插入后的点赞", httpMethod = "POST")
    @RequestMapping("/insert")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Chengji.class, paramType = "body")
    public R insert(@RequestBody Map data) {
        Chengji post = BeanUtil.mapToBean(data, Chengji.class, true);
        return chengjiService.insert(post, data);
    }

    @ApiOperation(value = "根据id列表删除数据", httpMethod = "POST")
    @RequestMapping("/delete")
    @ApiImplicitParam(name = "id", value = "成绩对应的id", type = "json", dataTypeClass = List.class)
    public R delete(@RequestBody List<Integer> id) {
        return chengjiService.delete(id);
    }
}
