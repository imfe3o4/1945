package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("gerenjiankangshuju")
public class Gerenjiankangshuju implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String xingming;

    private String xingbie;

    private String shengao;

    private String tizhong;

    private String riqi;

    private Double shuzhangya;

    private Double shousuoya;

    private Double xuetang;

    private Double xinlv;

    private String beizhu;

    private String yonghu;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getXingming() {
        return xingming;
    }

    public void setXingming(String xingming) {
        this.xingming = xingming == null ? "" : xingming.trim();
    }

    public String getXingbie() {
        return xingbie;
    }

    public void setXingbie(String xingbie) {
        this.xingbie = xingbie == null ? "" : xingbie.trim();
    }

    public String getShengao() {
        return shengao;
    }

    public void setShengao(String shengao) {
        this.shengao = shengao == null ? "" : shengao.trim();
    }

    public String getTizhong() {
        return tizhong;
    }

    public void setTizhong(String tizhong) {
        this.tizhong = tizhong == null ? "" : tizhong.trim();
    }

    public String getRiqi() {
        return riqi;
    }

    public void setRiqi(String riqi) {
        this.riqi = riqi == null ? "" : riqi.trim();
    }

    public Double getShuzhangya() {
        return shuzhangya;
    }

    public void setShuzhangya(Double shuzhangya) {
        this.shuzhangya = shuzhangya == null ? 0.0f : shuzhangya;
    }

    public Double getShousuoya() {
        return shousuoya;
    }

    public void setShousuoya(Double shousuoya) {
        this.shousuoya = shousuoya == null ? 0.0f : shousuoya;
    }

    public Double getXuetang() {
        return xuetang;
    }

    public void setXuetang(Double xuetang) {
        this.xuetang = xuetang == null ? 0.0f : xuetang;
    }

    public Double getXinlv() {
        return xinlv;
    }

    public void setXinlv(Double xinlv) {
        this.xinlv = xinlv == null ? 0.0f : xinlv;
    }

    public String getBeizhu() {
        return beizhu;
    }

    public void setBeizhu(String beizhu) {
        this.beizhu = beizhu == null ? "" : beizhu.trim();
    }

    public String getYonghu() {
        return yonghu;
    }

    public void setYonghu(String yonghu) {
        this.yonghu = yonghu == null ? "" : yonghu.trim();
    }
}
