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
import com.spboot.app.mapper.YonghuMapper;
import com.spboot.app.pojo.Yonghu;
import com.spboot.app.utils.*;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.*;
import javax.annotation.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class YonghuService {

    // 获取数据库操作类mapper
    @Resource
    private YonghuMapper mapper;

    // 获取密码加密类
    @Resource
    private PasswordEncoder pwdEncoder;

    /**
     * 将数据转换成Session对象
     */
    public Session toSession(Yonghu user) {
        // 创建Session 对象
        Session session = new Session();
        // 设置相应数据进session 对象
        session.setId(user.getId());
        session.setUsername(user.getZhanghao());
        session.setTable("yonghu");
        session.setRoles("用户");
        session.setCx(session.getRoles());

        session.setObject(BeanUtil.beanToMap(user));
        return session;
    }

    /**
     * 用户进行登录
     * @param username 用户名
     * @param pwd      密码
     * @return 用户对象实体类
     */
    public Yonghu login(String username, String pwd) {
        Yonghu row = findByZhanghao(username);

        // row为null的则是没有账号匹配成功
        if (row == null) {
            return null;
        }

        // 新建密码匹配类进行密码匹配，是否正确
        if (!pwdEncoder.matches(pwd, row.getMima())) {
            return null;
        }
        return row;
    }

    /**
     * 修改密码
     * @param id 用户id
     * @param oldPassword 原密码
     * @param newPassword 新密码
     * @return 处理是否成功
     */
    public R<Object> editPassword(int id, String oldPassword, String newPassword) {
        String encodePassword = pwdEncoder.encode(newPassword);
        Yonghu admins = mapper.selectById(id);
        if (!pwdEncoder.matches(oldPassword, admins.getMima())) {
            return R.error("原密码不正确，请重新输入");
        }
        admins.setMima(encodePassword);
        mapper.updateById(admins);
        return R.ok();
    }

    /**
     *   根据Zhanghao字段参数获取一行数据
     */
    public Yonghu findByZhanghao(String username) {
        // 新建用户模块实体类Yonghu
        Yonghu pojo = new Yonghu();
        // 设置参数
        pojo.setZhanghao(username);
        // 根据实体类新建QueryWrapper查询条件类
        QueryWrapper<Yonghu> queryWrapper = Wrappers.query(pojo);
        Yonghu row = mapper.selectOne(queryWrapper);
        return row;
    }

    /**
     *   根据Zhanghao字段参数获取一行数据，并不包含某uid 参数得行
     */
    public Yonghu findByZhanghao(String username, Integer uid) {
        // 新建用户模块实体类Yonghu
        Yonghu pojo = new Yonghu();
        // 设置参数
        pojo.setZhanghao(username);
        // 根据实体类新建QueryWrapper查询条件类
        QueryWrapper<Yonghu> queryWrapper = Wrappers.query(pojo);
        // 设置参数 id != uid变量
        queryWrapper.ne("id", uid);
        // 根据queryWrapper 查询
        Yonghu row = mapper.selectOne(queryWrapper);
        return row;
    }

    /**
     *  根据id 获取一行数据
     */
    public R<Yonghu> findById(Integer id) {
        return R.success(mapper.selectById(id));
    }

    /**
     *  根据Wrapper 对象进行数据筛选
     */
    public R<List<Yonghu>> selectAll(Wrapper<Yonghu> query) {
        return R.success(mapper.selectList(query));
    }

    /**
     *  直接筛选所有数据
     */
    public R<List<Yonghu>> selectAll() {
        QueryWrapper<Yonghu> wrapper = Wrappers.query();
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
        QueryWrapper<Yonghu> wrapper = mapToWrapper(map);
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
        QueryWrapper<Yonghu> wrapper = mapToWrapper(map);
        // 设置排序
        wrapper.orderBy(true, selectPage.isAsc(), selectPage.getOrderby());
        // 设置分页数据
        Page page = new Page(selectPage.getPage(), selectPage.getPagesize());
        return selectPages(wrapper, page);
    }

    /**
     *   将提交的参数转换成 mybatisplus 的QueryWrapper 筛选数据对象
     */
    public QueryWrapper<Yonghu> mapToWrapper(Map<String, Object> map) {
        // 创建 QueryWrapper 对象
        QueryWrapper<Yonghu> wrapper = Wrappers.query();

        String where = " 1=1 ";
        // 以下是判断搜索框中是否有输入内容，判断是否前台是否有填写相关条件，符合则写入sql搜索语句

        if (!StringUtil.isNullOrEmpty(map.get("zhanghao"))) {
            wrapper.like("zhanghao", map.get("zhanghao"));
        }

        if (map.containsKey("session_name")) {
            wrapper.eq(map.get("session_name").toString(), SessionFactory.getUsername());
        }

        wrapper.apply(where);
        return wrapper;
    }

    public R selectPages(QueryWrapper<Yonghu> wrapper, IPage page) {
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
    public R insert(Yonghu entityData, Map post) {
        // 判断是否有填写账号。
        if (StringUtil.isNullOrEmpty(post.get("zhanghao"))) {
            return R.error("请填写账号");
        }
        // 判断是否有填写账号,有则判断是否在数据中已经存在，存在则报错。
        if (findByZhanghao(entityData.getZhanghao()) != null) {
            return R.error("账号已经存在");
        }
        // 判断是否有填写密码。
        if (StringUtil.isNullOrEmpty(post.get("mima"))) {
            return R.error("请填写密码");
        }
        // 判断是否有填写姓名。
        if (StringUtil.isNullOrEmpty(post.get("xingming"))) {
            return R.error("请填写姓名");
        }
        // 判断是否有填写性别。
        if (StringUtil.isNullOrEmpty(post.get("xingbie"))) {
            return R.error("请填写性别");
        }
        // 判断是否有填写手机。
        if (StringUtil.isNullOrEmpty(post.get("shouji"))) {
            return R.error("请填写手机");
        }
        // 判断是否有填写手机,有则判断是否为手机号码或者座机。
        if (!StringUtil.isNullOrEmpty(entityData.getShouji())) {
            if (!(Validator.isMatchRegex(PatternPool.TEL, entityData.getShouji()) || Validator.isMobile(entityData.getShouji()))) {
                return R.error("请输入正确的手机");
            }
        }
        // 判断是否有填写身份证号。
        if (StringUtil.isNullOrEmpty(post.get("shenfenzhenghao"))) {
            return R.error("请填写身份证号");
        }
        // 判断是否有填写身高。
        if (StringUtil.isNullOrEmpty(post.get("shengao"))) {
            return R.error("请填写身高");
        }
        // 判断是否有填写体重。
        if (StringUtil.isNullOrEmpty(post.get("tizhong"))) {
            return R.error("请填写体重");
        }
        // 判断是否有填写婚姻状况。
        if (StringUtil.isNullOrEmpty(post.get("hunyinzhuangkuang"))) {
            return R.error("请填写婚姻状况");
        }
        // 判断是否有填写民族。
        if (StringUtil.isNullOrEmpty(post.get("minzu"))) {
            return R.error("请填写民族");
        }
        // 判断是否有填写现病史。
        if (StringUtil.isNullOrEmpty(post.get("xianbingshi"))) {
            return R.error("请填写现病史");
        }
        // 判断是否有填写既往病史。
        if (StringUtil.isNullOrEmpty(post.get("jiwangbingshi"))) {
            return R.error("请填写既往病史");
        }
        // 判断是否有填写家族病史。
        if (StringUtil.isNullOrEmpty(post.get("jiazubingshi"))) {
            return R.error("请填写家族病史");
        }

        Info.handlerNullEntity(entityData);

        // 对密码字段进行加密操作
        String pwd = pwdEncoder.encode(entityData.getMima());
        entityData.setMima(pwd);

        entityData.setId(null);
        mapper.insert(entityData);
        if (entityData.getId() != null) {
            return findById(entityData.getId());
        } else {
            return R.error("插入错误");
        }
    }

    /**
     * 根据id进行更新用户数据
     * @param entityData 更新的数据
     * @param post 提交的数据
     * @return 是否处理成功
     */
    public R<Object> update(Yonghu entityData, Map post) {
        // 判断是否有填写账号。
        if (StringUtil.isNullOrEmpty(post.get("zhanghao"))) {
            return R.error("请填写账号");
        }
        // 判断是否有填写账号,有则判断是否在数据中已经存在，存在则报错。
        if (findByZhanghao(entityData.getZhanghao(), entityData.getId()) != null) {
            return R.error("账号已经存在");
        }
        // 判断是否有填写姓名。
        if (StringUtil.isNullOrEmpty(post.get("xingming"))) {
            return R.error("请填写姓名");
        }
        // 判断是否有填写性别。
        if (StringUtil.isNullOrEmpty(post.get("xingbie"))) {
            return R.error("请填写性别");
        }
        // 判断是否有填写手机。
        if (StringUtil.isNullOrEmpty(post.get("shouji"))) {
            return R.error("请填写手机");
        }
        // 判断是否有填写手机,有则判断是否为手机号码或者座机。
        if (!StringUtil.isNullOrEmpty(entityData.getShouji())) {
            if (!(Validator.isMatchRegex(PatternPool.TEL, entityData.getShouji()) || Validator.isMobile(entityData.getShouji()))) {
                return R.error("请输入正确的手机");
            }
        }
        // 判断是否有填写身份证号。
        if (StringUtil.isNullOrEmpty(post.get("shenfenzhenghao"))) {
            return R.error("请填写身份证号");
        }
        // 判断是否有填写身高。
        if (StringUtil.isNullOrEmpty(post.get("shengao"))) {
            return R.error("请填写身高");
        }
        // 判断是否有填写体重。
        if (StringUtil.isNullOrEmpty(post.get("tizhong"))) {
            return R.error("请填写体重");
        }
        // 判断是否有填写婚姻状况。
        if (StringUtil.isNullOrEmpty(post.get("hunyinzhuangkuang"))) {
            return R.error("请填写婚姻状况");
        }
        // 判断是否有填写民族。
        if (StringUtil.isNullOrEmpty(post.get("minzu"))) {
            return R.error("请填写民族");
        }
        // 判断是否有填写现病史。
        if (StringUtil.isNullOrEmpty(post.get("xianbingshi"))) {
            return R.error("请填写现病史");
        }
        // 判断是否有填写既往病史。
        if (StringUtil.isNullOrEmpty(post.get("jiwangbingshi"))) {
            return R.error("请填写既往病史");
        }
        // 判断是否有填写家族病史。
        if (StringUtil.isNullOrEmpty(post.get("jiazubingshi"))) {
            return R.error("请填写家族病史");
        }

        String currentPwd = entityData.getMima();
        if (!StringUtil.isNullOrEmpty(currentPwd)) {
            // 不等于空，设置密码
            String pwd = pwdEncoder.encode(currentPwd);
            entityData.setMima(pwd);
        } else {
            Yonghu old = mapper.selectById(entityData.getId());
            entityData.setMima(old.getMima());
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
        xls.addCol("mima", "密码"); // 添加一列 mima，密码
        xls.addCol("xingming", "姓名"); // 添加一列 xingming，姓名
        xls.addCol("xingbie", "性别"); //添加一列  xingbie ， 性别

        xls.addCol("shouji", "手机"); // 添加一列 shouji，手机
        xls.addCol("jifen", "积分"); // 添加一列 jifen，积分
        xls.addCol("shenfenzhenghao", "身份证号"); // 添加一列 shenfenzhenghao，身份证号
        xls.addCol("shengao", "身高"); // 添加一列 shengao，身高
        xls.addCol("tizhong", "体重"); // 添加一列 tizhong，体重
        xls.addCol("hunyinzhuangkuang", "婚姻状况"); //添加一列  hunyinzhuangkuang ， 婚姻状况

        xls.addCol("minzu", "民族"); // 添加一列 minzu，民族
        xls.addCol("xianbingshi", "现病史"); // 添加一列 xianbingshi，现病史
        xls.addCol("jiwangbingshi", "既往病史"); // 添加一列 jiwangbingshi，既往病史
        xls.addCol("jiazubingshi", "家族病史"); // 添加一列 jiazubingshi，家族病史

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
        List<Map> list = DBQueryWrapper.make("yonghu").plus(mapToWrapper(map)).order(orderby, sort).select();
        xls.addData(list);
        // 执行导出
        xls.export(outputStream);
    }
}
