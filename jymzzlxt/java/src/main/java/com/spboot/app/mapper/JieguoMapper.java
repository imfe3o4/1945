package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Jieguo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("结果")
public interface JieguoMapper extends BaseMapper<Jieguo> {}
