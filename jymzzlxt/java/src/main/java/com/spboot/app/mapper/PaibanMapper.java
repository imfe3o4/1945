package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Paiban;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("排班")
public interface PaibanMapper extends BaseMapper<Paiban> {}
