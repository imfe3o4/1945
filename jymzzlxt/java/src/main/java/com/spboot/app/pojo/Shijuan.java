package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("shijuan")
public class Shijuan implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String shijuanbianhao;

    private String shijuanmingcheng;

    private String datileixing;

    private String tupian;

    private String shichang;

    private String shijuanjianjie;

    private String faburen;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getShitiCount() {
        return DB.name("shiti").where("shijuanid", id).count();
    }

    public Long getJieguoCount() {
        return DB.name("jieguo").where("shijuanid", id).count();
    }

    public Long getChengjiCount() {
        return DB.name("chengji").where("shijuanid", id).count();
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

    public String getDatileixing() {
        return datileixing;
    }

    public void setDatileixing(String datileixing) {
        this.datileixing = datileixing == null ? "" : datileixing.trim();
    }

    public String getTupian() {
        return tupian;
    }

    public void setTupian(String tupian) {
        this.tupian = tupian == null ? "" : tupian.trim();
    }

    public String getShichang() {
        return shichang;
    }

    public void setShichang(String shichang) {
        this.shichang = shichang == null ? "" : shichang.trim();
    }

    public String getShijuanjianjie() {
        return shijuanjianjie;
    }

    public void setShijuanjianjie(String shijuanjianjie) {
        this.shijuanjianjie = shijuanjianjie == null ? "" : shijuanjianjie.trim();
    }

    public String getFaburen() {
        return faburen;
    }

    public void setFaburen(String faburen) {
        this.faburen = faburen == null ? "" : faburen.trim();
    }
}
