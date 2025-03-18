package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Yuyueguahao;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("预约挂号")
public interface YuyueguahaoMapper extends BaseMapper<Yuyueguahao> {}
