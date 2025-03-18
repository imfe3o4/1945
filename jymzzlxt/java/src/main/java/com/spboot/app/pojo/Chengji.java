package com.spboot.app.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jntoo.db.DB;
import java.io.Serializable;
import java.util.*;

@TableName("chengji")
public class Chengji implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer shijuanid;

    private String shijuanbianhao;

    private String shijuanmingcheng;

    private String faburen;

    private String datileixing;

    private String kaoshibianhao;

    private Integer zongdefen;

    private String datiren;

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

    public String getDatileixing() {
        return datileixing;
    }

    public void setDatileixing(String datileixing) {
        this.datileixing = datileixing == null ? "" : datileixing.trim();
    }

    public String getKaoshibianhao() {
        return kaoshibianhao;
    }

    public void setKaoshibianhao(String kaoshibianhao) {
        this.kaoshibianhao = kaoshibianhao == null ? "" : kaoshibianhao.trim();
    }

    public Integer getZongdefen() {
        return zongdefen;
    }

    public void setZongdefen(Integer zongdefen) {
        this.zongdefen = zongdefen == null ? 0 : zongdefen;
    }

    public String getDatiren() {
        return datiren;
    }

    public void setDatiren(String datiren) {
        this.datiren = datiren == null ? "" : datiren.trim();
    }
}
