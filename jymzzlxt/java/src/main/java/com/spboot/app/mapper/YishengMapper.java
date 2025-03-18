package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Yisheng;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("医生")
public interface YishengMapper extends BaseMapper<Yisheng> {}
