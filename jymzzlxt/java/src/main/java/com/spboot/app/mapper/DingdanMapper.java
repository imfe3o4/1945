package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Dingdan;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("订单")
public interface DingdanMapper extends BaseMapper<Dingdan> {}
