package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("shiti")
public class Shiti implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer shijuanid;

    private String shijuanbianhao;

    private String shijuanmingcheng;

    private String faburen;

    private String shititimu;

    private String leixing;

    private String daan;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getShijuanid() {
        return shijuanid;
    }

    public void setShijuanid(Integer shijuanid) {
        this.shijuanid = shijuanid == null ? 0 : shijuanid;
    }

    public String getShijuanbianhao() {
        return shijuanbianhao;
    }

    public void setShijuanbianhao(String shijuanbianhao) {
        this.shijuanbianhao = shijuanbianhao == null ? "" : shijuanbianhao.trim();
    }

    public String getShijuanmingcheng() {
        return shijuanmingcheng;
    }

    public void setShijuanmingcheng(String shijuanmingcheng) {
        this.shijuanmingcheng = shijuanmingcheng == null ? "" : shijuanmingcheng.trim();
    }

    public String getFaburen() {
        return faburen;
    }

    public void setFaburen(String faburen) {
        this.faburen = faburen == null ? "" : faburen.trim();
    }

    public String getShititimu() {
        return shititimu;
    }

    public void setShititimu(String shititimu) {
        this.shititimu = shititimu == null ? "" : shititimu.trim();
    }

    public String getLeixing() {
        return leixing;
    }

    public void setLeixing(String leixing) {
        this.leixing = leixing == null ? "" : leixing.trim();
    }

    public String getDaan() {
        return daan;
    }

    public void setDaan(String daan) {
        this.daan = daan == null ? "" : daan.trim();
    }
}
