package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Shijuan;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("试卷")
public interface ShijuanMapper extends BaseMapper<Shijuan> {}
