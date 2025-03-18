package com.spboot.app.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.jntoo.db.DB;
import com.jntoo.db.utils.StringUtil;
import com.spboot.app.config.Configure;
import com.spboot.app.mapper.GerenjiankangshujuMapper;
import com.spboot.app.pojo.Gerenjiankangshuju;
import com.spboot.app.service.GerenjiankangshujuService;
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

@Api(tags = { "个人健康数据控制器" })
@RestController
@RequestMapping("/api/gerenjiankangshuju")
public class GerenjiankangshujuController {

    @Autowired
    public GerenjiankangshujuService gerenjiankangshujuService;

    @ApiOperation(value = "获取全部个人健康数据", httpMethod = "GET")
    @RequestMapping("/selectAll")
    public R<List<Gerenjiankangshuju>> selectAll() {
        return gerenjiankangshujuService.selectAll();
    }

    @ApiOperation(value = "根据条件筛选获取管理员列表，并分页", httpMethod = "POST")
    @RequestMapping("/selectPages")
    public R selectPages(@RequestBody Map<String, Object> req) {
        return gerenjiankangshujuService.selectPages(req);
    }

    @ApiOperation(value = "根据条件筛选获取用户字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectYonghu")
    public R selectYonghu(@RequestBody Map<String, Object> req) {
        return gerenjiankangshujuService.selectPagesYonghu(req);
    }

    @ApiOperation(value = "根据id获取信息", httpMethod = "GET")
    @RequestMapping("/findById")
    @ApiImplicitParam(name = "id", value = "个人健康数据对应的id", dataType = "Integer")
    public R findById(@RequestParam Integer id) {
        return gerenjiankangshujuService.findById(id);
    }

    @ApiOperation(value = "根据id更新数据", httpMethod = "POST")
    @RequestMapping("/update")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Gerenjiankangshuju.class, paramType = "body")
    public R update(@RequestBody Map data) {
        Gerenjiankangshuju post = BeanUtil.mapToBean(data, Gerenjiankangshuju.class, true);
        return gerenjiankangshujuService.update(post, data);
    }

    @ApiOperation(value = "插入一行数据，返回插入后的点赞", httpMethod = "POST")
    @RequestMapping("/insert")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Gerenjiankangshuju.class, paramType = "body")
    public R insert(@RequestBody Map data) {
        Gerenjiankangshuju post = BeanUtil.mapToBean(data, Gerenjiankangshuju.class, true);
        return gerenjiankangshujuService.insert(post, data);
    }

    @ApiOperation(value = "根据id列表删除数据", httpMethod = "POST")
    @RequestMapping("/delete")
    @ApiImplicitParam(name = "id", value = "个人健康数据对应的id", type = "json", dataTypeClass = List.class)
    public R delete(@RequestBody List<Integer> id) {
        return gerenjiankangshujuService.delete(id);
    }
}
