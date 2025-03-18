package com.spboot.app.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.jntoo.db.DB;
import com.jntoo.db.utils.StringUtil;
import com.spboot.app.config.Configure;
import com.spboot.app.mapper.WenzhangMapper;
import com.spboot.app.pojo.Wenzhang;
import com.spboot.app.service.WenzhangService;
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

@Api(tags = { "文章控制器" })
@RestController
@RequestMapping("/api/wenzhang")
public class WenzhangController {

    @Autowired
    public WenzhangService wenzhangService;

    @ApiOperation(value = "获取全部文章", httpMethod = "GET")
    @RequestMapping("/selectAll")
    public R<List<Wenzhang>> selectAll() {
        return wenzhangService.selectAll();
    }

    @ApiOperation(value = "根据条件筛选获取管理员列表，并分页", httpMethod = "POST")
    @RequestMapping("/selectPages")
    public R selectPages(@RequestBody Map<String, Object> req) {
        return wenzhangService.selectPages(req);
    }

    @ApiOperation(value = "根据条件筛选获取添加人字段值为当前用户列表并分页", httpMethod = "POST")
    @RequestMapping("/selectTianjiaren")
    public R selectTianjiaren(@RequestBody Map<String, Object> req) {
        return wenzhangService.selectPagesTianjiaren(req);
    }

    @ApiOperation(value = "根据id获取信息", httpMethod = "GET")
    @RequestMapping("/findById")
    @ApiImplicitParam(name = "id", value = "文章对应的id", dataType = "Integer")
    public R findById(@RequestParam Integer id) {
        return wenzhangService.findById(id);
    }

    @ApiOperation(value = "根据id更新数据", httpMethod = "POST")
    @RequestMapping("/update")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Wenzhang.class, paramType = "body")
    public R update(@RequestBody Map data) {
        Wenzhang post = BeanUtil.mapToBean(data, Wenzhang.class, true);
        return wenzhangService.update(post, data);
    }

    @ApiOperation(value = "插入一行数据，返回插入后的点赞", httpMethod = "POST")
    @RequestMapping("/insert")
    @ApiImplicitParam(name = "data", value = "使用json数据提交", type = "json", dataTypeClass = Wenzhang.class, paramType = "body")
    public R insert(@RequestBody Map data) {
        Wenzhang post = BeanUtil.mapToBean(data, Wenzhang.class, true);
        return wenzhangService.insert(post, data);
    }

    @ApiOperation(value = "根据id列表删除数据", httpMethod = "POST")
    @RequestMapping("/delete")
    @ApiImplicitParam(name = "id", value = "文章对应的id", type = "json", dataTypeClass = List.class)
    public R delete(@RequestBody List<Integer> id) {
        return wenzhangService.delete(id);
    }

    @ApiOperation(value = "前端详情触发后", httpMethod = "POST")
    @RequestMapping("/detailWeb")
    public R detailWeb(@RequestBody Map<String, Object> post) {
        Wenzhang map = DB.name(Wenzhang.class).find(post.get("id"));
        DB.execute("UPDATE wenzhang SET dianjiliang = dianjiliang+1 WHERE id='" + post.get("id") + "'");

        DB.execute(
            "INSERT INTO liulanjilu(wenzhangid, bianhao, biaoti, fenlei, liulanren) SELECT id, bianhao, biaoti, fenlei, '" +
            SessionFactory.getUsername() +
            "' FROM wenzhang WHERE id='" +
            post.get("id") +
            "' AND 'null'!='" +
            SessionFactory.getUsername() +
            "'"
        );

        return R.ok();
    }
}
