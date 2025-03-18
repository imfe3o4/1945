package com.spboot.app.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.PatternPool;
import cn.hutool.core.lang.Validator;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jntoo.db.DB;
import com.jntoo.db.utils.Convert;
import com.jntoo.db.utils.StringUtil;
import com.spboot.app.mapper.DingdanMapper;
import com.spboot.app.pojo.Dingdan;
import com.spboot.app.utils.*;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.*;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class DingdanService {

    // 获取数据库操作类mapper
    @Resource
    private DingdanMapper mapper;

    /**
     *  根据id 获取一行数据
     */
    public R<Dingdan> findById(Integer id) {
        return R.success(mapper.selectById(id));
    }

    /**
     *  根据Wrapper 对象进行数据筛选
     */
    public R<List<Dingdan>> selectAll(Wrapper<Dingdan> query) {
        return R.success(mapper.selectList(query));
    }

    /**
     *  直接筛选所有数据
     */
    public R<List<Dingdan>> selectAll() {
        QueryWrapper<Dingdan> wrapper = Wrappers.query();
        wrapper.orderByDesc("id");
        return selectAll(wrapper);
    }

    /**
     *  根据map 条件筛选数据
     *
     */
    public R selectAll(Map<String, Object> map) {
        // 获取筛选数据
        SelectPage selectPage = new SelectPage(map, 10, "id", "DESC");
        // 将提交的参数转换成 mybatisplus 的QueryWrapper 筛选数据对象，执行动态查询
        QueryWrapper<Dingdan> wrapper = mapToWrapper(map);
        // 设置排序
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        return selectAll(wrapper);
    }

    /**
     *  根据map 条件筛选数据并分页
     *
     */
    public R selectPages(Map<String, Object> map) {
        // 获取筛选数据
        SelectPage selectPage = new SelectPage(map, 10, "id", "DESC");
        // 将提交的参数转换成 mybatisplus 的QueryWrapper 筛选数据对象，执行动态查询
        QueryWrapper<Dingdan> wrapper = mapToWrapper(map);
        // 设置排序
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        // 设置分页数据
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *  根据map 条件筛选xiadanren字段等于session.username的数据并分页
     *
     */
    public R selectPagesXiadanren(Map<String, Object> map) {
        // 获取前端给到列表基础参数
        SelectPage selectPage = new SelectPage(map, 10, "id", "DESC");
        // 将map参数转换为mybatis-plus的QueryWrapper类
        QueryWrapper<Dingdan> wrapper = mapToWrapper(map);
        // 设置为当前角色
        wrapper.eq("xiadanren", SessionFactory.getUsername());
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *   将提交的参数转换成 mybatisplus 的QueryWrapper 筛选数据对象
     */
    public QueryWrapper<Dingdan> mapToWrapper(Map<String, Object> map) {
        // 创建 QueryWrapper 对象
        QueryWrapper<Dingdan> wrapper = Wrappers.query();

        String where = " 1=1 ";
        // 以下是判断搜索框中是否有输入内容，判断是否前台是否有填写相关条件，符合则写入sql搜索语句

        if (!StringUtil.isNullOrEmpty(map.get("dingdanhao"))) {
            wrapper.like("dingdanhao", map.get("dingdanhao"));
        }
        if (!StringUtil.isNullOrEmpty(map.get("shangpin"))) {
            wrapper.like("shangpin", map.get("shangpin"));
        }
        if (!StringUtil.isNullOrEmpty(map.get("shouhuoren"))) {
            wrapper.like("shouhuoren", map.get("shouhuoren"));
        }
        if (!StringUtil.isNullOrEmpty(map.get("zhuangtai"))) {
            wrapper.like("zhuangtai", map.get("zhuangtai"));
        }

        if (!StringUtil.isNullOrEmpty(map.get("iszf"))) {
            wrapper.eq("iszf", map.get("iszf"));
        }

        if (map.containsKey("session_name")) {
            wrapper.eq(map.get("session_name").toString(), SessionFactory.getUsername());
        }

        wrapper.apply(where);
        return wrapper;
    }

    public R selectPages(QueryWrapper<Dingdan> wrapper, IPage page) {
        Map result = new HashMap();
        result.put("lists", mapper.selectPage(page, wrapper));

        return R.success(result);
    }

    /**
     * 插入用户数据
     * @param entityData 插入的对象
     * @param post 提交的数据
     * @return 是否处理成功
     */
    public R insert(Dingdan entityData, Map post) {
        // 判断是否有填写订单号。
        if (StringUtil.isNullOrEmpty(post.get("dingdanhao"))) {
            return R.error("请填写订单号");
        }
        // 判断是否有填写订单金额。
        if (StringUtil.isNullOrEmpty(post.get("dingdanjine"))) {
            return R.error("请填写订单金额");
        }
        // 判断是否有填写收货信息。
        if (StringUtil.isNullOrEmpty(post.get("shouhuoxinxi"))) {
            return R.error("请填写收货信息");
        }

        Info.handlerNullEntity(entityData);
        entityData.setAddtime(Info.getDateStr());

        entityData.setId(null);
        mapper.insert(entityData);
        if (entityData.getId() != null) {
            if ("1".equals(post.get("_lijigoumai"))) {
                List<Map> lists = (List<Map>) post.get("_JSON");
                for (Map m : lists) {
                    m.put("dingdanid", entityData.getId());
                    DB.name(Convert.toStr(post.get("_biao"))).insert(m);
                }
            }

            Integer charuid = entityData.getId();
            DB.execute(
                "INSERT INTO dingdanshangpin(dingdanid, yaopinid, bianhao, mingcheng, fenlei, jiage, tupian, goumaishu, xiaoji, goumairen, addtime) SELECT '" +
                charuid +
                "', yaopinid, bianhao, mingcheng, fenlei, jiage, tupian, goumaishu, xiaoji, goumairen, now() FROM gouwuche WHERE goumairen='" +
                SessionFactory.getUsername() +
                "' AND id IN (" +
                post.get("targetIds") +
                ")"
            );

            DB.execute("DELETE  FROM gouwuche WHERE goumairen='" + SessionFactory.getUsername() + "' AND id in(" + post.get("targetIds") + ")");

            return findById(entityData.getId());
        } else {
            return R.error("插入错误");
        }
    }

    /**
     * 根据id进行更新订单数据
     * @param entityData 更新的数据
     * @param post 提交的数据
     * @return 是否处理成功
     */
    public R<Object> update(Dingdan entityData, Map post) {
        // 判断是否有填写订单号。
        if (StringUtil.isNullOrEmpty(post.get("dingdanhao"))) {
            return R.error("请填写订单号");
        }
        // 判断是否有填写订单金额。
        if (StringUtil.isNullOrEmpty(post.get("dingdanjine"))) {
            return R.error("请填写订单金额");
        }
        // 判断是否有填写收货信息。
        if (StringUtil.isNullOrEmpty(post.get("shouhuoxinxi"))) {
            return R.error("请填写收货信息");
        }

        mapper.updateById(entityData);

        return R.success(mapper.selectById(entityData.getId()));
    }

    /**
     * 根据 id列表 删除
     * @param ids  id 列表值
     * @return 是否成功
     */
    public R<Object> delete(List<Integer> ids) {
        try {
            for (Integer id : ids) {
                delete(id);
            }
            return R.success("操作成功");
        } catch (Exception e) {
            return R.error("操作失败");
        }
    }

    /**
     * 根据 id 删除
     * @param id  id 列表值
     * @return 是否成功
     */
    public R<Object> delete(Integer id) {
        try {
            Dingdan map = mapper.selectById(id);
            Map post = DB.name("dingdan").find(id);

            mapper.deleteById(id);
            DB.execute("DELETE  FROM dingdanshangpin WHERE dingdanid='" + post.get("id") + "'");

            return R.success("操作成功");
        } catch (Exception e) {
            return R.error("操作失败");
        }
    }
}
