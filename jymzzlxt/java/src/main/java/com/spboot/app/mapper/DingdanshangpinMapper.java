package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Dingdanshangpin;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("订单商品")
public interface DingdanshangpinMapper extends BaseMapper<Dingdanshangpin> {}
