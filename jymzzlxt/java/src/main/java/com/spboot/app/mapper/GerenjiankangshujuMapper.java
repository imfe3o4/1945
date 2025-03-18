package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Gerenjiankangshuju;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("个人健康数据")
public interface GerenjiankangshujuMapper extends BaseMapper<Gerenjiankangshuju> {}
