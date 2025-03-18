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
import com.spboot.app.mapper.XinlizhenliaofanganMapper;
import com.spboot.app.pojo.Xinlizhenliaofangan;
import com.spboot.app.utils.*;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.*;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class XinlizhenliaofanganService {

    // 获取数据库操作类mapper
    @Resource
    private XinlizhenliaofanganMapper mapper;

    /**
     *  根据id 获取一行数据
     */
    public R<Xinlizhenliaofangan> findById(Integer id) {
        return R.success(mapper.selectById(id));
    }

    /**
     *  根据Wrapper 对象进行数据筛选
     */
    public R<List<Xinlizhenliaofangan>> selectAll(Wrapper<Xinlizhenliaofangan> query) {
        return R.success(mapper.selectList(query));
    }

    /**
     *  直接筛选所有数据
     */
    public R<List<Xinlizhenliaofangan>> selectAll() {
        QueryWrapper<Xinlizhenliaofangan> wrapper = Wrappers.query();
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
        QueryWrapper<Xinlizhenliaofangan> wrapper = mapToWrapper(map);
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
        QueryWrapper<Xinlizhenliaofangan> wrapper = mapToWrapper(map);
        // 设置排序
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        // 设置分页数据
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *  根据map 条件筛选zhanghao字段等于session.username的数据并分页
     *
     */
    public R selectPagesZhanghao(Map<String, Object> map) {
        // 获取前端给到列表基础参数
        SelectPage selectPage = new SelectPage(map, 10, "id", "DESC");
        // 将map参数转换为mybatis-plus的QueryWrapper类
        QueryWrapper<Xinlizhenliaofangan> wrapper = mapToWrapper(map);
        // 设置为当前角色
        wrapper.eq("zhanghao", SessionFactory.getUsername());
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *  根据map 条件筛选guahaoren字段等于session.username的数据并分页
     *
     */
    public R selectPagesGuahaoren(Map<String, Object> map) {
        // 获取前端给到列表基础参数
        SelectPage selectPage = new SelectPage(map, 10, "id", "DESC");
        // 将map参数转换为mybatis-plus的QueryWrapper类
        QueryWrapper<Xinlizhenliaofangan> wrapper = mapToWrapper(map);
        // 设置为当前角色
        wrapper.eq("guahaoren", SessionFactory.getUsername());
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *   将提交的参数转换成 mybatisplus 的QueryWrapper 筛选数据对象
     */
    public QueryWrapper<Xinlizhenliaofangan> mapToWrapper(Map<String, Object> map) {
        // 创建 QueryWrapper 对象
        QueryWrapper<Xinlizhenliaofangan> wrapper = Wrappers.query();

        String where = " 1=1 ";
        // 以下是判断搜索框中是否有输入内容，判断是否前台是否有填写相关条件，符合则写入sql搜索语句

        // 判断URL 参数yuyueguahaoid是否大于0
        if (!StringUtil.isNullOrEmpty(map.get("yuyueguahaoid")) && Convert.toInt(map.get("yuyueguahaoid")) > 0) {
            // 大于0 则写入条件
            wrapper.eq("yuyueguahaoid", map.get("yuyueguahaoid"));
        }

        if (!StringUtil.isNullOrEmpty(map.get("xingming"))) {
            wrapper.like("xingming", map.get("xingming"));
        }

        if (map.containsKey("session_name")) {
            wrapper.eq(map.get("session_name").toString(), SessionFactory.getUsername());
        }

        wrapper.apply(where);
        return wrapper;
    }

    public R selectPages(QueryWrapper<Xinlizhenliaofangan> wrapper, IPage page) {
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
    public R insert(Xinlizhenliaofangan entityData, Map post) {
        // 判断是否有填写诊疗方案。
        if (StringUtil.isNullOrEmpty(post.get("zhenliaofangan"))) {
            return R.error("请填写诊疗方案");
        }
        // 判断是否有填写处方。
        if (StringUtil.isNullOrEmpty(post.get("chufang"))) {
            return R.error("请填写处方");
        }

        Info.handlerNullEntity(entityData);
        entityData.setAddtime(Info.getDateStr());

        entityData.setId(null);
        mapper.insert(entityData);
        if (entityData.getId() != null) {
            Integer charuid = entityData.getId();
            DB.execute("UPDATE yuyueguahao SET zhuangtai = '已开处方' WHERE id='" + post.get("yuyueguahaoid") + "'");

            return findById(entityData.getId());
        } else {
            return R.error("插入错误");
        }
    }

    /**
     * 根据id进行更新心理诊疗方案数据
     * @param entityData 更新的数据
     * @param post 提交的数据
     * @return 是否处理成功
     */
    public R<Object> update(Xinlizhenliaofangan entityData, Map post) {
        // 判断是否有填写诊疗方案。
        if (StringUtil.isNullOrEmpty(post.get("zhenliaofangan"))) {
            return R.error("请填写诊疗方案");
        }
        // 判断是否有填写处方。
        if (StringUtil.isNullOrEmpty(post.get("chufang"))) {
            return R.error("请填写处方");
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
            mapper.deleteById(id);

            return R.success("操作成功");
        } catch (Exception e) {
            return R.error("操作失败");
        }
    }

    /**
     *  根据map 条件进行数据导出
     *
     */
    public void export(Map<String, Object> map, OutputStream outputStream) {
        String orderby = (String) map.get("orderby");
        String sort = (String) map.get("sort");
        Execl xls = new Execl(); // 生成导出类

        xls.addCol("zhanghao", "账号"); // 添加一列 zhanghao，账号
        xls.addCol("xingming", "姓名"); // 添加一列 xingming，姓名
        xls.addCol("zhicheng", "职称"); // 添加一列 zhicheng，职称
        xls.addCol("huanzhexingming", "患者姓名"); // 添加一列 huanzhexingming，患者姓名
        xls.addCol("nianling", "年龄"); // 添加一列 nianling，年龄
        xls.addCol("guahaoren", "挂号人"); // 添加一列 guahaoren，挂号人
        xls.addCol("zhenliaofangan", "诊疗方案"); // 添加一列 zhenliaofangan，诊疗方案
        xls.addCol("chufang", "处方"); // 添加一列 chufang，处方
        xls.addCol("addtime", "添加时间"); // 添加一列 addtime，添加时间

        // 判断是否有排序选项
        if (StringUtil.isNullOrEmpty(orderby)) {
            orderby = "id";
        }
        if (StringUtil.isNullOrEmpty(sort)) {
            sort = "DESC";
        }
        sort = sort.toUpperCase();
        if (!sort.equals("DESC") && !sort.equals("ASC")) {
            sort = "DESC";
        }
        // 搜索数据库数据，并把数据导入到  execl 导入导出类
        List<Map> list = DBQueryWrapper.make("xinlizhenliaofangan").plus(mapToWrapper(map)).order(orderby, sort).select();
        xls.addData(list);
        // 执行导出
        xls.export(outputStream);
    }
}
