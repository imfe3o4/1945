package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Shiti;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("试题")
public interface ShitiMapper extends BaseMapper<Shiti> {}
