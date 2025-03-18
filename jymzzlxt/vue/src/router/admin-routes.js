import { session } from "@/utils/utils";

export default [
    {
        path: "pay",
        name: "AdminPay",
        component: () => import("@/views/zhifu/zhifu.vue"),
        meta: { authLogin: true },
    },

    {
        path: "admins",
        name: "AdminadminsList",
        component: () => import("@/views/admins/list.vue"),
        meta: { title: "管理员列表", authLogin: true },
    },

    {
        path: "admins/add",
        name: "AdminadminsAdd",
        component: () => import("@/views/admins/add.vue"),
        meta: { title: "添加管理员", authLogin: true },
    },
    {
        path: "admins/updt",
        name: "AdminadminsUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/admins/updt.vue"),
        meta: { title: "编辑管理员", authLogin: true },
    },
    {
        path: "admins/updtself",
        name: "AdminadminsUpdtSelf",
        props: (route) => ({ id: session("id") }),
        component: () => import("@/views/admins/updtself.vue"),
        meta: { title: "更新个人资料", authLogin: true },
    },
    {
        path: "yisheng",
        name: "AdminyishengList",
        component: () => import("@/views/yisheng/list.vue"),
        meta: { title: "医生列表", authLogin: true },
    },

    {
        path: "yisheng/add",
        name: "AdminyishengAdd",
        component: () => import("@/views/yisheng/add.vue"),
        meta: { title: "添加医生", authLogin: true },
    },
    {
        path: "yisheng/updt",
        name: "AdminyishengUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/yisheng/updt.vue"),
        meta: { title: "编辑医生", authLogin: true },
    },
    {
        path: "yisheng/updtself",
        name: "AdminyishengUpdtSelf",
        props: (route) => ({ id: session("id") }),
        component: () => import("@/views/yisheng/updtself.vue"),
        meta: { title: "更新个人资料", authLogin: true },
    },
    {
        path: "yisheng/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminyishengDetail",
        component: () => import("@/views/yisheng/detail.vue"),
        meta: { title: "医生详情", authLogin: true },
    },
    {
        path: "paiban",
        name: "AdminpaibanList",
        component: () => import("@/views/paiban/list.vue"),
        meta: { title: "排班列表", authLogin: true },
    },

    {
        path: "paiban/zhanghao",
        name: "AdminpaibanListzhanghao",
        component: () => import("@/views/paiban/zhanghao.vue"),
        meta: { title: "排班列表", authLogin: true },
    },

    {
        path: "paiban/add",
        name: "AdminpaibanAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/paiban/add.vue"),
        meta: { title: "添加排班", authLogin: true },
    },
    {
        path: "paiban/updt",
        name: "AdminpaibanUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/paiban/updt.vue"),
        meta: { title: "编辑排班", authLogin: true },
    },
    {
        path: "paiban/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminpaibanDetail",
        component: () => import("@/views/paiban/detail.vue"),
        meta: { title: "排班详情", authLogin: true },
    },
    {
        path: "lunbotu",
        name: "AdminlunbotuList",
        component: () => import("@/views/lunbotu/list.vue"),
        meta: { title: "轮播图列表", authLogin: true },
    },

    {
        path: "lunbotu/add",
        name: "AdminlunbotuAdd",
        component: () => import("@/views/lunbotu/add.vue"),
        meta: { title: "添加轮播图", authLogin: true },
    },
    {
        path: "lunbotu/updt",
        name: "AdminlunbotuUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/lunbotu/updt.vue"),
        meta: { title: "编辑轮播图", authLogin: true },
    },
    {
        path: "yuyueguahao",
        name: "AdminyuyueguahaoList",
        component: () => import("@/views/yuyueguahao/list.vue"),
        meta: { title: "预约挂号列表", authLogin: true },
    },

    {
        path: "yuyueguahao/zhanghao",
        name: "AdminyuyueguahaoListzhanghao",
        component: () => import("@/views/yuyueguahao/zhanghao.vue"),
        meta: { title: "预约挂号列表", authLogin: true },
    },
    {
        path: "yuyueguahao/guahaoren",
        name: "AdminyuyueguahaoListguahaoren",
        component: () => import("@/views/yuyueguahao/guahaoren.vue"),
        meta: { title: "预约挂号列表", authLogin: true },
    },

    {
        path: "yuyueguahao/add",
        name: "AdminyuyueguahaoAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/yuyueguahao/add.vue"),
        meta: { title: "添加预约挂号", authLogin: true },
    },
    {
        path: "yuyueguahao/updt",
        name: "AdminyuyueguahaoUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/yuyueguahao/updt.vue"),
        meta: { title: "编辑预约挂号", authLogin: true },
    },
    {
        path: "yuyueguahao/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminyuyueguahaoDetail",
        component: () => import("@/views/yuyueguahao/detail.vue"),
        meta: { title: "预约挂号详情", authLogin: true },
    },
    {
        path: "xinlizhenliaofangan",
        name: "AdminxinlizhenliaofanganList",
        component: () => import("@/views/xinlizhenliaofangan/list.vue"),
        meta: { title: "心理诊疗方案列表", authLogin: true },
    },

    {
        path: "xinlizhenliaofangan/zhanghao",
        name: "AdminxinlizhenliaofanganListzhanghao",
        component: () => import("@/views/xinlizhenliaofangan/zhanghao.vue"),
        meta: { title: "心理诊疗方案列表", authLogin: true },
    },
    {
        path: "xinlizhenliaofangan/guahaoren",
        name: "AdminxinlizhenliaofanganListguahaoren",
        component: () => import("@/views/xinlizhenliaofangan/guahaoren.vue"),
        meta: { title: "心理诊疗方案列表", authLogin: true },
    },

    {
        path: "xinlizhenliaofangan/add",
        name: "AdminxinlizhenliaofanganAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/xinlizhenliaofangan/add.vue"),
        meta: { title: "添加心理诊疗方案", authLogin: true },
    },
    {
        path: "xinlizhenliaofangan/updt",
        name: "AdminxinlizhenliaofanganUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/xinlizhenliaofangan/updt.vue"),
        meta: { title: "编辑心理诊疗方案", authLogin: true },
    },
    {
        path: "xinlizhenliaofangan/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminxinlizhenliaofanganDetail",
        component: () => import("@/views/xinlizhenliaofangan/detail.vue"),
        meta: { title: "心理诊疗方案详情", authLogin: true },
    },
    {
        path: "yonghu",
        name: "AdminyonghuList",
        component: () => import("@/views/yonghu/list.vue"),
        meta: { title: "用户列表", authLogin: true },
    },

    {
        path: "yonghu/add",
        name: "AdminyonghuAdd",
        component: () => import("@/views/yonghu/add.vue"),
        meta: { title: "添加用户", authLogin: true },
    },
    {
        path: "yonghu/updt",
        name: "AdminyonghuUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/yonghu/updt.vue"),
        meta: { title: "编辑用户", authLogin: true },
    },
    {
        path: "yonghu/updtself",
        name: "AdminyonghuUpdtSelf",
        props: (route) => ({ id: session("id") }),
        component: () => import("@/views/yonghu/updtself.vue"),
        meta: { title: "更新个人资料", authLogin: true },
    },
    {
        path: "shijuan",
        name: "AdminshijuanList",
        component: () => import("@/views/shijuan/list.vue"),
        meta: { title: "试卷列表", authLogin: true },
    },

    {
        path: "shijuan/faburen",
        name: "AdminshijuanListfaburen",
        component: () => import("@/views/shijuan/faburen.vue"),
        meta: { title: "试卷列表", authLogin: true },
    },

    {
        path: "shijuan/add",
        name: "AdminshijuanAdd",
        component: () => import("@/views/shijuan/add.vue"),
        meta: { title: "添加试卷", authLogin: true },
    },
    {
        path: "shijuan/updt",
        name: "AdminshijuanUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/shijuan/updt.vue"),
        meta: { title: "编辑试卷", authLogin: true },
    },
    {
        path: "shijuan/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminshijuanDetail",
        component: () => import("@/views/shijuan/detail.vue"),
        meta: { title: "试卷详情", authLogin: true },
    },
    {
        path: "shiti",
        name: "AdminshitiList",
        component: () => import("@/views/shiti/list.vue"),
        meta: { title: "试题列表", authLogin: true },
    },

    {
        path: "shiti/faburen",
        name: "AdminshitiListfaburen",
        component: () => import("@/views/shiti/faburen.vue"),
        meta: { title: "试题列表", authLogin: true },
    },

    {
        path: "shiti/add",
        name: "AdminshitiAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/shiti/add.vue"),
        meta: { title: "添加试题", authLogin: true },
    },
    {
        path: "shiti/updt",
        name: "AdminshitiUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/shiti/updt.vue"),
        meta: { title: "编辑试题", authLogin: true },
    },
    {
        path: "shiti/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminshitiDetail",
        component: () => import("@/views/shiti/detail.vue"),
        meta: { title: "试题详情", authLogin: true },
    },
    {
        path: "jieguo",
        name: "AdminjieguoList",
        component: () => import("@/views/jieguo/list.vue"),
        meta: { title: "结果列表", authLogin: true },
    },

    {
        path: "jieguo/faburen",
        name: "AdminjieguoListfaburen",
        component: () => import("@/views/jieguo/faburen.vue"),
        meta: { title: "结果列表", authLogin: true },
    },
    {
        path: "jieguo/datiren",
        name: "AdminjieguoListdatiren",
        component: () => import("@/views/jieguo/datiren.vue"),
        meta: { title: "结果列表", authLogin: true },
    },

    {
        path: "jieguo/add",
        name: "AdminjieguoAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/jieguo/add.vue"),
        meta: { title: "添加结果", authLogin: true },
    },
    {
        path: "jieguo/updt",
        name: "AdminjieguoUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/jieguo/updt.vue"),
        meta: { title: "编辑结果", authLogin: true },
    },
    {
        path: "jieguo/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminjieguoDetail",
        component: () => import("@/views/jieguo/detail.vue"),
        meta: { title: "结果详情", authLogin: true },
    },
    {
        path: "chengji",
        name: "AdminchengjiList",
        component: () => import("@/views/chengji/list.vue"),
        meta: { title: "成绩列表", authLogin: true },
    },

    {
        path: "chengji/faburen",
        name: "AdminchengjiListfaburen",
        component: () => import("@/views/chengji/faburen.vue"),
        meta: { title: "成绩列表", authLogin: true },
    },
    {
        path: "chengji/datiren",
        name: "AdminchengjiListdatiren",
        component: () => import("@/views/chengji/datiren.vue"),
        meta: { title: "成绩列表", authLogin: true },
    },

    {
        path: "chengji/add",
        name: "AdminchengjiAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/chengji/add.vue"),
        meta: { title: "添加成绩", authLogin: true },
    },
    {
        path: "chengji/updt",
        name: "AdminchengjiUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/chengji/updt.vue"),
        meta: { title: "编辑成绩", authLogin: true },
    },
    {
        path: "chengji/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminchengjiDetail",
        component: () => import("@/views/chengji/detail.vue"),
        meta: { title: "成绩详情", authLogin: true },
    },
    {
        path: "wenzhang",
        name: "AdminwenzhangList",
        component: () => import("@/views/wenzhang/list.vue"),
        meta: { title: "文章列表", authLogin: true },
    },

    {
        path: "wenzhang/tianjiaren",
        name: "AdminwenzhangListtianjiaren",
        component: () => import("@/views/wenzhang/tianjiaren.vue"),
        meta: { title: "文章列表", authLogin: true },
    },

    {
        path: "wenzhang/add",
        name: "AdminwenzhangAdd",
        component: () => import("@/views/wenzhang/add.vue"),
        meta: { title: "添加文章", authLogin: true },
    },
    {
        path: "wenzhang/updt",
        name: "AdminwenzhangUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/wenzhang/updt.vue"),
        meta: { title: "编辑文章", authLogin: true },
    },
    {
        path: "wenzhang/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminwenzhangDetail",
        component: () => import("@/views/wenzhang/detail.vue"),
        meta: { title: "文章详情", authLogin: true },
    },
    {
        path: "liuyanban",
        name: "AdminliuyanbanList",
        component: () => import("@/views/liuyanban/list.vue"),
        meta: { title: "留言板列表", authLogin: true },
    },

    {
        path: "liuyanban/zhanghao",
        name: "AdminliuyanbanListzhanghao",
        component: () => import("@/views/liuyanban/zhanghao.vue"),
        meta: { title: "留言板列表", authLogin: true },
    },
    {
        path: "liuyanban/liuyanren",
        name: "AdminliuyanbanListliuyanren",
        component: () => import("@/views/liuyanban/liuyanren.vue"),
        meta: { title: "留言板列表", authLogin: true },
    },

    {
        path: "liuyanban/add",
        name: "AdminliuyanbanAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/liuyanban/add.vue"),
        meta: { title: "添加留言板", authLogin: true },
    },
    {
        path: "liuyanban/updt",
        name: "AdminliuyanbanUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/liuyanban/updt.vue"),
        meta: { title: "编辑留言板", authLogin: true },
    },
    {
        path: "tongzhi",
        name: "AdmintongzhiList",
        component: () => import("@/views/tongzhi/list.vue"),
        meta: { title: "通知列表", authLogin: true },
    },

    {
        path: "tongzhi/zhanghao",
        name: "AdmintongzhiListzhanghao",
        component: () => import("@/views/tongzhi/zhanghao.vue"),
        meta: { title: "通知列表", authLogin: true },
    },

    {
        path: "tongzhi/add",
        name: "AdmintongzhiAdd",
        component: () => import("@/views/tongzhi/add.vue"),
        meta: { title: "添加通知", authLogin: true },
    },
    {
        path: "tongzhi/updt",
        name: "AdmintongzhiUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/tongzhi/updt.vue"),
        meta: { title: "编辑通知", authLogin: true },
    },
    {
        path: "tongzhi/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdmintongzhiDetail",
        component: () => import("@/views/tongzhi/detail.vue"),
        meta: { title: "通知详情", authLogin: true },
    },
    {
        path: "gerenjiankangshuju",
        name: "AdmingerenjiankangshujuList",
        component: () => import("@/views/gerenjiankangshuju/list.vue"),
        meta: { title: "个人健康数据列表", authLogin: true },
    },

    {
        path: "gerenjiankangshuju/yonghu",
        name: "AdmingerenjiankangshujuListyonghu",
        component: () => import("@/views/gerenjiankangshuju/yonghu.vue"),
        meta: { title: "个人健康数据列表", authLogin: true },
    },

    {
        path: "gerenjiankangshuju/add",
        name: "AdmingerenjiankangshujuAdd",
        component: () => import("@/views/gerenjiankangshuju/add.vue"),
        meta: { title: "添加个人健康数据", authLogin: true },
    },
    {
        path: "gerenjiankangshuju/updt",
        name: "AdmingerenjiankangshujuUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/gerenjiankangshuju/updt.vue"),
        meta: { title: "编辑个人健康数据", authLogin: true },
    },
    {
        path: "gerenjiankangshuju/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdmingerenjiankangshujuDetail",
        component: () => import("@/views/gerenjiankangshuju/detail.vue"),
        meta: { title: "个人健康数据详情", authLogin: true },
    },
    {
        path: "leibie",
        name: "AdminleibieList",
        component: () => import("@/views/leibie/list.vue"),
        meta: { title: "类别列表", authLogin: true },
    },

    {
        path: "leibie/add",
        name: "AdminleibieAdd",
        component: () => import("@/views/leibie/add.vue"),
        meta: { title: "添加类别", authLogin: true },
    },
    {
        path: "leibie/updt",
        name: "AdminleibieUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/leibie/updt.vue"),
        meta: { title: "编辑类别", authLogin: true },
    },
    {
        path: "yaopin",
        name: "AdminyaopinList",
        component: () => import("@/views/yaopin/list.vue"),
        meta: { title: "药品列表", authLogin: true },
    },

    {
        path: "yaopin/tianjiaren",
        name: "AdminyaopinListtianjiaren",
        component: () => import("@/views/yaopin/tianjiaren.vue"),
        meta: { title: "药品列表", authLogin: true },
    },

    {
        path: "yaopin/add",
        name: "AdminyaopinAdd",
        component: () => import("@/views/yaopin/add.vue"),
        meta: { title: "添加药品", authLogin: true },
    },
    {
        path: "yaopin/updt",
        name: "AdminyaopinUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/yaopin/updt.vue"),
        meta: { title: "编辑药品", authLogin: true },
    },
    {
        path: "yaopin/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdminyaopinDetail",
        component: () => import("@/views/yaopin/detail.vue"),
        meta: { title: "药品详情", authLogin: true },
    },
    {
        path: "gouwuche",
        name: "AdmingouwucheList",
        component: () => import("@/views/gouwuche/list.vue"),
        meta: { title: "购物车列表", authLogin: true },
    },

    {
        path: "gouwuche/goumairen",
        name: "AdmingouwucheListgoumairen",
        component: () => import("@/views/gouwuche/goumairen.vue"),
        meta: { title: "购物车列表", authLogin: true },
    },

    {
        path: "gouwuche/add",
        name: "AdmingouwucheAdd",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/gouwuche/add.vue"),
        meta: { title: "添加购物车", authLogin: true },
    },
    {
        path: "gouwuche/updt",
        name: "AdmingouwucheUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/gouwuche/updt.vue"),
        meta: { title: "编辑购物车", authLogin: true },
    },
    {
        path: "dingdan",
        name: "AdmindingdanList",
        component: () => import("@/views/dingdan/list.vue"),
        meta: { title: "订单列表", authLogin: true },
    },

    {
        path: "dingdan/xiadanren",
        name: "AdmindingdanListxiadanren",
        component: () => import("@/views/dingdan/xiadanren.vue"),
        meta: { title: "订单列表", authLogin: true },
    },

    {
        path: "dingdan/add",
        name: "AdmindingdanAdd",
        component: () => import("@/views/dingdan/add.vue"),
        meta: { title: "添加订单", authLogin: true },
    },
    {
        path: "dingdan/updt",
        name: "AdmindingdanUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/dingdan/updt.vue"),
        meta: { title: "编辑订单", authLogin: true },
    },
    {
        path: "dingdan/detail",
        props: (route) => ({ id: route.query.id }),
        name: "AdmindingdanDetail",
        component: () => import("@/views/dingdan/detail.vue"),
        meta: { title: "订单详情", authLogin: true },
    },
    {
        path: "shouhuodizhi",
        name: "AdminshouhuodizhiList",
        component: () => import("@/views/shouhuodizhi/list.vue"),
        meta: { title: "收货地址列表", authLogin: true },
    },

    {
        path: "shouhuodizhi/tianjiaren",
        name: "AdminshouhuodizhiListtianjiaren",
        component: () => import("@/views/shouhuodizhi/tianjiaren.vue"),
        meta: { title: "收货地址列表", authLogin: true },
    },

    {
        path: "shouhuodizhi/add",
        name: "AdminshouhuodizhiAdd",
        component: () => import("@/views/shouhuodizhi/add.vue"),
        meta: { title: "添加收货地址", authLogin: true },
    },
    {
        path: "shouhuodizhi/updt",
        name: "AdminshouhuodizhiUpdt",
        props: (route) => ({ id: route.query.id }),
        component: () => import("@/views/shouhuodizhi/updt.vue"),
        meta: { title: "编辑收货地址", authLogin: true },
    },
];
