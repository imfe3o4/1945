package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Chengji;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("成绩")
public interface ChengjiMapper extends BaseMapper<Chengji> {}
