package com.spboot.app.mapper;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.spboot.app.pojo.Wenzhang;
import org.apache.ibatis.annotations.Mapper;

@Mapper
@TableName("文章")
public interface WenzhangMapper extends BaseMapper<Wenzhang> {}
