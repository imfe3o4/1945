package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("yonghu")
public class Yonghu implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String zhanghao;

    //@JsonIgnore // 这个字段不返回前端
    private String mima;

    private String xingming;

    private String xingbie;

    private String shouji;

    private Double jifen;

    private String shenfenzhenghao;

    private String shengao;

    private String tizhong;

    private String hunyinzhuangkuang;

    private String minzu;

    private String xianbingshi;

    private String jiwangbingshi;

    private String jiazubingshi;

    private String touxiang;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getZhanghao() {
        return zhanghao;
    }

    public void setZhanghao(String zhanghao) {
        this.zhanghao = zhanghao == null ? "" : zhanghao.trim();
    }

    public String getMima() {
        return mima;
    }

    public void setMima(String mima) {
        this.mima = mima == null ? "" : mima.trim();
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

    public String getShouji() {
        return shouji;
    }

    public void setShouji(String shouji) {
        this.shouji = shouji == null ? "" : shouji.trim();
    }

    public Double getJifen() {
        return jifen;
    }

    public void setJifen(Double jifen) {
        this.jifen = jifen == null ? 0.0f : jifen;
    }

    public String getShenfenzhenghao() {
        return shenfenzhenghao;
    }

    public void setShenfenzhenghao(String shenfenzhenghao) {
        this.shenfenzhenghao = shenfenzhenghao == null ? "" : shenfenzhenghao.trim();
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

    public String getHunyinzhuangkuang() {
        return hunyinzhuangkuang;
    }

    public void setHunyinzhuangkuang(String hunyinzhuangkuang) {
        this.hunyinzhuangkuang = hunyinzhuangkuang == null ? "" : hunyinzhuangkuang.trim();
    }

    public String getMinzu() {
        return minzu;
    }

    public void setMinzu(String minzu) {
        this.minzu = minzu == null ? "" : minzu.trim();
    }

    public String getXianbingshi() {
        return xianbingshi;
    }

    public void setXianbingshi(String xianbingshi) {
        this.xianbingshi = xianbingshi == null ? "" : xianbingshi.trim();
    }

    public String getJiwangbingshi() {
        return jiwangbingshi;
    }

    public void setJiwangbingshi(String jiwangbingshi) {
        this.jiwangbingshi = jiwangbingshi == null ? "" : jiwangbingshi.trim();
    }

    public String getJiazubingshi() {
        return jiazubingshi;
    }

    public void setJiazubingshi(String jiazubingshi) {
        this.jiazubingshi = jiazubingshi == null ? "" : jiazubingshi.trim();
    }

    public String getTouxiang() {
        return touxiang;
    }

    public void setTouxiang(String touxiang) {
        this.touxiang = touxiang == null ? "" : touxiang.trim();
    }
}
