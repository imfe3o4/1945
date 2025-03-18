package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("paiban")
public class Paiban implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer yishengid;

    private String zhanghao;

    private String xingming;

    private String zhicheng;

    private String shangbanshijian;

    private String xiabanshijian;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getYuyueguahaoCount() {
        return DB.name("yuyueguahao").where("paibanid", id).count();
    }

    public Integer getYishengid() {
        return yishengid;
    }

    public void setYishengid(Integer yishengid) {
        this.yishengid = yishengid == null ? 0 : yishengid;
    }

    public String getZhanghao() {
        return zhanghao;
    }

    public void setZhanghao(String zhanghao) {
        this.zhanghao = zhanghao == null ? "" : zhanghao.trim();
    }

    public String getXingming() {
        return xingming;
    }

    public void setXingming(String xingming) {
        this.xingming = xingming == null ? "" : xingming.trim();
    }

    public String getZhicheng() {
        return zhicheng;
    }

    public void setZhicheng(String zhicheng) {
        this.zhicheng = zhicheng == null ? "" : zhicheng.trim();
    }

    public String getShangbanshijian() {
        return shangbanshijian;
    }

    public void setShangbanshijian(String shangbanshijian) {
        this.shangbanshijian = shangbanshijian == null ? "" : shangbanshijian.trim();
    }

    public String getXiabanshijian() {
        return xiabanshijian;
    }

    public void setXiabanshijian(String xiabanshijian) {
        this.xiabanshijian = xiabanshijian == null ? "" : xiabanshijian.trim();
    }
}
