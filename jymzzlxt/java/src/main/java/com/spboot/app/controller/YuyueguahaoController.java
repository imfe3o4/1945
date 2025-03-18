package com.spboot.app.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.jntoo.db.DB;
import com.jntoo.db.utils.StringUtil;
import com.spboot.app.config.Configure;
import com.spboot.app.mapper.YuyueguahaoMapper;
import com.spboot.app.pojo.Yuyueguahao;
import com.spboot.app.service.YuyueguahaoService;
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

@Api(tags = { "预约挂号控制器" })
@RestController
@RequestMapping("/api/yuyueguahao")
public class YuyueguahaoController {

    @Autowired
    public YuyueguahaoService yuyueguahaoService;

    @ApiOperation(value = "获取全部预约挂号", httpMethod = "GET")
    @RequestMapping("/selectAll")
    public R<List<Yuyueguahao>> selectAll() {
        return yuyueguahaoService.selectAll();
    }

    @ApiOperation(value = "根据条件筛选获取管理员列表，并分页", httpMethod = "POST")
    @RequestMapping("/selectPages")
    public R selectPages(@RequestBody Map<String, Object> req) {
        return yuyueguahaoService.selectPages(req);
    }

    @ApiOperation(value = "根据条件筛选获取账号字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectZhanghao")
    public R selectZhanghao(@RequestBody Map<String, Object> req) {
        return yuyueguahaoService.selectPagesZhanghao(req);
    }

    @ApiOperation(value = "根据条件筛选获取挂号人字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectGuahaoren")
    public R selectGuahaoren(@RequestBody Map<String, Object> req) {
        return yuyueguahaoService.selectPagesGuahaoren(req);
    }

    @ApiOperation(value = "根据id获取信息", httpMethod = "GET")
    @RequestMapping("/findById")
    @ApiImplicitParam(name = "id", value = "预约挂号对应的id", dataType = "Integer")
    public R findById(@RequestParam Integer id) {
        return yuyueguahaoService.findById(id);
    }

    @ApiOperation(value = "根据id更新数据", httpMethod = "POST")
    @RequestMapping("/update")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Yuyueguahao.class, paramType = "body")
    public R update(@RequestBody Map data) {
        Yuyueguahao post = BeanUtil.mapToBean(data, Yuyueguahao.class, true);
        return yuyueguahaoService.update(post, data);
    }

    @ApiOperation(value = "插入一行数据，返回插入后的点赞", httpMethod = "POST")
    @RequestMapping("/insert")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Yuyueguahao.class, paramType = "body")
    public R insert(@RequestBody Map data) {
        Yuyueguahao post = BeanUtil.mapToBean(data, Yuyueguahao.class, true);
        return yuyueguahaoService.insert(post, data);
    }

    @ApiOperation(value = "根据id列表删除数据", httpMethod = "POST")
    @RequestMapping("/delete")
    @ApiImplicitParam(name = "id", value = "预约挂号对应的id", type = "json", dataTypeClass = List.class)
    public R delete(@RequestBody List<Integer> id) {
        return yuyueguahaoService.delete(id);
    }
}
