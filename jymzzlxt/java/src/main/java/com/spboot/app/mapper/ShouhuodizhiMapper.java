package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Shouhuodizhi;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("收货地址")
public interface ShouhuodizhiMapper extends BaseMapper<Shouhuodizhi> {}
