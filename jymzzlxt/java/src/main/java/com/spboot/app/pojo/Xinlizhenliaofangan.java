package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("xinlizhenliaofangan")
public class Xinlizhenliaofangan implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer yuyueguahaoid;

    private Integer paibanid;

    private Integer yishengid;

    private String zhanghao;

    private String xingming;

    private String zhicheng;

    private String huanzhexingming;

    private Integer nianling;

    private String guahaoren;

    private String zhenliaofangan;

    private String chufang;

    private String addtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getYuyueguahaoid() {
        return yuyueguahaoid;
    }

    public void setYuyueguahaoid(Integer yuyueguahaoid) {
        this.yuyueguahaoid = yuyueguahaoid == null ? 0 : yuyueguahaoid;
    }

    public Integer getPaibanid() {
        return paibanid;
    }

    public void setPaibanid(Integer paibanid) {
        this.paibanid = paibanid == null ? 0 : paibanid;
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

    public String getHuanzhexingming() {
        return huanzhexingming;
    }

    public void setHuanzhexingming(String huanzhexingming) {
        this.huanzhexingming = huanzhexingming == null ? "" : huanzhexingming.trim();
    }

    public Integer getNianling() {
        return nianling;
    }

    public void setNianling(Integer nianling) {
        this.nianling = nianling == null ? 0 : nianling;
    }

    public String getGuahaoren() {
        return guahaoren;
    }

    public void setGuahaoren(String guahaoren) {
        this.guahaoren = guahaoren == null ? "" : guahaoren.trim();
    }

    public String getZhenliaofangan() {
        return zhenliaofangan;
    }

    public void setZhenliaofangan(String zhenliaofangan) {
        this.zhenliaofangan = zhenliaofangan == null ? "" : zhenliaofangan.trim();
    }

    public String getChufang() {
        return chufang;
    }

    public void setChufang(String chufang) {
        this.chufang = chufang == null ? "" : chufang.trim();
    }

    public String getAddtime() {
        return addtime;
    }

    public void setAddtime(String addtime) {
        this.addtime = addtime == null ? "" : addtime.trim();
    }
}
