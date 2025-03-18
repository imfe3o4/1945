package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Yaopin;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("药品")
public interface YaopinMapper extends BaseMapper<Yaopin> {}
